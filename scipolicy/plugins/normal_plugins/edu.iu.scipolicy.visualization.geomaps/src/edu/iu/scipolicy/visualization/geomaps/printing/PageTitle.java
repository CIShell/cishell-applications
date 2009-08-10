package edu.iu.scipolicy.visualization.geomaps.printing;

import edu.iu.scipolicy.visualization.geomaps.utility.Constants;


public class PageTitle {
	public static final String FONT_NAME = Constants.FONT_NAME;
	public static final double TITLE_FONT_SIZE = 20;
	public static final double SUBTITLE_FONT_SIZE = 15;
	public static final double FONT_BRIGHTNESS = 0.0;
	
	public static final double TITLE_LOWER_LEFT_X_IN_INCHES =
		1.1 * Constants.POINTS_PER_INCH;
	public static final double SUBTITLE_LOWER_LEFT_Y_IN_INCHES =
		1.1 * Constants.POINTS_PER_INCH;
	public static final double TITLE_LOWER_LEFT_Y_IN_INCHES =
		SUBTITLE_FONT_SIZE + SUBTITLE_LOWER_LEFT_Y_IN_INCHES;	
	public static final double SUBTITLE_LOWER_LEFT_X_IN_INCHES =
		TITLE_FONT_SIZE + TITLE_LOWER_LEFT_X_IN_INCHES;
	
	
	private String title;
	private String subtitle;
	
	
	public PageTitle(String title, String subtitle) {
		this.title = title;
		this.subtitle = subtitle;
	}
	
	
	public String toPostScript() {
		String s = "";
		
		s += "gsave" + "\n";
		s += "	" + FONT_BRIGHTNESS + " setgray" + "\n";
		s += "	% Show title" + "\n";
		s += "	/" + FONT_NAME + " findfont " + TITLE_FONT_SIZE + " scalefont setfont" + "\n";
		s += "	" + TITLE_LOWER_LEFT_X_IN_INCHES + " " + TITLE_LOWER_LEFT_Y_IN_INCHES + " moveto" + "\n";
		s += "	(" + title + ") show" + "\n";
		s += "	% Show subtitle" + "\n";
		s += "	/" + FONT_NAME + " findfont " + SUBTITLE_FONT_SIZE + " scalefont setfont" + "\n";
		s += "	" + SUBTITLE_LOWER_LEFT_X_IN_INCHES + " " + SUBTITLE_LOWER_LEFT_Y_IN_INCHES + " moveto" + "\n";
		s += "	(" + subtitle + ") show" + "\n";
		s += "grestore" + "\n";
		s += "\n";
		
		return s;
	}
}
