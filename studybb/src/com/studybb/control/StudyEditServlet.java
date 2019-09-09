package com.studybb.control;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.studybb.service.StudyService;
import com.studybb.vo.Member;
import com.studybb.vo.Study;

@WebServlet("/studyedit")
public class StudyEditServlet extends HttpServlet {
   private static final long serialVersionUID = 1L;
       
   private StudyService service;

   public StudyEditServlet() {
      service = new StudyService();
   }

   protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      // TODO Auto-generated method stub
      doGet(request, response);
   
//      파일이 저장될 서버의 경로
      String savePath = request.getServletContext().getRealPath("/images/study");
      System.out.println("savePath : "+savePath);

//      파일 크기 10MB로 제한
      int sizeLimit = 1024 * 1024 * 10;

      response.setContentType("text/html; charset=UTF-8");
      MultipartRequest multi = new MultipartRequest(request, savePath, sizeLimit, "utf-8");   
      
      String mem_id = multi.getParameter("mem_id");
      String str_study_no = multi.getParameter("study_no");
      int study_no = Integer.parseInt(str_study_no);
      String study_title = multi.getParameter("study_title");
      String study_leader_intro = multi.getParameter("study_leader_intro");
      String study_area = multi.getParameter("study_area");
      String study_start = multi.getParameter("study_start");
      int study_week = Integer.parseInt(multi.getParameter("study_week"));
      int study_price = Integer.parseInt(multi.getParameter("study_price"));
      String study_due = multi.getParameter("study_due");
      String study_content = multi.getParameter("study_content");
      String study_tag = multi.getParameter("study_tag");
      int study_cap = Integer.parseInt(multi.getParameter("study_cap"));
      
//      System.out.println("스터디제목 : "+study_title);
      
      String str = "";
      try {
         Study study = new Study();
         Member member = new Member();
         member.setMem_id(mem_id);
         study.setMember(member);
         study.setStudy_no(study_no);
         study.setStudy_title(study_title);
         study.setStudy_leader_intro(study_leader_intro);
         study.setStudy_area(study_area);
         study.setStudy_week(study_week);
         study.setStudy_price(study_price);
         study.setStudy_content(study_content);
         study.setStudy_tag(study_tag);
         study.setStudy_cap(study_cap);
         
         SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
         Date start_dt =sdf.parse(study_start);
         study.setStudy_start(start_dt);
         study.setStudy_due(sdf.parse(study_due));
            
         str = service.studyEdit(study);
         System.out.println(str);
         
//-----------------------------------------------
         
         String fileName = multi.getFilesystemName("study_image");//업로드한 파일명 알아오기
         System.out.println("fileName : "+fileName);
         int i = -1;
         i = fileName.lastIndexOf("."); // 파일 확장자 위치
         
         String realFileName = str_study_no + fileName.substring(i, fileName.length()); // 현재시간과 확장자 합치기
         System.out.println("realFileName : "+realFileName);
         
         File oldFile = new File(savePath + "/" + fileName);
         File newFile = new File(savePath + "/" + realFileName);
               
         oldFile.renameTo(newFile); // 파일명 변경
//------------------------------------------------------         
      }catch (java.text.ParseException e) {
         e.printStackTrace();
      }

      request.setAttribute("result", str);
      String path = "/result.jsp";
      RequestDispatcher rd = 
            request.getRequestDispatcher(path);
      rd.forward(request, response);
   
   }

}