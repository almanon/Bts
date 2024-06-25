package com.human.bts.util;


public class ColorList {
	private String ctemplate;
	private String[] colorList;
	
	public ColorList() {
		setColorList();
	}
	public ColorList(String ctemplate) {
		this.ctemplate = ctemplate;
//		이부분에 colorList를 채워주는 코드 추가...
	}
	public ColorList(String[] colorList) {
		this.colorList = colorList;
	}

	public String[] getColorList() {
		return colorList;
	}

	public void setColorList() {
		String[] cList = {
			     "w3-red", "w3-pink", "w3-purple", "w3-deep-purple", "w3-indigo",
			     "w3-blue", "w3-aqua", "w3-teal", "w3-green", "w3-light-green", 
			     "w3-lime", "w3-khaki", "w3-yellow", "w3-amber", "w3-orange", "w3-deep-orange"
		};
		colorList = cList;
	}
	
	public void setColorList(String[] colorList) {
		this.colorList = colorList;
	}
	
}