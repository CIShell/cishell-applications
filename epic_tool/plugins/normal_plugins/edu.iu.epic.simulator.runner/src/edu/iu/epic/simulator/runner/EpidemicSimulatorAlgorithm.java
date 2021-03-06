package edu.iu.epic.simulator.runner;

import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;
import java.text.ParseException;
import java.util.Dictionary;
import java.util.Hashtable;
import java.util.Map;
import java.util.Map.Entry;

import org.antlr.stringtemplate.StringTemplateGroup;
import org.cishell.framework.CIShellContext;
import org.cishell.framework.algorithm.Algorithm;
import org.cishell.framework.algorithm.AlgorithmExecutionException;
import org.cishell.framework.data.BasicData;
import org.cishell.framework.data.Data;
import org.cishell.framework.data.DataProperty;
import org.cishell.utilities.AlgorithmUtilities;
import org.osgi.framework.BundleContext;
import org.osgi.service.log.LogService;

import com.google.common.collect.Maps;

import edu.iu.epic.modeling.compartment.model.Model;
import edu.iu.epic.simulator.runner.utility.CIShellParameterUtilities;
import edu.iu.epic.simulator.runner.utility.preprocessing.InFileMaker;
import edu.iu.epic.simulator.runner.utility.preprocessing.InfectionsFileMaker;
import edu.iu.epic.simulator.runner.utility.preprocessing.NetworkFileMaker;
import edu.iu.epic.simulator.runner.utility.preprocessing.SimulatorModelFileMaker;

public abstract class EpidemicSimulatorAlgorithm implements Algorithm {
	public static final String PLAIN_TEXT_MIME_TYPE = "file:text/plain";
	public static final String CSV_MIME_TYPE = "file:text/csv";
	
	protected Data[] data;
	protected Dictionary<String, Object> parameters;
	protected CIShellContext ciContext;
	protected BundleContext bundleContext;
	protected File nwbFile;
	protected static LogService logger;

	
	public EpidemicSimulatorAlgorithm(
			Data[] data,
			Dictionary<String, Object> parameters,
			CIShellContext ciContext,
			BundleContext bundleContext) {
		this.data = data;		
		this.parameters = parameters;
		this.ciContext = ciContext;
		this.bundleContext = bundleContext;
		
		EpidemicSimulatorAlgorithm.logger =
			(LogService) ciContext.getService(LogService.class.getName());
	}
	
	
	public Data[] execute() throws AlgorithmExecutionException {		
		Data[] simulationOutputData;
		try {
			Data[] simulatorInputData =
				createSimulatorInputData(this.data, this.parameters);
			simulationOutputData = executeSimulator(simulatorInputData, ciContext, bundleContext);			
		} catch (IOException e) {
			throw new AlgorithmExecutionException(
					"Error formatting input data for simulation: " + e.getMessage(), e);
		} catch (ParseException e) {
			throw new AlgorithmExecutionException(
					"Error parsing the given start date: " + e.getMessage(), e);
		}
		
		return prepareForDataManager(simulationOutputData);
	}


	protected abstract Data[] prepareForDataManager(Data[] simulationOutputData)
		throws AlgorithmExecutionException;

