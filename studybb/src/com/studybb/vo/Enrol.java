package com.studybb.vo;

import java.util.Date;

public class Enrol {
	private Study study; //study_no 가지고있음
	private Member member; //mem_id 가지고있음
	private String enrol_say;
	private int enrol_status; //0-대기중|1-승인|2-거절
	private Date enrol_date;
	
	public Enrol() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Enrol(Study study, Member member, String enrol_say, int enrol_status, Date enrol_date) {
		super();
		this.study = study;
		this.member = member;
		this.enrol_say = enrol_say;
		this.enrol_status = enrol_status;
		this.enrol_date = enrol_date;
	}

	public Study getStudy() {
		return study;
	}

	public void setStudy(Study study) {
		this.study = study;
	}

	public Member getMember() {
		return member;
	}

	public void setMember(Member member) {
		this.member = member;
	}

	public String getEnrol_say() {
		return enrol_say;
	}

	public void setEnrol_say(String enrol_say) {
		this.enrol_say = enrol_say;
	}

	public int getEnrol_status() {
		return enrol_status;
	}

	public void setEnrol_status(int enrol_status) {
		this.enrol_status = enrol_status;
	}

	public Date getEnrol_date() {
		return enrol_date;
	}

	public void setEnrol_date(Date enrol_date) {
		this.enrol_date = enrol_date;
	}
	
	
}
