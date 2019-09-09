package com.studybb.control;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.studybb.service.MemberService;

@WebServlet("/dupchk")
public class DupchkServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private MemberService service;
    public DupchkServlet() {
    	service = new MemberService();
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id = request.getParameter("id");
		String str = service.dupchk(id);
		
		request.setAttribute("result", str);
		String path = "/result.jsp";
		RequestDispatcher rd = request.getRequestDispatcher(path);
		rd.forward(request, response);
	}

}
