package com.studybb.control;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.studybb.service.MemberService;
import com.studybb.vo.Member;

@WebServlet("/myprofile")
public class MyProfileServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	MemberService service;
    public MyProfileServlet() {
        service = new MemberService();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("loginInfo");
		//System.out.println("로그인아이디 받아지나요?" + id);
		
		Member member = service.profile(id);
		request.setAttribute("member", member);
		//System.out.println(member);
		
		String path = "/myProfile.jsp";
		RequestDispatcher rd = request.getRequestDispatcher(path);
		rd.forward(request, response);
	}

}
