package com.studybb.control;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.studybb.exception.NotFoundException;
import com.studybb.service.BoardService;
import com.studybb.vo.Board;
import com.studybb.vo.PageBean;

@WebServlet("/boardcomment")
public class BoardCommentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private BoardService service;

	public BoardCommentServlet() {
		service = new BoardService();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		System.out.println("servlet");
		String board_no = request.getParameter("board_no");
		String page = request.getParameter("page");
		int intBno = 1;
		int intPage = 1;
		
		if (board_no != null) {
			// NullPointException 회피
			intBno = Integer.parseInt(board_no);
		} else if (page != null) {
			// NullPointException 회피
			intPage = Integer.parseInt(page);
		}

		try {
			System.out.println("try"+intBno+ " " + intPage);
			PageBean<Board> pb = service.commentlist(intBno, intPage);
			request.setAttribute("pb", pb);
			request.setAttribute("status", 1); // 정상 처리
		} catch (NotFoundException e) {
			e.printStackTrace();
			request.setAttribute("status", -1); // 실패
			System.out.println("catch");
		}
		
		String path = "/comment.jsp";
		RequestDispatcher rd = request.getRequestDispatcher(path);
		rd.forward(request, response);
	}
}
