package com.studybb.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.studybb.exception.AddException;
import com.studybb.vo.Likes;

public class LikeDAO {
	private String url = "jdbc:oracle:thin:@localhost:1521:xe";
	private String user = "STUDYBB";
	private String pw = "wow130";
	private Connection conn = null;
	private ResultSet rs = null;
	private PreparedStatement pstmt = null;

	public void insert(Likes like) throws AddException {
		try {
			// 1) JDBC 드라이버 로드
			Class.forName("oracle.jdbc.driver.OracleDriver");

			// 2) DB 연결
			conn = DriverManager.getConnection(url, user, pw);
			System.out.println("connection 성공");

			// 3) SQL 구문 송신
			String selectSQL = "INSERT INTO LIKES \r\n" 
					+ "VALUES(?, ?)";
			pstmt = conn.prepareStatement(selectSQL);
			pstmt.setString(1, like.getMem_id());
			pstmt.setInt(2, like.getBoard_no());
			rs = pstmt.executeQuery(); // 실행

			// 4) 결과 확인
			if (rs.next()) {
				return; // insert 성공
			}
			throw new AddException("좋아요 등록에 실패하였습니다.");
		} catch (Exception e) {
			// 사용자 정의 Exception 강제 발생
			throw new AddException(e.getMessage());
		} finally {
			closeConnection();
		}
	}

	public void closeConnection() {
		// 5) 연결 닫기
		try {
			if (rs != null)
				rs.close();
			if (pstmt != null)
				pstmt.close();
			if (conn != null)
				conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}
