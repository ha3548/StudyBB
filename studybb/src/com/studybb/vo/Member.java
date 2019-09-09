package com.studybb.vo;

public class Member {
	private String mem_id;
	private String mem_pwd;
	private String mem_email;
	private String mem_name;
	private String mem_gender;
	private String mem_interest;
	private String mem_major;
	private String mem_area;
	private String mentor_career;
	
	public Member() {
		super();
	}
	public Member(String mem_id, String mem_pwd, String mem_email, String mem_name, String mem_gender,
			String mem_interest, String mem_major, String mem_area) {
		super();
		this.mem_id = mem_id;
		this.mem_pwd = mem_pwd;
		this.mem_email = mem_email;
		this.mem_name = mem_name;
		this.mem_gender = mem_gender;
		this.mem_interest = mem_interest;
		this.mem_major = mem_major;
		this.mem_area = mem_area;
	}
	public Member(String mem_id, String mem_pwd, String mem_email, String mem_name, String mem_gender,
			String mem_interest, String mem_major, String mem_area, String mentor_career) {
		super();
		this.mem_id = mem_id;
		this.mem_pwd = mem_pwd;
		this.mem_email = mem_email;
		this.mem_name = mem_name;
		this.mem_gender = mem_gender;
		this.mem_interest = mem_interest;
		this.mem_major = mem_major;
		this.mem_area = mem_area;
		this.mentor_career = mentor_career;
	}
	public String getMentor_career() {
		return mentor_career;
	}
	public void setMentor_career(String mentor_career) {
		this.mentor_career = mentor_career;
	}
	public String getMem_id() {
		return mem_id;
	}
	public void setMem_id(String mem_id) {
		this.mem_id = mem_id;
	}
	public String getMem_pwd() {
		return mem_pwd;
	}
	public void setMem_pwd(String mem_pwd) {
		this.mem_pwd = mem_pwd;
	}
	public String getMem_email() {
		return mem_email;
	}
	public void setMem_email(String mem_email) {
		this.mem_email = mem_email;
	}
	public String getMem_name() {
		return mem_name;
	}
	public void setMem_name(String mem_name) {
		this.mem_name = mem_name;
	}
	public String getMem_gender() {
		return mem_gender;
	}
	public void setMem_gender(String mem_gender) {
		this.mem_gender = mem_gender;
	}
	public String getMem_interest() {
		return mem_interest;
	}
	public void setMem_interest(String mem_interest) {
		this.mem_interest = mem_interest;
	}
	public String getMem_major() {
		return mem_major;
	}
	public void setMem_major(String mem_major) {
		this.mem_major = mem_major;
	}
	public String getMem_area() {
		return mem_area;
	}
	public void setMem_area(String mem_area) {
		this.mem_area = mem_area;
	}
	
}
