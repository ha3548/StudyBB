package com.studybb.control;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.studybb.exception.NotFoundException;
import com.studybb.service.EnrolService;
import com.studybb.service.StudyService;

@WebServlet("/editenrol")
public class EditEnrolServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private EnrolService service;
	public EditEnrolServlet() {
		service = new EnrolService();
	}
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int study_no = Integer.parseInt(request.getParameter("study_no"));
		String mem_id = request.getParameter("mem_id");
		int approval = Integer.parseInt(request.getParameter("approval"));
		
		int status=0;
		
		try {
			status = service.editEnrol(study_no, mem_id, approval);
		} catch (NotFoundException e) {
			e.printStackTrace();
		}
		
		request.setAttribute("result", status);

		String path = "/result.jsp";
		RequestDispatcher rd = request.getRequestDispatcher(path);
		rd.forward(request, response);
	}

}
