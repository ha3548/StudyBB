package com.studybb.service;

import java.util.ArrayList;
import java.util.List;

import org.json.simple.JSONObject;

import com.studybb.dao.StudyDAO;
import com.studybb.exception.NotFoundException;
import com.studybb.vo.Study;

public class SearchService {
	private StudyDAO dao;
	public SearchService() {
		dao = new StudyDAO();
	}
	
	
	public List<Study> search(String study_area, int study_type, String study_tag) throws NotFoundException {
		int status = -1;
		String msg = "데이터 없다";
		List<Study> list = new ArrayList<Study>();
		list = dao.selectBySearch(study_area,study_type,study_tag);

		JSONObject jsonObj = new JSONObject();
		jsonObj.put("list",list);
		jsonObj.put("msg", msg);
		String str = jsonObj.toString();
		return list;
	
	}



}