	private Data[] createSimulatorInputData(
			Data[] runnerData, Dictionary<String, Object> runnerParameters)
				throws IOException, ParseException, AlgorithmExecutionException {
		/* Fetch the infector seed populations from the algorithm parameters. */
		Map<String, Object> rawInfectorSeedPopulations =
			CIShellParameterUtilities.filterByAndStripIDPrefixes(
					runnerParameters,
					EpidemicSimulatorAlgorithmFactory.INFECTOR_SEED_POPULATION_PREFIX);
		Map<String, Integer> infectorSeedPopulations = Maps.newHashMap();
		for (Entry<String, Object> rawInfectorSeedPopulation
						: rawInfectorSeedPopulations.entrySet()) {
			infectorSeedPopulations.put(
					rawInfectorSeedPopulation.getKey(),
					(Integer) rawInfectorSeedPopulation.getValue());
		}
		
		
		/* Fetch the compartment initial distribution from the algorithm parameters. */
		Map<String, Object> rawInitialDistribution =
			CIShellParameterUtilities.filterByAndStripIDPrefixes(
					runnerParameters,
					EpidemicSimulatorAlgorithmFactory.INITIAL_DISTRIBUTION_PREFIX);
		Map<String, Float> initialDistribution = Maps.newHashMap();
		for (Entry<String, Object> rawCompartmentFraction : rawInitialDistribution.entrySet()) {
			initialDistribution.put(
					rawCompartmentFraction.getKey(),
					(Float) rawCompartmentFraction.getValue());
		}
		
		float distributionTotal = InFileMaker.total(initialDistribution.values());
		if (!(Math.abs(distributionTotal - 1.0f) < 1e-3f)) { // TODO Need to know tolerance of core code.
			String message = String.format(
					"The fractions for the initial distribution of the population among the "
					+ "compartments must sum to exactly 1.0.  The given numbers summed to %f.",
					distributionTotal);
			throw new AlgorithmExecutionException(message);
		}
		
		
		// Create the simulator model file from the EpiC model file.
		Model epicModel = (Model) runnerData[0].getData();
		SimulatorModelFileMaker simulatorModelFileMaker =
			new SimulatorModelFileMaker(epicModel, runnerParameters);		
		File simulatorModelFile = simulatorModelFileMaker.make();		
	
		
		// Create the infections file.
		InfectionsFileMaker infectionsFileMaker = new InfectionsFileMaker();
		File infectionsFile = infectionsFileMaker.make(infectorSeedPopulations);
	
		
		/* If the runnerData includes a File as a second element,
		 * we assume that it is a network. */
		String simulatorNetworkFilePath = null;
		if (runnerData.length >= 2) {
			File runnerNetworkFile = (File) runnerData[1].getData();
			this.nwbFile = runnerNetworkFile;
			File simulatorNetworkFile =
				NetworkFileMaker.make(runnerNetworkFile);
			simulatorNetworkFilePath = simulatorNetworkFile.getPath();
		}
		
		
		// Create the .in file.
		String initialCompartmentName =
			(String) runnerParameters.get(
					EpidemicSimulatorAlgorithmFactory.INITIAL_COMPARTMENT_PARAMETER_ID);
		InFileMaker inFileMaker =
			new InFileMaker(
					simulatorModelFile.getPath(),
					simulatorNetworkFilePath,
					runnerParameters,
					initialCompartmentName,
					infectionsFile,
					initialDistribution);
		File inFile = inFileMaker.make();
		
	
		return new Data[] {	new BasicData(inFile, InFileMaker.IN_FILE_MIME_TYPE) };
	}


	protected abstract String getCoreAlgorithmPID();

	private Data[] executeSimulator(
			Data[] coreData, CIShellContext coreCIContext, BundleContext coreBundleContext)
				throws AlgorithmExecutionException {
		try {			
			return
				AlgorithmUtilities.executeAlgorithm(
					AlgorithmUtilities.getAlgorithmFactoryByPID(
							getCoreAlgorithmPID(), coreBundleContext),
					null,
					coreData,
					new Hashtable<String, Object>(),
					coreCIContext);
		} catch (AlgorithmExecutionException e) {
			throw new AlgorithmExecutionException(
				"Error running simulator: " + e.getMessage(), e);
		}
	}

	protected static Data datafyCsvFile(File csvFile, String label, Data parentData) {
		Data outData = new BasicData(csvFile, CSV_MIME_TYPE);
		
		Dictionary<String, Object> metadata = outData.getMetadata();
		metadata.put(DataProperty.LABEL, label);
		metadata.put(DataProperty.TYPE, DataProperty.TABLE_TYPE);
		metadata.put(DataProperty.PARENT, parentData);
		
		return outData;
	}

	public static StringTemplateGroup loadTemplates(String templatePath) {
		return new StringTemplateGroup(
				new InputStreamReader(
						EpidemicSimulatorAlgorithm.class.getResourceAsStream(templatePath)));
	}

	public static LogService getLogger() {
		return logger;
	}
}
