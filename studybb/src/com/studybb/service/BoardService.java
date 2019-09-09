package com.studybb.service;

import java.util.List;

import org.json.simple.JSONObject;

import com.studybb.dao.BoardDAO;
import com.studybb.exception.AddException;
import com.studybb.exception.NotFoundException;
import com.studybb.vo.Board;
import com.studybb.vo.PageBean;

public class BoardService {
   private BoardDAO dao;

   public BoardService() {
      dao = new BoardDAO();
   }

   public com.studybb.vo.PageBean<Board> boardList() throws NotFoundException {
      // return dao.select(1, 10);
      System.out.println("기본 서비스 호출!!!!!!!!!!!!!!!!!!!!!!!");
      return boardList(1, "recent", "");
   }

   public com.studybb.vo.PageBean<Board> boardList(int startRow, String type, String input) 
         throws NotFoundException {
      int cntPerPage = 10; // 한 페이지 별 보여줄 게시글 수
      int endRow = startRow + cntPerPage - 1;
      
      List<Board> list = dao.selectList(startRow, endRow, type, input);
      int totalCnt = 0;
      if(!"".equals(input)) {
         totalCnt = dao.count(input);
      } else {
         totalCnt = dao.count();
      }
      PageBean<Board> pb = new PageBean<>();
      pb.setCntPerPage(cntPerPage); // 페이지 별 목록수
      pb.setList(list); // 페이지 목록
      pb.setTotalCnt(totalCnt); // 총 건수
      System.out.println("service: "+ totalCnt);

      return pb;
   }
   
   public String boardWirte(String mem_id, String board_content, String board_tag) {
      int status = -1;
      String msg = "write fail";
      // root board 생성자
      Board b = new Board(mem_id, board_content, board_tag);
      try {
         dao.insert(b);
         status = 1;
      } catch (AddException e) {
         msg += e.getMessage();
         e.printStackTrace();
      }
      
      JSONObject jsonObj = new JSONObject();
      jsonObj.put("status", status);
      jsonObj.put("msg", msg);
      
      String str = jsonObj.toString();
      return str;
   }

   public PageBean<Board> replyWrite(String mem_id, String board_content, String board_tag, 
         int parent_no) throws NotFoundException, AddException{
      // reply 생성자
      Board b = new Board(mem_id, board_content, parent_no);
      dao.insert(b);
      return commentlist(parent_no, 1);
   }

   public String boardDelete(int board_no) {
      int status = -1;
      try {
         dao.delete(board_no);
         status = 1;
      } catch (NotFoundException e) {
         e.printStackTrace();
      }
      
      JSONObject jsonObj = new JSONObject();
      jsonObj.put("status", status);
      
      String str = jsonObj.toString();
      return str;
   }

   public PageBean<Board> commentlist(int parent_no, int currentPage) throws NotFoundException {
      int cntPerPage = 10;         // 한 페이지 별 보여줄 목록 수 
      int startRow = (currentPage - 1) * cntPerPage + 1;
      int endRow = currentPage * cntPerPage;
      List<Board> list = dao.selectComment(parent_no, startRow, endRow);
      
      int totalCnt = dao.count(parent_no);
      int maxPage = (int)(Math.ceil((float)totalCnt/cntPerPage));
      
      PageBean<Board> pb = new PageBean<>();
      pb.setCurrentPage(currentPage);   // 현재 페이지
      pb.setCntPerPage(cntPerPage);   // 페이지 별 목록수
      pb.setList(list);            // 페이지 목록
      pb.setTotalCnt(totalCnt);      // 총 건수
      pb.setMaxPage(maxPage);         // 최대 페이지 수
      
      return pb;
   }
}