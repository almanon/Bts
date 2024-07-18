package com.human.bts.vo;

import java.util.List;

public class FacilityVO {
	private String laneType, staNm;
	private int evCnt,esCnt,clCnt;
	private List<FacilityVO> facilityList;
	
	
	
	public List<FacilityVO> getFacilityList() {
		return facilityList;
	}
	public void setFacilityList(List<FacilityVO> facilityList) {
		this.facilityList = facilityList;
	}
	public String getLaneType() {
		return laneType;
	}
	public void setLaneType(String laneType) {
		this.laneType = laneType;
	}
	public String getStaNm() {
		return staNm;
	}
	public void setStaNm(String staNm) {
		this.staNm = staNm;
	}
	public int getEvCnt() {
		return evCnt;
	}
	public void setEvCnt(int evCnt) {
		this.evCnt = evCnt;
	}
	public int getEsCnt() {
		return esCnt;
	}
	public void setEsCnt(int esCnt) {
		this.esCnt = esCnt;
	}
	public int getClCnt() {
		return clCnt;
	}
	public void setClCnt(int clCnt) {
		this.clCnt = clCnt;
	}
	
	
}
