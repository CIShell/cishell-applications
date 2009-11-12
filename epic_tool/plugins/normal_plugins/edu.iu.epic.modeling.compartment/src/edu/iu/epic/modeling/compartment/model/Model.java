package edu.iu.epic.modeling.compartment.model;

import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.HashSet;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.LinkedHashSet;
import java.util.Map;
import java.util.Set;
import java.util.Map.Entry;

import org.antlr.runtime.RecognitionException;
import org.antlr.stringtemplate.StringTemplate;
import org.antlr.stringtemplate.StringTemplateGroup;

import edu.iu.epic.modeling.compartment.converters.text.SystemErrCapturer;
import edu.iu.epic.modeling.compartment.grammar.parsing.ModelFileParser;
import edu.iu.epic.modeling.compartment.grammar.parsing.ModelFileParser.UncheckedParsingException;
import edu.iu.epic.modeling.compartment.model.exception.CompartmentDoesNotExistException;
import edu.iu.epic.modeling.compartment.model.exception.CompartmentExistsException;
import edu.iu.epic.modeling.compartment.model.exception.InvalidCompartmentNameException;
import edu.iu.epic.modeling.compartment.model.exception.InvalidParameterExpressionException;
import edu.iu.epic.modeling.compartment.model.exception.InvalidParameterNameException;
import edu.iu.epic.modeling.compartment.model.exception.MultipleSusceptibleCompartmentsException;

/* TODO: Create an interface for Model.  Create some sort of immutable notion of a Model as well
 * and pass that between algorithms rather than the mutable model.  Take care of the desire to
 * rename compartments of even immutable models.  Ask Russell or Joseph.
 */
public class Model {
	private static StringTemplateGroup modelFileTemplateGroup =
		loadTemplates("/edu/iu/epic/modeling/compartment/grammar/modelFile.st");

	private Map<String, Compartment> compartments = new LinkedHashMap<String, Compartment>();
	private Set<Transition> transitions = new LinkedHashSet<Transition>();
	private Map<String, String> parameterDefinitions = new LinkedHashMap<String, String>();

	public Map<String, String> getParameterDefinitions() {
		return parameterDefinitions;
	}

	public Collection<Compartment> getCompartments() {
		return Collections.unmodifiableCollection(compartments.values());
	}

	public Compartment getCompartment(String name) throws CompartmentDoesNotExistException {
		if (compartments.containsKey(name)) {
			return compartments.get(name);
		} else {
			throw new CompartmentDoesNotExistException("Model has no compartment named '" + name
					+ "'.");
		}
	}

	// public synchronized Compartment getOrAddCompartment(String name)
	// throws CompartmentExistsException {
	// if (compartments.containsKey(name)) {
	// return compartments.get(name);
	// } else {
	// return addCompartment(name);
	// }
	// }

	public synchronized Compartment addCompartment(String name, Compartment.Type type)
			throws CompartmentExistsException, MultipleSusceptibleCompartmentsException,
			InvalidCompartmentNameException {
		Utility.checkForNullArgument("name", name);

		if (compartments.containsKey(name)) {
			throw new CompartmentExistsException(name);
		}

		if (isValidCompartmentName(name)) {
			if (type.equals(Compartment.Type.SUSCEPTIBLE)
					&& (!getCompartments(Compartment.Type.SUSCEPTIBLE).isEmpty())) {
				throw new MultipleSusceptibleCompartmentsException();
			}

			Compartment compartment = new Compartment(this, name, type);
			this.compartments.put(name, compartment);
			
			return compartment;
		} else {
			throw new InvalidCompartmentNameException(name);
		}
	}

	public synchronized RatioTransition addRatioTransition(Compartment source,
			Compartment target, String ratio, boolean isSecondary)
			throws InvalidParameterExpressionException {
		Utility.checkForNullArgument("source", source);
		Utility.checkForNullArgument("target", target);
		Utility.checkForNullArgument("ratio", ratio);
		if (!isValidParameterExpression(ratio)) {
			throw new InvalidParameterExpressionException(ratio);
		}
		Utility.checkForNullArgument("isSecondary", isSecondary);

		RatioTransition transition = new RatioTransition(source, target, ratio,
				isSecondary);
		this.transitions.add(transition);
		return transition;
	}

