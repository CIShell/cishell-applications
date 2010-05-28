package edu.iu.scipolicy.database.nsf.load;

import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.sql.SQLException;
import java.util.Dictionary;

import org.cishell.framework.CIShellContext;
import org.cishell.framework.algorithm.Algorithm;
import org.cishell.framework.algorithm.AlgorithmCanceledException;
import org.cishell.framework.algorithm.AlgorithmExecutionException;
import org.cishell.framework.algorithm.ProgressMonitor;
import org.cishell.framework.algorithm.ProgressTrackable;
import org.cishell.framework.data.BasicData;
import org.cishell.framework.data.Data;
import org.cishell.framework.data.DataProperty;
import org.cishell.service.database.Database;
import org.cishell.service.database.DatabaseCreationException;
import org.cishell.service.database.DatabaseService;
import org.cishell.utilities.FileUtilities;
import org.osgi.service.log.LogService;

import au.com.bytecode.opencsv.CSVReader;
import edu.iu.cns.database.load.framework.utilities.DatabaseModel;
import edu.iu.cns.database.load.framework.utilities.DerbyDatabaseCreator;
import edu.iu.scipolicy.database.nsf.load.exception.NSFDatabaseCreationException;
import edu.iu.scipolicy.database.nsf.load.exception.NSFReadingException;
import edu.iu.scipolicy.database.nsf.load.utilities.NSFMetadata;
import edu.iu.scipolicy.database.nsf.load.utilities.NSFTableModelParser;
import edu.iu.scipolicy.utilities.nsf.NSF_CSV_FieldNames;
import edu.iu.scipolicy.utilities.nsf.NSF_Database_FieldNames;

/**
 * @author cdtank
 *
 */

public class NSFDatabaseLoaderAlgorithm implements Algorithm, ProgressTrackable {
	
	private Data[] data;
	private LogService logger;
	private DatabaseService databaseProvider;
	private ProgressMonitor progressMonitor = ProgressMonitor.NULL_MONITOR;
	
    public NSFDatabaseLoaderAlgorithm(
    		Data[] data, Dictionary parameters, CIShellContext context) {
        this.data = data;
		this.logger = (LogService) context.getService(LogService.class.getName());
        this.databaseProvider =
        	(DatabaseService) context.getService(DatabaseService.class.getName());
	}

    public Data[] execute() throws AlgorithmExecutionException {
    	/*
    	 * Get the file data.
    	 */

    	String fileName = (String)data[0].getData();
		File nsfCSVFile = new File(fileName);
		
		try {
			/*
			 * Create in-memory nsf model with all its entities & relationships.
			 */
			DatabaseModel inMemoryModel = createInMemoryNSFModel(nsfCSVFile, logger);
			
			/*
			 * Extract the actual database from the in-memory model. 
			 */
			Database database = convertNSFInMemoryModelToDatabase(inMemoryModel);
			
			/*
			 * Provide the finished database in the data manager.
			 */
			return annotateOutputData(database, data[0]);
		} catch (AlgorithmCanceledException e) {
			return new Data[] {};
		} catch (IOException e) {
			throw new AlgorithmExecutionException(e.getMessage(), e);
		} catch (NSFReadingException e) {
			throw new AlgorithmExecutionException(e.getMessage(), e);
		} catch (NSFDatabaseCreationException e) {
			throw new AlgorithmExecutionException(e.getMessage(), e);
		} 
    }

    public void setProgressMonitor(ProgressMonitor progressMonitor) {
    	this.progressMonitor = progressMonitor;
    }

    public ProgressMonitor getProgressMonitor() {
    	return this.progressMonitor;
    }

	/**
	 * @param database
	 * @return
	 */
	@SuppressWarnings("unchecked")
	private Data[] annotateOutputData(Database database, Data parentData) {
		Data output = new BasicData(database, NSF_Database_FieldNames.NSF_DATABASE_MIME_TYPE);
//		Dictionary<String, Object> parentMetadata = data[0].getMetadata();
		Dictionary<String, Object> metadata = output.getMetadata();
		metadata.put(
			DataProperty.LABEL,
			"NSF Database From " +
				FileUtilities.extractFileNameWithExtension((String)parentData.getData()));
//			DataProperty.LABEL, "NSF Database From " + parentMetadata.get(DataProperty.LABEL));
		metadata.put(DataProperty.TYPE, DataProperty.DATABASE_TYPE);
		metadata.put(DataProperty.PARENT, data[0]);
		
		return new Data[] { output };
	}

