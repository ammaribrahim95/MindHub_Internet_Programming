package com.mindhub.model;

import java.util.Map;

/**
 * ReportData — generic wrapper for admin report/analytics data.
 * Used by AdminController to pass aggregated query results to views.
 */
public class ReportData {

    private String label;
    private int count;
    private double value;
    private Map<String, Object> extras;

    public ReportData() {}

    public ReportData(String label, int count) {
        this.label = label;
        this.count = count;
    }

    public String getLabel() { return label; }
    public void setLabel(String label) { this.label = label; }
    public int getCount() { return count; }
    public void setCount(int count) { this.count = count; }
    public double getValue() { return value; }
    public void setValue(double value) { this.value = value; }
    public Map<String, Object> getExtras() { return extras; }
    public void setExtras(Map<String, Object> extras) { this.extras = extras; }
}