	public synchronized InfectionTransition addInfectionTransition(Compartment source,
			Compartment infector, Compartment target, String ratio,
			boolean isSecondary) throws InvalidParameterExpressionException {
		Utility.checkForNullArgument("source", source);
		Utility.checkForNullArgument("infector", infector);
		Utility.checkForNullArgument("target", target);
		Utility.checkForNullArgument("ratio", ratio);
		if (!isValidParameterExpression(ratio)) {
			throw new InvalidParameterExpressionException(ratio);
		}
		Utility.checkForNullArgument("isSecondary", isSecondary);

		InfectionTransition transition = new InfectionTransition(source, infector, target,
				ratio, isSecondary);
		this.transitions.add(transition);
		return transition;
	}

	public synchronized void setParameterDefinition(String name, String value)
			throws InvalidParameterExpressionException, InvalidParameterNameException {
		Utility.checkForNullArgument("name", name);
		if (!isValidParameterName(name)) {
			throw new InvalidParameterNameException(name);
		}
		
		// Don't need to check expression; null isn't a valid definition
		if (!isValidParameterExpression(value)) {
			throw new InvalidParameterExpressionException(value);
		}
		// TODO: check for cycles in dependency graph?
		this.parameterDefinitions.put(name, value);
	}

	private boolean isValidParameterName(String name) {
		if (name == null) {
			return false;
		}

		try {
			SystemErrCapturer systemErrCapturer = new SystemErrCapturer();
			ModelFileParser parameterValueParser =
				ModelFileParser.createParserOn(name);

			try {
	    		systemErrCapturer.startCapturing();
	    		parameterValueParser.parameterIDValidator();
			} finally {
				systemErrCapturer.stopCapturing();
			}

			if (!systemErrCapturer.isEmpty()) {
				return false;
			}

			return true;
		} catch (RecognitionException e) {
			return false;
		} catch (UncheckedParsingException e) {
			return false;
		}
	}

	public synchronized void removeParameterDefinition(String name) {
		Utility.checkForNullArgument("name", name);
		this.parameterDefinitions.remove(name);
	}

	public synchronized void removeCompartment(Compartment compartment) {
		Utility.checkForNullArgument("compartment", compartment);

		Set<Transition> toRemove = new HashSet<Transition>();
		for (Transition transition : transitions) {
			if (transition.involves(compartment)) {
				toRemove.add(transition);
			}
		}
		transitions.removeAll(toRemove);

		// this should come after, due to events
		this.compartments.remove(compartment.getName());
	}

	public synchronized void removeTransition(Transition transition) {
		Utility.checkForNullArgument("transition", transition);

		if (transitions.contains(transition)) {
			transitions.remove(transition);
		}
	}

	public static boolean isValidCompartmentName(String id) {
		try {
			SystemErrCapturer systemErrCapturer = new SystemErrCapturer();
			ModelFileParser compartmentIDParser = ModelFileParser.createParserOn(id);

			try {
	    		systemErrCapturer.startCapturing();
	    		compartmentIDParser.compartmentIDValidator();
			} finally {
				systemErrCapturer.stopCapturing();
			}

			if (!systemErrCapturer.isEmpty()) {
				return false;
			}

			return true; // !parser.encounteredRecognitionException();
		} catch (RecognitionException e) {
			return false;
		} catch (UncheckedParsingException e) {
			return false;
		}
	}

	public static boolean isValidParameterExpression(String parameterExpression) {
		if (parameterExpression == null) {
			return false;
		}

		try {
			SystemErrCapturer systemErrCapturer = new SystemErrCapturer();
			ModelFileParser parameterValueParser =
				ModelFileParser.createParserOn(parameterExpression);

			try {
	    		systemErrCapturer.startCapturing();
	    		parameterValueParser.parameterValueValidator(new HashSet<String>());
			} finally {
				systemErrCapturer.stopCapturing();
			}

			if (!systemErrCapturer.isEmpty()) {
				return false;
			}

			return true; // !parser.encounteredRecognitionException();
		} catch (RecognitionException e) {
			return false;
		} catch (UncheckedParsingException e) {
			return false;
		}
	}

