package com.studybb.control;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.studybb.dao.StudyDAO;
import com.studybb.exception.NotFoundException;
import com.studybb.service.EnrolService;
import com.studybb.vo.Study;

// 멘토스터디 신청
@WebServlet("/enrol")
public class EnrolServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private EnrolService service;

	public EnrolServlet() {
		this.service = new EnrolService();
	}

	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// int study_no = Integer.parseInt(request.getParameter("study_no"));
		String str_study_no = request.getParameter("study_no");
		if (str_study_no == null) {
			str_study_no = "0";
		}
		int study_no = Integer.parseInt(str_study_no);
		// System.out.println("스터디번호"+study_no);

		try {
			Study study = service.getStudyDetail(study_no);
			request.setAttribute("study", study);
		} catch (NotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		// request객체 저장 dispatcher: enrollayout.jsp
		String path = "/enrollayout.jsp";
		RequestDispatcher rd = request.getRequestDispatcher(path);
		rd.forward(request, response);
	}

}