package com.studybb.control;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.studybb.exception.NotFoundException;
import com.studybb.service.EnrolService;
import com.studybb.service.StudyService;


@WebServlet("/managedelete")
public class ManageDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private StudyService service;

	public ManageDeleteServlet() {
		service = new StudyService();
	}

	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int study_no = Integer.parseInt(request.getParameter("study_no"));
		int status = 0;
		try {
			status = service.deleteStudy(study_no);
		} catch (NotFoundException e) {
			e.printStackTrace();
		}
		request.setAttribute("result", status);

		String path = "/result.jsp";
		RequestDispatcher rd = request.getRequestDispatcher(path);
		rd.forward(request, response);
	}

}
