package edu.iu.sci2.visualization.temporalbargraph.common;

import com.google.common.base.Objects;


public class PostScriptBar {
	private String name;
	private double daysSinceEarliest;
	private double lengthInDays;
	private double amountPerDay;
	
	/**
	 * A postscript bar keeps all of the knowledge that postscript needs to know to create a bar and label
	 * @param daysSinceEarliest
	 * @param lengthInDays
	 * @param amountPerDay
	 */
	public PostScriptBar(double daysSinceEarliest, double lengthInDays, double amountPerDay, Record record) {
		super();
		this.name = record.getLabel();
		this.daysSinceEarliest = daysSinceEarliest;
		this.lengthInDays = lengthInDays;
		this.amountPerDay = amountPerDay;
	}

	public String getName() {
		return name;
	}
	
	public double daysSinceEarliest() {
		return daysSinceEarliest;
	}
	
	public double lengthInDays() {
		return lengthInDays;
	}

	public double amountPerDay() {
		return amountPerDay;
	}

	public double getArea() {
		return lengthInDays * amountPerDay;
	}
	
	public String toString(){
		return Objects.toStringHelper(this)
				.add("name", name)
				.add("daysSinceEarliest", daysSinceEarliest)
				.add("lengthInDays", lengthInDays)
				.toString();
	}
	
	// TODO use string templating to let the bar output it's own postscript requirements
}