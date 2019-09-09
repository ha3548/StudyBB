package com.studybb.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.studybb.exception.AddException;
import com.studybb.exception.NotFoundException;
import com.studybb.vo.Member;

public class MemberDAO {
	public Member selectByIdEmail(String id, String email) throws NotFoundException {
		Connection conn = null;
		ResultSet rs = null;
		PreparedStatement ptmt = null;

		try {
			String DB_URL = "jdbc:oracle:thin:@localhost:1521:xe";
			String DB_USER = "STUDYBB";
			String DB_PW = "wow130";
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PW);
		} catch (Exception e) {
			e.printStackTrace();
		}

		String SQL1 = "SELECT * FROM member WHERE mem_email = ? and mem_id = ?";
		String SQL2 = "SELECT * FROM member WHERE mem_email = ? and mem_id LIKE ?";
		
		try {
			if(id!=null) {
				ptmt = conn.prepareStatement(SQL1);
				ptmt.setString(1, email);
				ptmt.setString(2, id);
			} else if (id==null) {
				ptmt = conn.prepareStatement(SQL2);
				ptmt.setString(1, email);
				ptmt.setString(2, "%");
			}
			rs = ptmt.executeQuery();
			if (rs.next()) {
				Member m = new Member();
				m.setMem_id(rs.getString("mem_id"));
				m.setMem_email(rs.getString("mem_email"));
				m.setMem_pwd(rs.getString("mem_pwd"));
				return m;
			}
			throw new NotFoundException("일치하는 회원정보가 없습니다.");
			
		}catch(Exception e) {
			throw new NotFoundException(e.getMessage());
			
		}finally {
			if(rs != null) 
				try {
					rs.close();
				}catch(SQLException e) {}
			if(ptmt != null) 
				try {
				ptmt.close();
				}catch(SQLException e) {}
			if(conn != null) 
				try {
					conn.close();
				}catch(SQLException e) {}
		}

	};
	
	public Member selectById(String id) throws NotFoundException {
		Connection conn = null;
		ResultSet rs = null;
		PreparedStatement ptmt = null;

		try {
			String DB_URL = "jdbc:oracle:thin:@localhost:1521:xe";
			String DB_USER = "STUDYBB";
			String DB_PW = "wow130";
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PW);
		} catch (Exception e) {
			e.printStackTrace();
		}

		//String SQL = "SELECT * FROM member WHERE mem_id = ?";
		String SQL = "select member.*, mentor.mentor_career\r\n" + 
				"from member LEFT OUTER JOIN mentor ON member.mem_id = mentor.mem_id\r\n" + 
				"where member.mem_id=?";
		
		try {
			ptmt = conn.prepareStatement(SQL);
			ptmt.setString(1, id);
			rs = ptmt.executeQuery();
			if (rs.next()) {
				Member m = new Member();
				m.setMem_id(rs.getString("mem_id"));
				m.setMem_pwd(rs.getString("mem_pwd"));
				m.setMem_email(rs.getString("mem_email"));
				m.setMem_name(rs.getString("mem_name"));
				m.setMem_gender(rs.getString("mem_gender"));
				m.setMem_interest(rs.getString("mem_interest"));
				m.setMem_major(rs.getString("mem_major"));
				m.setMem_area(rs.getString("mem_area"));
				
				if(rs.getString("mentor_career")!=null) {
					m.setMentor_career(rs.getString("mentor_career"));
				}
				return m;
			}
			throw new NotFoundException("존재하지 않는 아이디입니다.");
			
		}catch(Exception e) {
			throw new NotFoundException(e.getMessage());
		}finally {
			if(rs != null) 
				try {
					rs.close();
				}catch(SQLException e) {}
			if(ptmt != null) 
				try {
				ptmt.close();
				}catch(SQLException e) {}
			if(conn != null) 
				try {
					conn.close();
				}catch(SQLException e) {}
		}

	};
	
	public Member insert(Member m) throws AddException{
		Connection conn = null;
		ResultSet rs = null;
		PreparedStatement ptmt = null;

		try {
			String DB_URL = "jdbc:oracle:thin:@localhost:1521:xe";
			String DB_USER = "STUDYBB";
			String DB_PW = "wow130";
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PW);
		} catch (Exception e) {
			e.printStackTrace();
		}

		String SQL = "INSERT INTO member VALUES(?,?,?,?,?,?,?,?)";
		
		try {
			ptmt = conn.prepareStatement(SQL);
			ptmt.setString(1, m.getMem_id());
			ptmt.setString(2, m.getMem_pwd());
			ptmt.setString(3, m.getMem_email());
			ptmt.setString(4, m.getMem_name());
			ptmt.setString(5, m.getMem_gender());
			ptmt.setString(6, m.getMem_interest());
			ptmt.setString(7, m.getMem_major());
			ptmt.setString(8, m.getMem_area());
			ptmt.executeUpdate();
			
			return m;
			
		}catch(Exception e) {
			throw new AddException(e.getMessage());
		}finally {
			if(rs != null) 
				try {
					rs.close();
				}catch(SQLException e) {}
			if(ptmt != null) 
				try {
				ptmt.close();
				}catch(SQLException e) {}
			if(conn != null) 
				try {
					conn.close();
				}catch(SQLException e) {}
		}
	};
	
	public Member update(Member m) throws AddException{
		Connection conn = null;
		ResultSet rs = null;
		PreparedStatement ptmt = null;

		try {
			String DB_URL = "jdbc:oracle:thin:@localhost:1521:xe";
			String DB_USER = "STUDYBB";
			String DB_PW = "wow130";
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PW);
		} catch (Exception e) {
			e.printStackTrace();
		}

		String SQL = "UPDATE member\r\n" + 
				"SET mem_gender=?, mem_interest=?, mem_major=?, mem_area=?\r\n" + 
				"where mem_id=?";
		
		try {
			ptmt = conn.prepareStatement(SQL);
			ptmt.setString(1, m.getMem_gender());
			ptmt.setString(2, m.getMem_interest());
			ptmt.setString(3, m.getMem_major());
			ptmt.setString(4, m.getMem_area());
			ptmt.setString(5, m.getMem_id());
			ptmt.executeUpdate();
						
			return m;
			
		}catch(Exception e) {
			throw new AddException(e.getMessage());
		}finally {
			if(rs != null) 
				try {
					rs.close();
				}catch(SQLException e) {}
			if(ptmt != null) 
				try {
				ptmt.close();
				}catch(SQLException e) {}
			if(conn != null) 
				try {
					conn.close();
				}catch(SQLException e) {}
		}
	};
}
