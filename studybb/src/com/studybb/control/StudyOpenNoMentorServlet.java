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

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.studybb.service.StudyService;
import com.studybb.vo.Member;
import com.studybb.vo.Study;

@WebServlet("/studyopennomentor")
public class StudyOpenNoMentorServlet extends HttpServlet {
   private static final long serialVersionUID = 1L;
       
   private StudyService service;
    public StudyOpenNoMentorServlet() {
       service = new StudyService();
    }
    
   protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

//      파일이 저장될 서버의 경로
      String savePath = request.getServletContext().getRealPath("/images/study");
      System.out.println("savePath : "+savePath);

//      파일 크기 10MB로 제한
      int sizeLimit = 1024 * 1024 * 10;

      response.setContentType("text/html; charset=UTF-8");
      MultipartRequest multi = new MultipartRequest(request, savePath, sizeLimit, "utf-8",
            new DefaultFileRenamePolicy());   
      
      String mem_id = multi.getParameter("mem_id");
      String study_title = multi.getParameter("study_title");
      String study_leader_intro = multi.getParameter("study_leader_intro");
      String study_area = multi.getParameter("study_area");
      String study_start = multi.getParameter("study_start");
      int study_week = Integer.parseInt(multi.getParameter("study_week"));
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
         study.setStudy_title(study_title);
         study.setStudy_leader_intro(study_leader_intro);
         study.setStudy_area(study_area);
         study.setStudy_week(study_week);
         study.setStudy_price(0);
         study.setStudy_content(study_content);
         study.setStudy_tag(study_tag);
         study.setStudy_cap(study_cap);
         
         SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
         Date start_dt =sdf.parse(study_start);
         study.setStudy_start(start_dt);
         study.setStudy_due(sdf.parse(study_due));
            
         str = service.studyOpen(study);
         System.out.println(str);
         
//-----------------------------------------------
         
         String fileName = multi.getFilesystemName("study_image");//업로드한 파일명 알아오기
         System.out.println("fileName : "+fileName);
         int i = -1;
         i = fileName.lastIndexOf("."); // 파일 확장자 위치
         
         JSONParser parser = new JSONParser();
         JSONObject jsonObj = (JSONObject) parser.parse(str);
         Object study_no = jsonObj.get("study_no");
         String realFileName = study_no + fileName.substring(i, fileName.length()); // 현재시간과 확장자 합치기
         System.out.println("realFileName : "+realFileName);
         
         File oldFile = new File(savePath + "/" + fileName);
         File newFile = new File(savePath + "/" + realFileName);
               
         oldFile.renameTo(newFile); // 파일명 변경
//------------------------------------------------------         
      } catch (ParseException e) {
         e.printStackTrace();
      } catch (java.text.ParseException e) {
         e.printStackTrace();
      }

      request.setAttribute("result", str);
      String path = "/result.jsp";
      RequestDispatcher rd = 
            request.getRequestDispatcher(path);
      rd.forward(request, response);
      
   }
}