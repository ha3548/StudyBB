package com.studybb.control;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;

import com.studybb.service.MemberService;
import com.studybb.vo.Member;

@WebServlet("/myprofileedit")
public class MyProfileEditServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	MemberService service;
    public MyProfileEditServlet() {
        service = new MemberService();
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("loginInfo");
		String gender = request.getParameter("gender");
		String interest = request.getParameter("interest");
		String major = request.getParameter("major");
		String area = request.getParameter("area");
		
		Member m = service.profile(id);
		m.setMem_id(id);
		m.setMem_gender(gender);
		m.setMem_interest(interest);
		m.setMem_major(major);
		m.setMem_area(area);

		Member member = service.edit(m);
		request.setAttribute("member", member);
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("status", 1);
		request.setAttribute("result", jsonObj.toString());
		
		String path = "/result.jsp";
		RequestDispatcher rd = request.getRequestDispatcher(path);
		rd.forward(request, response);
		
	}

}
