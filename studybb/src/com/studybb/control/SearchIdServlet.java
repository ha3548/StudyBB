package com.studybb.control;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.studybb.service.MemberService;

@WebServlet("/searchid")
public class SearchIdServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	MemberService service;
    public SearchIdServlet() {
    	service = new MemberService();
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String email = request.getParameter("email");
		String str = service.searchid(email);
		
		request.setAttribute("result", str);
		String path = "/result.jsp";
		RequestDispatcher rd = request.getRequestDispatcher(path);
		rd.forward(request, response);
	}

}
