package com.studybb.control;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.studybb.exception.NotFoundException;
import com.studybb.service.SearchService;
import com.studybb.vo.Study;

@WebServlet("/search")
public class SearchServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
 
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String study_area = request.getParameter("study_area");	//전체:전체
		int study_type = Integer.parseInt(request.getParameter("study_type"));//전체:2
		//System.out.println(study_area + " " + study_type);
		String study_tag = request.getParameter("study_tag");
		System.out.println("1:" + study_area + "," + study_type + "," + study_tag);
		System.out.println("-------------");		
		study_tag = "#" + study_tag.substring(1).replace("#", "|#");
		
		System.out.println("-------------");
		System.out.println("2:" + study_area + "," + study_type + "," + study_tag);
		
		SearchService service = new SearchService();
		List<Study> list = new ArrayList<Study>();
		try {
			list = service.search(study_area,study_type,study_tag);
			request.setAttribute("status", 1);
			request.setAttribute("list", list);
		} catch (NotFoundException e) {
			request.setAttribute("status", -1);
			e.printStackTrace();
		}

		request.getRequestURL();
		String path ="/searchresult.jsp";
		RequestDispatcher rd = 
				request.getRequestDispatcher(path);
		rd.forward(request, response);
	}
}
