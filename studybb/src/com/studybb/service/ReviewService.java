package com.studybb.service;

import java.util.List;

import com.studybb.dao.ReviewDAO;
import com.studybb.exception.NotFoundException;
import com.studybb.vo.Review;

public class ReviewService {
	ReviewDAO dao;
	
	public ReviewService() {
		dao = new ReviewDAO();
	}
	

	public List<Review> mentorReview(String mem_id) throws NotFoundException {
		List<Review> reviewlist = dao.getMentorReview(mem_id);
		return reviewlist;
	}

}
