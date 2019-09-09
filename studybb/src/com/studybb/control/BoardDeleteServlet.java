package com.studybb.control;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.studybb.service.BoardService;

@WebServlet("/boarddelete")
public class BoardDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private BoardService service;

	public BoardDeleteServlet() {
		service = new BoardService();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// data 가져오기
		int intNo = 0;
		String board_no = request.getParameter("board_no");
		if (board_no != null) {
			// NullPointException 회피
			intNo = Integer.parseInt(board_no);
		}
		
		// service 수행
		String result = service.boardDelete(intNo);
		request.setAttribute("result", result);

		// 결과 전송
		String path = "/result.jsp";
		RequestDispatcher rd = request.getRequestDispatcher(path);
		rd.forward(request, response);
	}

}