	protected synchronized void renameCompartment(Compartment compartment, String name)
			throws CompartmentExistsException, InvalidCompartmentNameException {
		Utility.checkForNullArgument("name", name);
		// don't need to check compartment for null, this is only called by a
		// Compartment passing itself.

		if (compartments.containsKey(name)) {
			throw new CompartmentExistsException(name);
		}

		if (isValidCompartmentName(name)) {
			this.compartments.remove(name);
			this.compartments.put(name, compartment);
		} else {
			throw new InvalidCompartmentNameException(name);
		}
	}

	public Set<String> listReferencedParameters() throws InvalidParameterExpressionException {
		Set<String> referencedParameters = new HashSet<String>();

		try {
			for (Iterator<Entry<String, String>> parameterDefinitionsIt = parameterDefinitions
					.entrySet().iterator(); parameterDefinitionsIt.hasNext();) {
				Entry<String, String> parameterDefinition = parameterDefinitionsIt.next();
				String parameterValue = parameterDefinition.getValue();

				ModelFileParser parser = ModelFileParser.createParserOn(parameterValue);

				parser.parameterValue(referencedParameters);
			}

			for (Iterator<Transition> transitionsIt = transitions.iterator(); transitionsIt
					.hasNext();) {
				Transition transition = transitionsIt.next();
				String parameterExpression = transition.getRatio();

				ModelFileParser parser = ModelFileParser.createParserOn(parameterExpression);

				parser.parameterValue(referencedParameters);
			}
		} catch (RecognitionException e) {
			throw new InvalidParameterExpressionException("Error examining parameters: "
					+ e.getMessage(), e);
		} catch (UncheckedParsingException e) {
			throw new InvalidParameterExpressionException("Error examining parameters: "
					+ e.getMessage(), e);
		}

		return referencedParameters;
	}

	public Set<String> listUnboundReferencedParameters()
			throws InvalidParameterExpressionException {
		Set<String> referencedParameters = listReferencedParameters();
		referencedParameters.removeAll(parameterDefinitions.keySet());
		return referencedParameters;
	}

	@Override
	public String toString() {
		StringTemplate template = modelFileTemplateGroup.getInstanceOf("modelFile");

		template.setAttribute(
				"parameterDefinitions",
				new ArrayList<Entry<String, String>>(getParameterDefinitions().entrySet()));

		template.setAttribute("compartments", new ArrayList<Compartment>(getCompartments()));

		template.setAttribute("transitions", getTransitions());

		return template.toString();
	}

	// TODO: Can have multiple susceptible compartments?
	public Compartment getSusceptibleCompartment() throws CompartmentDoesNotExistException,
			MultipleSusceptibleCompartmentsException {
		Set<Compartment> susceptibleCompartments = getCompartments(Compartment.Type.SUSCEPTIBLE);

		if (susceptibleCompartments.isEmpty()) {
			throw new CompartmentDoesNotExistException("Model has no 'susceptible' compartment.");
		} else if (susceptibleCompartments.size() == 1) {
			return susceptibleCompartments.toArray(new Compartment[0])[0];
		} else {
			throw new MultipleSusceptibleCompartmentsException();
		}
	}

	public Set<Compartment> getCompartments(Compartment.Type type) {
		Set<Compartment> matchingCompartments = new HashSet<Compartment>();

		for (Iterator<Compartment> compartmentsIt = compartments.values().iterator(); compartmentsIt
				.hasNext();) {
			Compartment compartment = compartmentsIt.next();

			if (type.equals(compartment.getType())) {
				matchingCompartments.add(compartment);
			}
		}

		return matchingCompartments;
	}

	public Set<Transition> getTransitions() {
		return transitions;
	}

	private static StringTemplateGroup loadTemplates(String templatePath) {
		return new StringTemplateGroup(
				new InputStreamReader(Model.class.getResourceAsStream(templatePath)));
	}
}