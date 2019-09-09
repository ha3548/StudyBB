package com.studybb.vo;

import java.util.Date;

public class Study {
   private int study_no;
   private Member member;
   private String study_leader_intro;
   private String study_title; //스터디제목
   private String study_area; //스터디지역
   private Date study_start; //스터디 개강날짜
   private int study_week; //몇주과정인가
   private Date study_due; //모집공고 마감일
   private String study_content; //스터디설명글
   private String study_tag;  //스터디 태그
   private Date study_upload; //모집공고 게시일
   private int study_type; //자율-0 / 멘토링-1
   private int study_price; //가격
   private int study_cap;//최대참가인원
   private int study_status; // 스터디 상태
   
   public Study() {}

   public Study(int study_no, Member member, String study_leader_intro, String study_title, String study_area, Date study_start, int study_week,
         Date study_due, String study_content, String study_tag, Date study_upload, int study_type,
         int study_price, int study_cap, int study_status) {
      this.study_no = study_no;
      this.member = member;
      this.study_leader_intro = study_leader_intro;
      this.study_title = study_title;
      this.study_area = study_area;
      this.study_start = study_start;
      this.study_week = study_week;
      this.study_due = study_due;
      this.study_content = study_content;
      this.study_tag = study_tag;
      this.study_upload = study_upload;
      this.study_type = study_type;
      this.study_price = study_price;
      this.study_cap = study_cap;
      this.study_status = study_status;
   }

	public Study(int study_no, String study_title, int study_price, int study_week, String mem_id, Date study_start) {
		this.study_no = study_no;
		this.study_title = study_title;
		this.study_start = study_start;
		this.study_week = study_week;
		this.study_price = study_price;
		Member member = new Member();
		member.setMem_id(mem_id);
		this.member = member;
	}

   public int getStudy_no() {
      return study_no;
   }

   public void setStudy_no(int study_no) {
      this.study_no = study_no;
   }

   public Member getMember() {
      return member;
   }

   public void setMember(Member member) {
      this.member = member;
   }

   public String getStudy_title() {
      return study_title;
   }

   public void setStudy_title(String study_title) {
      this.study_title = study_title;
   }
   
   public String getStudy_leader_intro() {
      return study_leader_intro;
   }
   
   public void setStudy_leader_intro(String study_leader_intro) {
      this.study_leader_intro = study_leader_intro;
   }
   

   public String getStudy_area() {
      return study_area;
   }

   public void setStudy_area(String study_area) {
      this.study_area = study_area;
   }

   public Date getStudy_start() {
      return study_start;
   }

   public void setStudy_start(Date study_start) {
      this.study_start = study_start;
   }

   public int getStudy_week() {
      return study_week;
   }

   public void setStudy_week(int study_week) {
      this.study_week = study_week;
   }

   public Date getStudy_due() {
      return study_due;
   }

   public void setStudy_due(Date study_due) {
      this.study_due = study_due;
   }

   public String getStudy_content() {
      return study_content;
   }

   public void setStudy_content(String study_content) {
      this.study_content = study_content;
   }

   public String getStudy_tag() {
      return study_tag;
   }

   public void setStudy_tag(String study_tag) {
      this.study_tag = study_tag;
   }

   public Date getStudy_upload() {
      return study_upload;
   }

   public void setStudy_upload(Date study_upload) {
      this.study_upload = study_upload;
   }

   public int getStudy_type() {
      return study_type;
   }

   public void setStudy_type(int study_type) {
      this.study_type = study_type;
   }

   public int getStudy_price() {
      return study_price;
   }

   public void setStudy_price(int study_price) {
      this.study_price = study_price;
   }

   public int getStudy_cap() {
      return study_cap;
   }

   public void setStudy_cap(int study_cap) {
      this.study_cap = study_cap;
   }

public int getStudy_status() {
	return study_status;
}

public void setStudy_status(int study_status) {
	this.study_status = study_status;
}

   
}
   
   