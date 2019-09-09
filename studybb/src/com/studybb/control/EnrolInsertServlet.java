package com.studybb.control;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.studybb.service.EnrolService;
import com.studybb.vo.Enrol;
import com.studybb.vo.Member;
import com.studybb.vo.Study;

@WebServlet("/enrolinsert")
public class EnrolInsertServlet extends HttpServlet {
   private static final long serialVersionUID = 1L;
   private EnrolService service;
    public EnrolInsertServlet() {
        service = new EnrolService();
    }
   protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      System.out.println("EnrolInsertServlet 실행");
      String str_study_no = request.getParameter("study_no");
      if(str_study_no == null) {
         str_study_no = "1";
      }
      int study_no = Integer.parseInt(str_study_no);
      //int study_no = Integer.parseInt(request.getParameter("study_no"));
      String mem_id = request.getParameter("mem_id");
      String enrol_say = request.getParameter("enrol_say");
      //int enrol_status = Integer.parseInt(request.getParameter("enrol_status"));
      String str_enrol_status = request.getParameter("enrol_status");
      if(str_enrol_status == null) {
         str_enrol_status = "0";
      }
      int enrol_status = Integer.parseInt(str_enrol_status);
      
		/*
		 * System.out.println("study_no : "+study_no); System.out.println("mem_id : " +
		 * mem_id); System.out.println("enrol_say : " + enrol_say);
		 * System.out.println("enrol_status : " + enrol_status);
		 */
   
      Enrol enrol = new Enrol();
      Study study = new Study();
      study.setStudy_no(study_no);
      enrol.setStudy(study);
      Member member = new Member();
      member.setMem_id(mem_id);
      enrol.setMember(member);
      enrol.setEnrol_say(enrol_say);
      enrol.setEnrol_status(enrol_status);
      String str = null;
      str = service.enrolInsert(enrol);
      request.setAttribute("result", str);
      
      String path="/result.jsp";
      RequestDispatcher rd = request.getRequestDispatcher(path);
      rd.forward(request, response);

   }

}