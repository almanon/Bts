package com.human.bts.vo;

public class MemberVO {
	private int mno;
	private String name, id, pw;
	public int getMno() {
		return mno;
	}
	public void setMno(int mno) {
		this.mno = mno;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPw() {
		return pw;
	}
	public void setPw(String pw) {
		this.pw = pw;
	}
	@Override
	public String toString() {
		return "MemberVO [mno=" + mno + ", name=" + name + ", id=" + id + ", pw=" + pw + "]";
	}
	
	
}
