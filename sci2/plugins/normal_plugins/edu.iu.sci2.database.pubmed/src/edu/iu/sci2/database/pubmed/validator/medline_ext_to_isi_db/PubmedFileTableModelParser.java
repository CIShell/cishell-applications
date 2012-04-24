package edu.iu.sci2.database.pubmed.validator.medline_ext_to_isi_db;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.cishell.utilities.UnicodeReader;
import org.osgi.service.log.LogService;

import com.google.common.base.Preconditions;
import com.google.common.collect.ImmutableList;

import edu.iu.cns.database.load.framework.utilities.DatabaseModel;
import edu.iu.cns.database.load.framework.utilities.DatabaseTableKeyGenerator;
import edu.iu.sci2.database.pubmed.common.AbstractPubmedTableModelParser;
import edu.iu.sci2.database.scholarly.model.entity.Address;
import edu.iu.sci2.database.scholarly.model.entity.Author;
import edu.iu.sci2.database.scholarly.model.entity.Document;
import edu.iu.sci2.database.scholarly.model.entity.DocumentKeyword;
import edu.iu.sci2.database.scholarly.model.entity.Editor;
import edu.iu.sci2.database.scholarly.model.entity.Keyword;
import edu.iu.sci2.database.scholarly.model.entity.Person;
import edu.iu.sci2.database.scholarly.model.entity.ResearchAddress;
import edu.iu.sci2.database.scholarly.model.entity.Source;
import edu.iu.sci2.medline.common.MedlineField;
import edu.iu.sci2.medline.common.MedlineRecord;
import edu.iu.sci2.medline.common.MedlineRecordParser;

/**
 * A parser that can create a {@linkplain DatabaseModel} from a MEDLINE®/PubMed®
 * {@linkplain File}. The advantage of this parser is that it designed to load
 * the {@linkplain MedlineRecord}s individually to a database (once the database
 * loading code has been rewritten) to reduce the memory requirements.
 */
public class PubmedFileTableModelParser extends AbstractPubmedTableModelParser {
	public static class TableModelParsingException extends Exception {
		private static final long serialVersionUID = -4579673818400442630L;

		public TableModelParsingException(String message, Throwable cause) {
			super(message, cause);
		}
	}

	private LogService logger;

	private DatabaseModel model;

	private MedlineRecordParser recordParser;

	protected PubmedFileTableModelParser(File pubmedFile, LogService logger)
			throws TableModelParsingException {
		Preconditions.checkArgument(pubmedFile != null,
				"The pubmed file must not be null.");
		Preconditions.checkArgument(logger != null,
				"The LogService must not be null.");
		this.logger = logger;
		try {
			this.recordParser = new MedlineRecordParser(new BufferedReader(
					new UnicodeReader(new FileInputStream(pubmedFile))), this.logger);

		} catch (FileNotFoundException e) {
			String message = "File could not be found.";
			this.logger.log(LogService.LOG_ERROR, message);
			throw new TableModelParsingException(message, e);
		}

		this.model = null;
	}

	@Override
	public DatabaseModel getModel() {
		if (this.model == null) {
			this.model = parseModel();
		}
		return this.model;
	}

