package com.studybb.control;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.studybb.exception.NotFoundException;
import com.studybb.service.StudyService;

@WebServlet("/studyopen")
public class StudyOpenServlet extends HttpServlet {
   private static final long serialVersionUID = 1L;
   
   private StudyService service;
    public StudyOpenServlet() {
       service = new StudyService();
    }
   
   protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      HttpSession session = request.getSession();
      //String mem_id = request.getParameter("mem_id");
      String str = "";
      try {
         str = service.mentorChk((String)session.getAttribute("loginInfo"));
         System.out.println(str);
         request.setAttribute("status", 1);
      } catch (NotFoundException e) {
         // status -1
         request.setAttribute("status", -1);
         e.printStackTrace();
      }
      request.setAttribute("result", str);
      String path = "/result.jsp";
      RequestDispatcher rd = 
            request.getRequestDispatcher(path);
      rd.forward(request, response);
   }

}