package com.studybb.vo;

import java.util.Date;

public class Review {
	private Study Study;
	private Member member;//리뷰 작성자
	private Date review_date;
	private String review_content;
	
	public Review() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public Review(com.studybb.vo.Study study, Member member, Date review_date, String review_content) {
		super();
		Study = study;
		this.member = member;
		this.review_date = review_date;
		this.review_content = review_content;
	}
	
	public Study getStudy() {
		return Study;
	}
	public void setStudy(Study study) {
		Study = study;
	}
	public Member getMember() {
		return member;
	}
	public void setMember(Member member) {
		this.member = member;
	}
	public Date getReview_date() {
		return review_date;
	}
	public void setReview_date(Date review_date) {
		this.review_date = review_date;
	}
	public String getReview_content() {
		return review_content;
	}
	public void setReview_content(String review_content) {
		this.review_content = review_content;
	}
	
}
