package com.studybb.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.studybb.exception.NotFoundException;
import com.studybb.vo.Member;
import com.studybb.vo.Review;
import com.studybb.vo.Study;

public class ReviewDAO {

	public List<Review> getMentorReview(String mem_id) throws NotFoundException {
		List<Review> list = new ArrayList<Review>();
		
		Connection conn = null;
		ResultSet rs = null;
		PreparedStatement stmt = null;
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "STUDYBB", "wow130");
//			String SQL = "select review.mem_id as 리뷰작성자, study_no, review_content, review_date, study_title "
//					+ "from review join study using(study_no) "
//					+ "where study_no in(select study_no "  
//					+ "from study s join mentor m " 
//					+ "on s.mem_id = m.mem_id " 
//					+ "where s.mem_id = ?)";
			 
			String SQL = "select member.mem_name as 작성자이름, member.mem_id as 작성자아이디, review_content, "
					+ "review_date, study_title, study.study_no as 스터디번호 "
			+"from review join member on(review.mem_id = member.mem_id) "
			+"join study on(study.study_no = review.study_no) "
			+"where study.study_no in(select study_no "
			+ "from study s join mentor m "
			+"on s.mem_id = m.mem_id "
			+"where s.mem_id =?)";
			stmt = conn.prepareStatement(SQL);
			stmt.setString(1, mem_id);

			rs = stmt.executeQuery();

			while (rs.next()) {
				Review review = new Review();
				
				Member member = new Member();//리뷰작성자
				member.setMem_id(rs.getString(2));
				member.setMem_name(rs.getString(1));
				review.setMember(member);
				
				review.setReview_content(rs.getString("review_content"));
				review.setReview_date(rs.getDate("review_date"));
				Study study = new Study();
				study.setStudy_no(rs.getInt(6));
				study.setStudy_title(rs.getString("study_title"));
				review.setStudy(study);
				
				list.add(review);
			}
			if (list.size()==0) {
				throw new NotFoundException("멘토의 리뷰가 없습니다.");
			}

		} catch (ClassNotFoundException | SQLException e) {
			throw new NotFoundException(e.getMessage());
		} finally {
			try {
				rs.close();
				stmt.close();
				conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return list;
	}

}
