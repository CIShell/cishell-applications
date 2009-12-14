package edu.iu.scipolicy.loader.isi.db.model.entity;

import java.util.Dictionary;
import java.util.Hashtable;


import edu.iu.cns.database.loader.framework.Entity;
import edu.iu.cns.database.loader.framework.utilities.DatabaseTableKeyGenerator;
import edu.iu.scipolicy.loader.isi.db.ISIDatabase;

public class Patent extends Entity {
	private String patentNumber;

	public Patent(DatabaseTableKeyGenerator keyGenerator, String patentNumber) {
		super(keyGenerator);
		this.patentNumber = patentNumber;
	}

	public String getPatentNumber() {
		return this.patentNumber;
	}

	public Dictionary<String, Object> createAttributes() {
		Dictionary<String, Object> attributes = new Hashtable<String, Object>();
		attributes.put(ISIDatabase.PATENT_NUMBER, this.patentNumber);

		return attributes;
	}
}