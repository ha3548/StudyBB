package com.studybb.control;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.studybb.service.LikeService;

@WebServlet("/boardlike")
public class BoardLikeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private LikeService service;
	
    public BoardLikeServlet() {
    	service = new LikeService();
    }

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String mem_id = request.getParameter("mem_id");
		String board_no = request.getParameter("board_no");
		
		int intNo = 0;
		if (board_no != null) {
			// NullPointException 회피
			intNo = Integer.parseInt(board_no);
		}

		// service 수행
		String result = service.boardlike(mem_id, intNo);
		request.setAttribute("result", result);
		
		String path = "/result.jsp";
		RequestDispatcher rd = request.getRequestDispatcher(path);
		rd.forward(request, response);
	}
}
