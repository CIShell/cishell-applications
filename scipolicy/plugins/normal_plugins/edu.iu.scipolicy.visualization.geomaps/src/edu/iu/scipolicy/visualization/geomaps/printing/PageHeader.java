package edu.iu.scipolicy.visualization.geomaps.printing;

import java.text.SimpleDateFormat;
import java.util.Calendar;

import edu.iu.scipolicy.visualization.geomaps.utility.Constants;

public class PageHeader {
	public static final String SEP = " | ";
	
	public static final String FONT_NAME = Constants.FONT_NAME;
	public static final double FONT_SIZE = 6;
	public static final double FONT_BRIGHTNESS = 0.35;
	
	public static final double LOWER_LEFT_X_IN_POINTS =
		0.4 * Constants.POINTS_PER_INCH;
		
	
	private String authorName;
	private String dataLabel;
	private double lowerLeftYInPoints;	

	
	public PageHeader(String authorName, String dataLabel, double pageHeightInPoints) {
		this.authorName = authorName;
		this.dataLabel = dataLabel;
		
		// Place the text so that its top is 0.4 inches from the top of the page
		this.lowerLeftYInPoints =
			pageHeightInPoints - (0.4 * Constants.POINTS_PER_INCH) - FONT_SIZE;
	}	
	
	public String toString() {
		String s = "";
		
		if (stringSpecified(authorName)) {
			s += (authorName + SEP);
		}
		
		if (stringSpecified(dataLabel)) {
			s += ("Generated from " + dataLabel + SEP);
		}
		
		s += timestamp();
		
		return s;
	}

	private boolean stringSpecified(String string) {
		return ((string != null) && (!("".equals(string))));
	}
	
	public String toPostScript() {
		String s = "";
		
		s += "gsave" + "\n";
		s += "/" + FONT_NAME + " findfont" + "\n";
		s += FONT_SIZE + " scalefont" + "\n";
		s += "setfont" + "\n";
		s += FONT_BRIGHTNESS + " setgray" + "\n";
		s += LOWER_LEFT_X_IN_POINTS + " " + lowerLeftYInPoints + " moveto" + "\n";
		s += "(" + escapeForPostScript(toString()) + ") show" + "\n";
		s += "grestore" + "\n";
		
		return s;
	}
	
	public static String escapeForPostScript(String string) {
		// Replace each backslash with two backslashes
		return string.replace("\\", "\\\\");
	}

	public static String timestamp() {
		Calendar cal = Calendar.getInstance();
	    SimpleDateFormat sdf =
	    	new SimpleDateFormat("EEE, d MMM yyyy");// HH:mm:ss Z");
	    return sdf.format(cal.getTime());
	}
}