	private DatabaseModel parseModel() {
		Preconditions.checkState(this.addressesTable != null,
				"addresses should be been made by the super class.");
		Preconditions.checkState(this.authorsTable != null,
				"authors should be been made by the super class.");
		Preconditions.checkState(this.dbTables != null,
				"dbTables should be been made by the super class.");
		Preconditions.checkState(this.documentKeywordsTable != null,
				"documentKeywords should be been made by the super class.");
		Preconditions.checkState(this.documentsTable != null,
				"documents should be been made by the super class.");
		Preconditions.checkState(this.editorsTable != null,
				"editors should be been made by the super class.");
		Preconditions.checkState(this.keywordsTable != null,
				"keywords should be been made by the super class.");
		Preconditions.checkState(this.peopleTable != null,
				"people should be been made by the super class.");
		Preconditions.checkState(this.reprintAddressesTable != null,
				"reprintAddresses should be been made by the super class.");
		Preconditions.checkState(this.researchAddressesTable != null,
				"researchAddresses should be been made by the super class.");
		Preconditions.checkState(this.sourcesTable != null,
				"sources should be been made by the super class.");

		if (this.model != null) {
			return this.model;
		}

		while (this.recordParser.hasNext()) {
			MedlineRecord record = this.recordParser.getNext();
			/*
			 * Sources Table
			 */
			Source source = getSource(this.sourcesTable.getKeyGenerator(), record,
					this.logger);
			this.sourcesTable.add(source);

			/*
			 * Documents Table
			 */
			Document document = getDocument(this.documentsTable.getKeyGenerator(),
					record, this.logger);
			this.documentsTable.add(document);

			/*
			 * People Table - add investigators
			 */
			ImmutableList<String> investigatorNames = record
					.getValues(MedlineField.INVESTIGATOR_NAME);
			List<Person> investigators = getPeople(
					this.peopleTable.getKeyGenerator(), investigatorNames,
					this.logger, MedlineField.INVESTIGATOR_NAME);

			ImmutableList<String> fullInvestigatorNames = record
					.getValues(MedlineField.FULL_INVESTIGATOR_NAME);
			investigators.addAll(getPeople(this.peopleTable.getKeyGenerator(),
					fullInvestigatorNames, this.logger,
					MedlineField.FULL_INVESTIGATOR_NAME));

			/*
			 * People Table - add authors
			 */
			ImmutableList<String> authorNames = record
					.getValues(MedlineField.AUTHOR);
			List<Person> authorz = getPeople(this.peopleTable.getKeyGenerator(),
					authorNames, this.logger, MedlineField.AUTHOR);

			ImmutableList<String> fullAuthorNames = record
					.getValues(MedlineField.FULL_AUTHOR);
			authorz.addAll(getPeople(this.peopleTable.getKeyGenerator(),
					fullAuthorNames, this.logger, MedlineField.FULL_AUTHOR));
			for (Person person : authorz) {
				this.peopleTable.add(person);
			}

			/*
			 * Authors Table
			 */
			for (Author author : Author.makeAuthors(document, authorz)) {
				this.authorsTable.add(author);
			}

			/*
			 * People Table - add editors
			 */
			ImmutableList<String> editorNames = record
					.getValues(MedlineField.EDITOR_NAME);
			List<Person> editorz = getPeople(this.peopleTable.getKeyGenerator(),
					editorNames, this.logger, MedlineField.EDITOR_NAME);

			ImmutableList<String> fullEditorNames = record
					.getValues(MedlineField.FULL_EDITOR_NAME);
			editorz.addAll(getPeople(this.peopleTable.getKeyGenerator(),
					fullEditorNames, this.logger, MedlineField.FULL_EDITOR_NAME));

			for (Person editor : editorz) {
				this.peopleTable.add(editor);
			}

			/*
			 * Editors Table
			 */
			for (Editor editor : Editor.makeEditors(document, editorz)) {
				this.editorsTable.add(editor);
			}

			/*
			 * Keywords Table
			 */
			List<Keyword> keywordz = getKeywords(
					this.keywordsTable.getKeyGenerator(), record);
			for (Keyword keyword : keywordz) {
				this.keywordsTable.add(keyword);
			}

			/*
			 * Document Keywords
			 */
			for (DocumentKeyword documentKeyword : DocumentKeyword
					.makeDocumentKeywords(document, keywordz)) {
				this.documentKeywordsTable.add(documentKeyword);
			}

			/*
			 * Addresses
			 */
			List<Address> addressez = getAddresses(
					this.addressesTable.getKeyGenerator(), record);
			for (Address address : addressez) {
				this.addressesTable.add(address);
			}

			/*
			 * Research Addresses
			 */
			for (ResearchAddress researchAddress : ResearchAddress
					.makeResearchAddresses(document, addressez)) {
				this.researchAddressesTable.add(researchAddress);
			}
		}

		return new DatabaseModel(this.dbTables);
	}

	private static Source getSource(DatabaseTableKeyGenerator keyGenerator,
			MedlineRecord record, LogService logger) {
		Map<MedlineField, Object> medlineValues = new HashMap<MedlineField, Object>();
		for (MedlineField field : SOURCE_TO_MEDLINE.values()) {
			medlineValues.put(field, record.getValue(field));
		}
		return makeSource(keyGenerator, medlineValues, logger);
	}

	private static Document getDocument(DatabaseTableKeyGenerator keyGenerator,
			MedlineRecord record, LogService logger) {
		Map<MedlineField, Object> medlineValues = new HashMap<MedlineField, Object>();
		for (MedlineField field : DOCUMENT_TO_MEDLINE.values()) {
			medlineValues.put(field, record.getValue(field));
		}

		return makeDocument(keyGenerator, medlineValues, logger);
	}

	private static ImmutableList<Keyword> getKeywords(
			DatabaseTableKeyGenerator keyGenerator, MedlineRecord record) {
		final String PUBMED_KEYWORD_PREFIX = "pubmed ";

		ImmutableList<Keyword> originalKeywords = makeKeywords(
				record.getValues(MedlineField.MESH_TERMS),
				PUBMED_KEYWORD_PREFIX + MedlineField.MESH_TERMS.getName(),
				keyGenerator);

		ImmutableList<Keyword> newKeywords = makeKeywords(
				record.getValues(MedlineField.OTHER_TERM),
				PUBMED_KEYWORD_PREFIX + MedlineField.OTHER_TERM.getName(),
				keyGenerator);

		return new ImmutableList.Builder<Keyword>().addAll(originalKeywords)
				.addAll(newKeywords).build();
	}

	private static ImmutableList<Address> getAddresses(
			DatabaseTableKeyGenerator keyGenerator, MedlineRecord record) {
		return makeAddresses(keyGenerator,
				record.getValues(MedlineField.AFFILIATION));
	}

}
