package com.studybb.control;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.studybb.exception.NotFoundException;
import com.studybb.service.EnrolService;
import com.studybb.vo.Enrol;

@WebServlet("/mystudy")
public class MyStudyServlet extends HttpServlet {
   private static final long serialVersionUID = 1L;
   private EnrolService service;   
 
    public MyStudyServlet() {
       this.service = new EnrolService();
    }

protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      try {
         HttpSession session = request.getSession();
         String id = (String)session.getAttribute("loginInfo");
         List<Enrol> myList = service.getMyEnrolList(id);
         request.setAttribute("myList", myList);
      } catch (NotFoundException e) {
         // TODO Auto-generated catch block
         e.printStackTrace();
      }

      // request객체 저장 dispatcher: enrollayout.jsp
      String path = "/myStudy.jsp";
      RequestDispatcher rd = request.getRequestDispatcher(path);
      rd.forward(request, response);
   }

}