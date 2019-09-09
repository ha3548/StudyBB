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
import com.studybb.vo.Enrol;

@WebServlet("/manageenrol")
public class ManageEnrolServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private EnrolService service;

	public ManageEnrolServlet() {
		service = new EnrolService();
	}
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int study_no = Integer.parseInt(request.getParameter("study_no"));
		List<Enrol> list=null;
		try {
			list = service.getEnrolList(study_no);
			request.setAttribute("list",list);
			request.setAttribute("status",1);
		} catch (NotFoundException e) {
			request.setAttribute("status",-1);
			e.printStackTrace();
		}
		String path = "/manageenrol.jsp";
		RequestDispatcher rd = request.getRequestDispatcher(path);
		rd.forward(request, response);
	}

}
