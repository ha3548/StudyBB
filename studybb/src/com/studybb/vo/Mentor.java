package com.studybb.vo;

public class Mentor {
	private Member member;
	private String mentor_career;
	private int mentor_status;
	
	public Mentor() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Mentor(Member member, String mentor_career, int mentor_status) {
		super();
		this.member = member;
		this.mentor_career = mentor_career;
		this.mentor_status = mentor_status;
	}

	public Member getMember() {
		return member;
	}

	public void setMember(Member member) {
		this.member = member;
	}

	public String getMentor_career() {
		return mentor_career;
	}

	public void setMentor_career(String mentor_career) {
		this.mentor_career = mentor_career;
	}

	public int getMentor_status() {
		return mentor_status;
	}

	public void setMentor_status(int mentor_status) {
		this.mentor_status = mentor_status;
	}
	
}


