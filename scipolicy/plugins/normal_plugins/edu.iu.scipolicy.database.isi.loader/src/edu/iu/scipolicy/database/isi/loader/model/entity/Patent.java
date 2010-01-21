package edu.iu.scipolicy.database.isi.loader.model.entity;

import java.util.Dictionary;
import java.util.Hashtable;

import org.cishell.utilities.StringUtilities;

import edu.iu.cns.database.loader.framework.Entity;
import edu.iu.cns.database.loader.framework.Schema;
import edu.iu.cns.database.loader.framework.DerbyFieldType;
import edu.iu.cns.database.loader.framework.utilities.DatabaseTableKeyGenerator;
import edu.iu.nwb.shared.isiutil.database.ISI;

public class Patent extends Entity<Patent> implements Comparable<Patent> {
	public static final Schema<Patent> SCHEMA = new Schema<Patent>(
		true,
		ISI.PATENT_NUMBER, DerbyFieldType.TEXT);

	private String patentNumber;

	public Patent(DatabaseTableKeyGenerator keyGenerator, String patentNumber) {
		super(keyGenerator, createAttributes(patentNumber));
		this.patentNumber = patentNumber;
	}

	public String getPatentNumber() {
		return this.patentNumber;
	}

	public int compareTo(Patent otherPatent) {
		return new Integer(getPrimaryKey()).compareTo(new Integer(otherPatent.getPrimaryKey()));
	}

	public boolean shouldMerge(Patent otherPatent) {
		return StringUtilities.validAndEquivalent(
			this.patentNumber, otherPatent.getPatentNumber());
	}

	public void merge(Patent otherPatent) {
	}

	public static Dictionary<String, Comparable<?>> createAttributes(String patentNumber) {
		Dictionary<String, Comparable<?>> attributes = new Hashtable<String, Comparable<?>>();
		attributes.put(ISI.PATENT_NUMBER, patentNumber);

		return attributes;
	}
}