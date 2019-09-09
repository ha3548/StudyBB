package com.studybb.service;

import com.studybb.dao.MentorDAO;
import com.studybb.exception.NotFoundException;
import com.studybb.vo.Mentor;

public class MentorService {
	MentorDAO dao;
	
	public MentorService() {
		dao = new MentorDAO();
	}
	
	public Mentor mentorInfo(String mem_id) throws NotFoundException {
		Mentor mentor = dao.getMentorInfo(mem_id);
		return mentor;
	}

}
