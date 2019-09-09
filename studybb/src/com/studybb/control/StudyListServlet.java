package com.studybb.control;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.studybb.exception.NotFoundException;
import com.studybb.service.StudyService;
import com.studybb.vo.PageBean;
import com.studybb.vo.Study;

@WebServlet("/studylist")
public class StudyListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private StudyService service;
	
    public StudyListServlet() {
    	service = new StudyService();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	PageBean<Study>	 pb = new PageBean<Study>();
    	System.out.println("get");
    	try {
			pb = service.search();
			request.setAttribute("pb", pb);
			request.setAttribute("status", 1); // 정상 처리
		} catch (NotFoundException e) {
			e.printStackTrace();
			request.setAttribute("status", -1); // 실패
		}
    	System.out.println("get:" + request.getAttribute("status"));
    	String path = "/search.jsp";
    	RequestDispatcher rd = request.getRequestDispatcher(path);
		rd.forward(request, response);
    }
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String area = request.getParameter("area");	//전체:전체
		int type = Integer.parseInt(request.getParameter("type"));//전체:2
		//System.out.println(study_area + " " + study_type);
		String tag = request.getParameter("tag");
		System.out.println("tag: " + tag);
		if(!"".equals(tag)) {
			tag = "#" + tag.substring(1).replace("#", "|#");
		}
		
		String strNo = request.getParameter("no");
		int no = 1;
		if(strNo != null)
			no = Integer.parseInt(strNo);
		System.out.println(area + type + tag + no);
		try {
			PageBean<Study> pb = service.search(area, type, tag, no);
			request.setAttribute("pb", pb);
			request.setAttribute("status", 1); // 정상 처리
		} catch (NotFoundException e) {
			e.printStackTrace();
			request.setAttribute("status", -1); // 실패
		}
		
		String path = "/searchresult.jsp";
		
		RequestDispatcher rd = request.getRequestDispatcher(path);
		rd.forward(request, response);
	}

}
