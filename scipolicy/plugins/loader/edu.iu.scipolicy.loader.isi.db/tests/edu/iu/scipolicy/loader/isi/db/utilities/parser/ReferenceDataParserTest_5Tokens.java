package edu.iu.scipolicy.loader.isi.db.utilities.parser;

import static org.junit.Assert.fail;

import org.cishell.utilities.StringUtilities;
import org.junit.Test;

import edu.iu.scipolicy.loader.isi.db.model.entity.Source;

public class ReferenceDataParserTest_5Tokens extends ReferenceDataParserTest {
	@Test
	public void test5Tokens_Invalid() throws Exception {
		ReferenceDataParser result = runTest(", , , , ", true);
		int resultYear = result.getYear();
		Source resultSource = result.getSource();
		int resultVolume = result.getVolume();
		int resultPageNumber = result.getPageNumber();

		if (resultSource != null) {
			if ((resultYear != IntegerParserWithDefault.DEFAULT) ||
					!StringUtilities.isEmptyOrWhiteSpace(
						resultSource.get29CharacterSourceTitleAbbreviation()) ||
					(resultVolume != IntegerParserWithDefault.DEFAULT) ||
					(resultPageNumber != IntegerParserWithDefault.DEFAULT)) {
				String failMessage =
					"Result should be invalid.  Instead, it has:" +
					"\n\tYear: \"" + resultYear + "\"" +
					"\n\tSource: \"" + resultSource + "\"" +
					"\n\tVolume: \"" + resultVolume + "\"" +
					"\n\tPage number: \"" + resultPageNumber + "\"";
				fail(failMessage);
			}
		} else {
			if ((resultYear != IntegerParserWithDefault.DEFAULT) ||
					(resultSource != null) ||
					(resultVolume != IntegerParserWithDefault.DEFAULT) ||
					(resultPageNumber != IntegerParserWithDefault.DEFAULT)) {
				String failMessage =
					"Result should be invalid.  Instead, it has:" +
					"\n\tYear: \"" + resultYear + "\"" +
					"\n\tSource: \"" + resultSource + "\"" +
					"\n\tVolume: \"" + resultVolume + "\"" +
					"\n\tPage number: \"" + resultPageNumber + "\"";
				fail(failMessage);
			}
		}
	}

	/*
	 * Tests for the pattern:
	 * person, year, source, volume, page number
	 * (This is most likely the only acceptable pattern.)
	 * Person parsing is tested in PersonParsingTest.  No need to test it here.
	 */

	@Test
	public void test5Tokens_PersonFirst_Year() throws Exception {
		ReferenceDataParser result = runTest(
			PERSON_STRING + ", " +
				YEAR + ", " +
				SOURCE_STRING + ", " +
				VOLUME_STRING + ", " +
				PAGE_NUMBER_STRING,
			true);
		int resultYear = result.getYear();

		if (resultYear != YEAR) {
			fail("Result year (" + resultYear + ") != " + YEAR);
		}
	}

	@Test
	public void test5Tokens_PersonFirst_NoSourceAnnotation() throws Exception {
		testSourceWithAnnotation(
			PERSON_STRING + ", " +
				YEAR + ", " +
				SOURCE_STRING + ", " +
				VOLUME_STRING + ", " +
				PAGE_NUMBER_STRING,
			SOURCE_STRING,
			NO_ANNOTATION,
			true);
	}

	@Test
	public void test5Tokens_PersonFirst_SourceIsAnAnnotation() throws Exception {
		testSourceAsAnnotations(
			PERSON_STRING + ", " + YEAR + ", ",
			", " + VOLUME_STRING + ", " + PAGE_NUMBER_STRING,
			true);
	}

	@Test
	public void test5Tokens_PersonFirst_SourceHasAnAnnotation() throws Exception {
		testSourceWithAnnotations(
			PERSON_STRING + ", " + YEAR + ", ",
			", " + VOLUME_STRING + ", " + PAGE_NUMBER_STRING,
			SOURCE_STRING,
			true);
	}

	@Test
	public void test5Tokens_PersonFirst_Volume() throws Exception {
		ReferenceDataParser result = runTest(
			PERSON_STRING + ", " +
				YEAR + ", " +
				SOURCE_STRING + ", " +
				VOLUME_STRING + ", " +
				PAGE_NUMBER_STRING,
			true);
		int resultVolume = result.getVolume();

		if (resultVolume != VOLUME_NUMBER) {
			fail("Result volume (" + resultVolume + ") != " + VOLUME_NUMBER);
		}
	}

	@Test
	public void test5Tokens_PersonFirst_PageNumber() throws Exception {
		ReferenceDataParser result = runTest(
			PERSON_STRING + ", " +
				YEAR + ", " +
				SOURCE_STRING + ", " +
				VOLUME_STRING + ", " +
				PAGE_NUMBER_STRING,
			true);
		int resultPageNumber = result.getPageNumber();

		if (resultPageNumber != PAGE_NUMBER) {
			fail("Result page number (" + resultPageNumber + ") != " + PAGE_NUMBER);
		}
	}
}
