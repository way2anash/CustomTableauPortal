package com.tableau.oem;

public class TableauView implements java.io.Serializable {
	private static final long serialVersionUID = 1L;
    
	public String getWorkbookContextName() {
		return workbookContextName;
	}
	public void setWorkbookContextName(String workbookContextName) {
		this.workbookContextName = workbookContextName;
	}
	public String getViewName() {
		return viewName;
	}
	public void setViewName(String viewName) {
		this.viewName = viewName;
	}
	public String getViewContextName() {
		return viewContextName;
	}
	public void setViewContextName(String viewContextName) {
		this.viewContextName = viewContextName;
	}
	public String getViewId() {
		return viewId;
	}
	public void setViewId(String viewId) {
		this.viewId = viewId;
	}
	private String workbookContextName;
	private String viewName;
	private String viewContextName;
	private String viewId;

}
