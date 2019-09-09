package com.studybb.control;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.studybb.exception.NotFoundException;
import com.studybb.service.MentorService;
import com.studybb.service.ReviewService;
import com.studybb.service.StudyService;
import com.studybb.vo.Mentor;
import com.studybb.vo.Review;
import com.studybb.vo.Study;

@WebServlet("/studydetail")
public class StudyDetailServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private StudyService service;

	public StudyDetailServlet() {
		service = new StudyService();
	}

	public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int study_no = Integer.parseInt(request.getParameter("study_no"));
		try {
			Study study = service.studyDetail(study_no);
			request.setAttribute("study", study);
			if (study.getStudy_type() == 1) {// 멘토링스터디일 경우

				MentorService mentorService = new MentorService();
				ReviewService reviewService = new ReviewService();
				Mentor mentor = mentorService.mentorInfo(study.getMember().getMem_id());
				request.setAttribute("mentor", mentor);
				List<Review> review = reviewService.mentorReview(study.getMember().getMem_id());
				request.setAttribute("review", review);
			}
		} catch (NotFoundException e) {
			e.printStackTrace();
		}

		String path = "/studydetail.jsp";
		RequestDispatcher rd = request.getRequestDispatcher(path);
		rd.forward(request, response);
	}

}
