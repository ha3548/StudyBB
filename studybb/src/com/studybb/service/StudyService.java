package com.studybb.service;

import java.util.List;

import org.json.simple.JSONObject;

import com.studybb.dao.StudyDAO;
import com.studybb.exception.AddException;
import com.studybb.exception.NotFoundException;
import com.studybb.vo.PageBean;
import com.studybb.vo.Study;

public class StudyService {
	StudyDAO dao;

	public StudyService() {
		dao = new StudyDAO();
	}
	
	public Study studyDetail(int study_no) throws NotFoundException{		
		Study study = dao.getStudyDetail(study_no);
		return study;
	}

	public int deleteStudy(int study_no) throws NotFoundException {
		int result = 0;
		int status = dao.getStatus(study_no);
		if(status == 0 ||status == 2) { //study_status 가 null또는0, 2인 경우 delete 가능
			result = dao.deleteStudy(study_no);			
		}
		return result;
	}

	public PageBean<Study> search(String study_area, int study_type, String study_tag, int startRow) 
			throws NotFoundException {
		int cntPerPage = 99; // 한 페이지 별 보여줄 게시글 수
		int endRow = startRow + cntPerPage - 1;
		
		List<Study> list = dao.selectBySearch(study_area, study_type, study_tag, startRow, endRow);
		int totalCnt = 0;
		totalCnt = dao.count(study_area, study_type, study_tag);
		PageBean<Study> pb = new PageBean<>();
		pb.setCntPerPage(cntPerPage); // 페이지 별 목록수
		pb.setList(list); // 페이지 목록
		pb.setTotalCnt(totalCnt); // 총 건수

		return pb;
	}

	public PageBean<Study> search() throws NotFoundException {
		return search("전체", 2, "", 1);
	}
	
	public String mentorChk(String id) throws NotFoundException {
		int status = -1;
		try {
			status = dao.selectById(id);
		} catch(NotFoundException e) {
			e.printStackTrace();
		} 
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("status", status);
		String str = jsonObj.toString();
		System.out.println(str);
		return str;
	}
	
	public String studyOpen(Study study) {
		JSONObject jsonObj = new JSONObject();
		int status = -1;
		try {
				int study_no = dao.insertStudyAndSelectStudy_seq(study);
				status = 1;
				jsonObj.put("study_no", study_no);
		} catch(AddException e) {
			e.printStackTrace();
		} 
		jsonObj.put("status", status);
		String str = jsonObj.toString();
		System.out.println(str);
		return str;
	}
	
	public String studyEdit(Study study) {
		JSONObject jsonObj = new JSONObject();
		int status = -1;
		try {
				dao.updateStudy(study);
				status = 1;
		} catch(AddException e) {
			e.printStackTrace();
		} 
		jsonObj.put("status", status);
		String str = jsonObj.toString();
		System.out.println(str);
		return str;
	}
}
