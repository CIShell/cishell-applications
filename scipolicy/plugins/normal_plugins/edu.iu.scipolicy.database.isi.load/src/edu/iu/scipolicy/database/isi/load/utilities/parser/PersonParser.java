package edu.iu.scipolicy.database.isi.load.utilities.parser;

import org.cishell.utilities.Pair;

import edu.iu.cns.database.load.framework.utilities.DatabaseTableKeyGenerator;
import edu.iu.scipolicy.database.isi.load.model.entity.Person;
import edu.iu.scipolicy.database.isi.load.utilities.parser.exception.PersonParsingException;

public class PersonParser {
	public static Pair<Person, Boolean> parsePerson(
			DatabaseTableKeyGenerator personKeyGenerator,
			String rawAbbreviatedNameString,
			String rawFullNameString) throws PersonParsingException {
		AbbreviatedNameParser parsedAbbreviatedName =
			new AbbreviatedNameParser(rawAbbreviatedNameString);
		FullNameParser parsedFullName = new FullNameParser(rawFullNameString);

		return new Pair<Person, Boolean>(
			new Person(
				personKeyGenerator,
				parsedFullName.additionalNamesString,
				parsedAbbreviatedName.familyName,
				parsedAbbreviatedName.firstInitial,
				parsedFullName.fullName,
				parsedAbbreviatedName.middleInitials,
				parsedFullName.personalName,
				parsedAbbreviatedName.unsplitAbbreviatedName),
			parsedAbbreviatedName.starred);
	}
}