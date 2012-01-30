package edu.iu.sci2.visualization.scimaps.rendering.print2008;

import java.util.Collection;
import java.util.Collections;

import org.cishell.utilities.NumberUtilities;

/**
 * This class represents a circle legend.
 */
public class CircleSizeLegend {
	/*
	 * Brightnesses correspond to PostScript's setgray command. 0 is black, 1 is
	 * white.
	 */
	public static final float CIRCLE_BRIGHTNESS = 0.3f;
	public static final float EXTREMA_LABEL_BRIGHTNESS = 0.3f;
	public static final float EXTREMA_LABEL_FONT_SIZE = 6f;
	public static final float TYPE_LABEL_BRIGHTNESS = 0.0f;
	public static final float TYPE_LABEL_FONT_SIZE = 10f;
	public static final float SCALING_LABEL_BRIGHTNESS = 0.25f;
	public static final float KEY_LABEL_BRIGHTNESS = 0.3f;
	public static final float KEY_LABEL_FONT_SIZE = 6f;

	public CircleSizeLegend(Collection<Float> values, float scalingFactor,
			String circleSizeMeaning) {
		this.scalingFactor = scalingFactor;
		this.circleSizeMeaning = circleSizeMeaning;

		minArea = Collections.min(values);
		maxArea = Collections.max(values);
		midArea = Math.round((minArea + maxArea) / 2.0);
		minLabel = roundFormatted(minArea);
		midLabel = roundFormatted(midArea);
		maxLabel = roundFormatted(maxArea);
	}
	
	private static String roundFormatted(double number) {
		if (number == (int) number) {
			return String.valueOf((int) number);
		} else {
			return String.valueOf(NumberUtilities.roundToNDecimalPlaces(number, 2));
		}
	}

	private float scalingFactor;

	public float getScalingFactor() {
		return scalingFactor;
	}

	public String getCircleSizeMeaning() {
		return circleSizeMeaning;
	}

	public float getMinArea() {
		return minArea;
	}

	public float getMaxArea() {
		return maxArea;
	}

	public float getMidArea() {
		return midArea;
	}

	public String getMinLabel() {
		return minLabel;
	}

	public String getMidLabel() {
		return midLabel;
	}

	public String getMaxLabel() {
		return maxLabel;
	}

	private String circleSizeMeaning;
	private float minArea;
	private float maxArea;
	private float midArea;
	private String minLabel;
	private String midLabel;
	private String maxLabel;

}