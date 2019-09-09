package com.studybb.service;

import java.util.List;

import com.studybb.dao.EnrolDAO;
import com.studybb.dao.StudyDAO;
import com.studybb.exception.AddException;
import com.studybb.exception.NotFoundException;
import com.studybb.vo.Enrol;
import com.studybb.vo.Study;

public class EnrolService {
	EnrolDAO dao;

	public EnrolService() {
		dao = new EnrolDAO();
	}

	//MyPage>MyStudy에서 보여줄 study목록
	public List<Enrol> getMyEnrolList(String mem_id) throws NotFoundException {
		List<Enrol> list = dao.selectMyEnrolList(mem_id);
		return list;
	}
	   
	public List<Enrol> getEnrolList(int study_no) throws NotFoundException {
		List<Enrol> list = dao.getEnrolList(study_no);
		return list;
	}

	// 신청자의 상태 변경 -> 정원 초과 시, study상태 변경
	public int editEnrol(int study_no, String mem_id, int approval) throws NotFoundException {
		int result = 0;

		if (dao.isMax(study_no)) { // 스터디 정원 조회
				return result;
		}
		result = dao.editErol(study_no, mem_id, approval); // approval은 1또는 2
		String message = null;
		if (result == 1) { // 신청자 상태변경 성공
			message = "스터디에 참여 승인 되었습니다.";
			if (approval == 1) {// 가입 승인
				if (dao.isMax(study_no)) { // 스터디 정원 조회
					StudyDAO sdao = new StudyDAO();
					if (sdao.editStatus(study_no) == 1) //스터디 상태 변경
						result = 2;
				}
			} else if (approval == 2) { // 가입 거절
				message = "스터디에 참여 거절 되었습니다.";
			}
			// 가입 승인/거절 알람 보냄.
			// AlarmDAO dao = new AlarmDAO
		}
		return result; // result=0이면 상태변경 실패, result = 1이면 상태 변경 성공, 2이면 성공and스터디 마감

	}
 
	// 가입신청
	public String enrolInsert(Enrol enrol) {
		try {
			dao.insert(enrol);
			return "신청 성공";
		} catch (AddException e) {
			e.printStackTrace();
			return "신청 실패";
		}
	}

	public Study getStudyDetail(int study_no) throws NotFoundException {
		// dao호출
		StudyDAO dao = new StudyDAO();
		Study study = new Study();

		study = dao.getStudyDetail(study_no);
		// System.out.println(study.getStudy_area());
		return study;

	}

}
