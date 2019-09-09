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
import com.studybb.vo.Study;

@WebServlet("/studyeditshow")
public class StudyEditShowServlet extends HttpServlet {
   private static final long serialVersionUID = 1L;
    StudyService service;   
   
    public StudyEditShowServlet() {
       service = new StudyService();
    }

   protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      
      int study_no = Integer.parseInt(request.getParameter("study_no"));
      System.out.println("서블릿도착 & 스터디_넘버"+study_no);
      
      try {
         Study study = service.studyDetail(study_no);
         request.setAttribute("study", study);
      } catch (NotFoundException e) {
         // TODO Auto-generated catch block
         e.printStackTrace();
      }
      
      String path = "/studyEdit.jsp";
      RequestDispatcher rd = request.getRequestDispatcher(path);
      rd.forward(request, response);
      
   }

}