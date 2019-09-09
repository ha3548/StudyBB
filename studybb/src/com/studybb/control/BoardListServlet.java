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
import com.studybb.vo.Study;

@WebServlet("/boardlist")
public class BoardListServlet extends HttpServlet {
   private static final long serialVersionUID = 1L;
   private BoardService service;

   public BoardListServlet() {
      service = new BoardService();
   }

   protected void doGet(HttpServletRequest request, HttpServletResponse response)
         throws ServletException, IOException {
      try {
         PageBean<Board> pb = new PageBean<Board>();
         pb = service.boardList();
         request.setAttribute("pb", pb);
         request.setAttribute("status", 1); // 정상 처리
         request.setAttribute("type", "recent");
         System.out.println(pb.getList().get(1).getBoard_content());
      } catch (NotFoundException e) {
         e.printStackTrace();
         request.setAttribute("status", -1); // 실패
      }

      // 처음 페이지 로드
      // jsp로 데이터를 넘겨주고 forward
      String path = "/boardresult.jsp";
      RequestDispatcher rd = request.getRequestDispatcher(path);
      rd.forward(request, response);
   }

   protected void doPost(HttpServletRequest request, HttpServletResponse response)
         throws ServletException, IOException {

      String type = request.getParameter("type");
      String no = request.getParameter("no");
      String input = request.getParameter("input");
      System.out.println("보내진 값post:"+ type + " " + no + " " + input);
      int intNo = 1;
      if (no != null && !"NaN".equals(no)) {
         // NullPointException 회피
         intNo = Integer.parseInt(no);
      }

      try {
         PageBean<Board> pb = new PageBean<Board>();

         pb = service.boardList(intNo, type, input);

         request.setAttribute("pb", pb);
         request.setAttribute("status", 1); // 정상 처리
         request.setAttribute("type", type);
      } catch (NotFoundException e) {
         e.printStackTrace();
         request.setAttribute("status", -1); // 실패
      }

      String path = "/boardresult.jsp";

      RequestDispatcher rd = request.getRequestDispatcher(path);
      rd.forward(request, response);
   }
}