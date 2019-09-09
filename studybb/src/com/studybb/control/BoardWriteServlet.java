package com.studybb.control;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.studybb.exception.AddException;
import com.studybb.exception.NotFoundException;
import com.studybb.service.BoardService;
import com.studybb.vo.Board;
import com.studybb.vo.PageBean;

@WebServlet("/boardwrite")
public class BoardWriteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private BoardService service;

	public BoardWriteServlet() {
		service = new BoardService();
	}

	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// data 가져오기
		String mem_id = request.getParameter("mem_id");
		String board_content = request.getParameter("board_content");
		String board_tag = request.getParameter("board_tag");
		String parent_no = request.getParameter("parent_no");

		// service 수행
		String path = "/result.jsp";
		if (parent_no != null) {
			// parent가 있을 시 댓글 작성
			int intPno = 1;
			intPno = Integer.parseInt(parent_no);
			try {
			  PageBean<Board> pb = service.replyWrite(mem_id, board_content, null, intPno);
			  request.setAttribute("pb", pb);
			  request.setAttribute("status", 1); // 정상 처리
			} catch(NotFoundException e) {
				e.printStackTrace();
				request.setAttribute("status", -1); // 댓글 불러오기 실패
			} catch(AddException e) {
				e.printStackTrace();
				request.setAttribute("ststus", 2);  // 댓글 등록 실패
			}
			path = "/comment.jsp";			
		} else {
			// 그 외에는 원글 작성
			String result = service.boardWirte(mem_id, board_content, board_tag);
			request.setAttribute("result", result);
		}
		
		// 결과 전송
		RequestDispatcher rd = request.getRequestDispatcher(path);
		rd.forward(request, response);
	}
}