	/**
	 * @param nsfCSVFile
	 * @param nsfCSVReader
	 * @param logger 
	 * @return
	 * @throws AlgorithmExecutionException
	 * @throws IOException
	 */
	private DatabaseModel createInMemoryNSFModel(File nsfCSVFile, LogService logger)
			throws AlgorithmCanceledException, IOException, NSFReadingException {
		CSVReader nsfCSVReader = createNSF_CSVReader(nsfCSVFile);
		String[] nsfFileColumnNames = getNSFFileColumnNames(nsfCSVReader);

		NSFMetadata nsfMetadata =
			new NSFMetadata(nsfFileColumnNames, nsfCSVFile, createNSF_CSVReader(nsfCSVFile));

		try {
			startProgressMonitorForModelCreation(nsfMetadata.getRowCount());
			DatabaseModel model = new NSFTableModelParser().parseModel(
				nsfCSVReader, nsfMetadata, logger, this.progressMonitor);
			stopProgressMonitorForModelCreation();

			return model;
		} catch (IOException e) {
			throw new NSFReadingException(e.getMessage(), e);
		}
	}

	/**
	 * @param inMemoryModel
	 * @return
	 * @throws AlgorithmExecutionException 
	 * @throws DatabaseCreationException
	 * @throws SQLException
	 */
	private Database convertNSFInMemoryModelToDatabase(
			DatabaseModel inMemoryModel) throws NSFDatabaseCreationException {
		try {
			this.logger.log(
    			LogService.LOG_INFO, "Beginning Phase 2 of loading the NSF file into a database.");

			return DerbyDatabaseCreator.createFromModel(
				databaseProvider, inMemoryModel, "NSF", this.progressMonitor);
		} catch (AlgorithmCanceledException e) {
			throw new NSFDatabaseCreationException(e.getMessage(), e);
		} catch (DatabaseCreationException e) {
			throw new NSFDatabaseCreationException(e.getMessage(), e); 
		} catch (SQLException e) {
			throw new NSFDatabaseCreationException(e.getMessage(), e); 
		}
	}

	private void startProgressMonitorForModelCreation(int rowCount) {
    	this.logger.log(
    		LogService.LOG_INFO, "Beginning Phase 1 of loading the NSF file into a database.");
    	// rowCount - 1 to account for the header row.
    	int workUnitCountForCreatingModel = rowCount - 1;
		this.progressMonitor.start(
			(ProgressMonitor.WORK_TRACKABLE |
				ProgressMonitor.CANCELLABLE |
				ProgressMonitor.PAUSEABLE),
			workUnitCountForCreatingModel);
		this.progressMonitor.describeWork("Parsing ISI data.");
    }

    private void stopProgressMonitorForModelCreation() {
    	this.progressMonitor.done();
    }

	private static CSVReader createNSF_CSVReader(File nsfCsv) throws IOException {
		// TODO: Currently we only support "csv" nsf files, not "excel" nsf files.
		// TODO: Add flexibility to support tabbed separated and double-quote escape chars.
		final char defaultFieldSeparator = ',';
		final char secondaryFieldSeparator = '\t';
		final char fieldQuoteCharacter = '"';
		final int lineToStartReadingFrom = 0;
		final char quoteEscapeCharacter = '\\';
		
		CSVReader nsfCsvReader = new CSVReader(
			new FileReader(nsfCsv),
			defaultFieldSeparator, 
			fieldQuoteCharacter, 
			lineToStartReadingFrom, 
			quoteEscapeCharacter);
		
		/*
		 * Test if "," as a separator failed to create appropriate csv handler. If so create a
		 * new csv handler by using "\t" as the field separator.
		 * TODO: If this approach seems inefficient refactor to use better approach or library
		 * since the current library is not flexible enough. 
		 * */
		if (nsfCsvReader.readNext().length < NSF_CSV_FieldNames.CSV.DEFAULT_TOTAL_NSF_FIELDS) {
			return new CSVReader(new FileReader(nsfCsv),
								 secondaryFieldSeparator, 
								 fieldQuoteCharacter, 
								 lineToStartReadingFrom, 
								 quoteEscapeCharacter);
		} else {
			return new CSVReader(new FileReader(nsfCsv),
								 defaultFieldSeparator, 
								 fieldQuoteCharacter, 
								 lineToStartReadingFrom, 
								 quoteEscapeCharacter);
		}
	}
	
	private static String[] getNSFFileColumnNames(CSVReader nsfCSVReader) 
			throws NSFReadingException {
		try {
			String[] columnNames = nsfCSVReader.readNext();
			
			if (columnNames == null || columnNames.length == 0) {
				throw new NSFReadingException("Cannot read in an empty nsf file");
			}
			
			return columnNames;
			
		} catch (IOException e) {
			throw new NSFReadingException(e.getMessage(), e);
		}
	}
}