package edu.iu.scipolicy.loader.isi.db.model.entity.relationship;

import java.util.Dictionary;
import java.util.Hashtable;

import edu.iu.cns.database.loader.framework.RowItem;
import edu.iu.cns.database.loader.framework.Schema;
import edu.iu.cns.database.loader.framework.DerbyFieldType;
import edu.iu.nwb.shared.isiutil.database.ISIDatabase;
import edu.iu.scipolicy.loader.isi.db.model.entity.Document;
import edu.iu.scipolicy.loader.isi.db.model.entity.Keyword;

public class DocumentKeyword extends RowItem<DocumentKeyword> {
	public static final Schema<DocumentKeyword> SCHEMA = new Schema<DocumentKeyword>(
		false,
		ISIDatabase.DOCUMENT_KEYWORDS_DOCUMENT_FOREIGN_KEY, DerbyFieldType.FOREIGN_KEY,
		ISIDatabase.DOCUMENT_KEYWORDS_KEYWORD_FOREIGN_KEY, DerbyFieldType.FOREIGN_KEY,
		ISIDatabase.ORDER_LISTED, DerbyFieldType.INTEGER).
		FOREIGN_KEYS(
			ISIDatabase.DOCUMENT_KEYWORDS_DOCUMENT_FOREIGN_KEY, ISIDatabase.DOCUMENT_TABLE_NAME,
			ISIDatabase.DOCUMENT_KEYWORDS_KEYWORD_FOREIGN_KEY, ISIDatabase.KEYWORD_TABLE_NAME);

	private Document document;
	private Keyword keyword;
	private int orderListed;

	public DocumentKeyword(Document document, Keyword keyword, int orderListed) {
		super(createAttributes(document, keyword, orderListed));
		this.document = document;
		this.keyword = keyword;
		this.orderListed = orderListed;
	}

	public Document getDocument() {
		return this.document;
	}

	public Keyword getKeyword() {
		return this.keyword;
	}

	public int getOrderListed() {
		return this.orderListed;
	}

	public boolean shouldMerge(DocumentKeyword otherDocumentKeyword) {
		if ((this.document != null) && (this.keyword != null)) {
			Document otherDocument = otherDocumentKeyword.getDocument();
			Keyword otherKeyword = otherDocumentKeyword.getKeyword();

			if ((otherDocument != null) && (otherKeyword != null)) {
				return (
					(this.document.getPrimaryKey() == otherDocument.getPrimaryKey()) &&
					(this.keyword.getPrimaryKey() == otherKeyword.getPrimaryKey()));
			}
		}

		return false;
	}

	public void merge(DocumentKeyword otherDocumentKeyword) {
	}

	public static Dictionary<String, Comparable<?>> createAttributes(
			Document document, Keyword keyword, int orderListed) {
		Dictionary<String, Comparable<?>> attributes = new Hashtable<String, Comparable<?>>();
		attributes.put(ISIDatabase.DOCUMENT_KEYWORDS_DOCUMENT_FOREIGN_KEY, document.getPrimaryKey());
		attributes.put(ISIDatabase.DOCUMENT_KEYWORDS_KEYWORD_FOREIGN_KEY, keyword.getPrimaryKey());
		attributes.put(ISIDatabase.ORDER_LISTED, orderListed);

		return attributes;
	}
}