package com.studybb.control;

import java.io.IOException;
import java.util.Date;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import com.studybb.service.MemberService;

@WebServlet("/searchpwd")
public class SearchPwdServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	MemberService service;
    public SearchPwdServlet() {
    	service = new MemberService();
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id = request.getParameter("id");
		String email = request.getParameter("email");
		String pwd = service.searchpwd(id, email);
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("pwd", pwd);
		
		if(pwd!=null) {
			Properties props = System.getProperties();
	        props.put("mail.smtp.user", "djbs.Postme"); // 서버 아이디만 쓰기
			props.put("mail.smtp.host", "smtp.gmail.com"); // 구글 SMTP
			props.put("mail.smtp.port", "465");
			props.put("mail.smtp.starttls.enable", "true");
			props.put("mail.smtp.auth", "true");
			props.put("mail.smtp.socketFactory.port", "465");
			props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
			props.put("mail.smtp.socketFactory.fallback", "false");
	           
	        Authenticator auth = new MyAuthentication();
	         
	        //session 생성 및  MimeMessage생성
	        Session session = Session.getDefaultInstance(props, auth);
	        MimeMessage msg = new MimeMessage(session);
	         
	        try{
	            //편지보낸시간
	            msg.setSentDate(new Date());
	            InternetAddress from = new InternetAddress("STUDYBB");        
	            // 이메일 발신자
	            msg.setFrom(from);           
	            // 이메일 수신자
	            InternetAddress to = new InternetAddress(email);
	            msg.setRecipient(Message.RecipientType.TO, to);
	            // 이메일 제목
	            msg.setSubject("스터디봉봉 비밀번호입니다.", "UTF-8");
	            // 이메일 내용
	            msg.setText("회원님의 비밀번호는 " + pwd + "입니다.", "UTF-8");
	            // 이메일 헤더
	            msg.setHeader("content-Type", "text/html");
	            //메일보내기
	            javax.mail.Transport.send(msg);
	            System.out.println("이메일전송완료");
	            
	            jsonObj.put("status", 1);//비번있고 이메일 성공
	            
	        }catch (AddressException addr_e) {
	            addr_e.printStackTrace();
	            jsonObj.put("status", -2); //이메일 실패
	        }catch (MessagingException msg_e) {
	            msg_e.printStackTrace();
	            jsonObj.put("status", -2);
	        }
		} else {
		 jsonObj.put("status", -1);//비번없는 경우
		}
		
		request.setAttribute("result", jsonObj.toString());
		String path = "/result.jsp";
		RequestDispatcher rd = request.getRequestDispatcher(path);
		rd.forward(request, response);
	}

}