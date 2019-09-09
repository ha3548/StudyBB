package com.studybb.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.studybb.exception.NotFoundException;
import com.studybb.vo.Member;
import com.studybb.vo.Mentor;

public class MentorDAO {
	public Mentor getMentorInfo(String mem_id) throws NotFoundException{
		Mentor mentor = null;
		
		Connection conn = null;
		ResultSet rs = null;
		PreparedStatement stmt = null;
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "STUDYBB", "wow130");
			String SQL = "select * from mentor where mem_id=?";
			stmt = conn.prepareStatement(SQL);
			stmt.setString(1, mem_id);

			rs = stmt.executeQuery();

			if (rs.next()) {
				mentor = new Mentor();
				
				Member member = new Member();
				member.setMem_id(mem_id);
				mentor.setMember(member);
				mentor.setMentor_career(rs.getString("mentor_career"));
				mentor.setMentor_status(rs.getInt("mentor_status"));
			}
			else{
				throw new NotFoundException("해당하는 멘토가 없습니다.");
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
		return mentor;
	}
}
