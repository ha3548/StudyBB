package com.studybb.control;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/sse")
public class SSEServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/event-stream"); // Header에 Content Type을 Event Stream으로 설정
		response.setCharacterEncoding("UTF-8"); // Header에 encoding을 UTF-8로 설정
		PrintWriter writer = response.getWriter();
		for (int i = 1; i <= 10; i++) {
			writer.write("data: { \"message\" : \"number : " + i + "\" }\n\n");
			try {
				Thread.sleep(1000);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}
		writer.close();
	}

}



