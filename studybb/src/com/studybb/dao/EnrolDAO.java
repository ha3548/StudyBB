package com.studybb.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.studybb.exception.AddException;
import com.studybb.exception.NotFoundException;
import com.studybb.vo.Enrol;
import com.studybb.vo.Member;
import com.studybb.vo.Review;
import com.studybb.vo.Study;

public class EnrolDAO {

	public List<Enrol> selectMyEnrolList(String mem_id) throws NotFoundException {
	      List<Enrol> list = new ArrayList<Enrol>();

	         Connection conn = null;
	         ResultSet rs = null;
	         PreparedStatement stmt = null;
	         try {
	            Class.forName("oracle.jdbc.driver.OracleDriver");
	            conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "studybb", "wow130");

	            String SQL = "select study.study_title title, study.mem_id id, enrol.enrol_status status\r\n" + 
	                  "      from study join enrol on study.study_no=enrol.study_no\r\n" + 
	                  "      where enrol.mem_id=?";
	            stmt = conn.prepareStatement(SQL);
	            stmt.setString(1, mem_id);
	            rs = stmt.executeQuery();
	            while (rs.next()) {
	               Enrol enrol = new Enrol();
	               Study study = new Study();
	               Member member = new Member();
	               study.setStudy_title(rs.getString("title"));
	               member.setMem_id(rs.getString("id"));
	               study.setMember(member);
	               enrol.setStudy(study);
	               enrol.setEnrol_status(rs.getInt("status"));
	               list.add(enrol);
	            }
	            if (list.size() == 0) {
	               throw new NotFoundException("가입신청내역이 없습니다!");
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
	
	public List<Enrol> getEnrolList(int study_no) throws NotFoundException {
		List<Enrol> list = new ArrayList<Enrol>();

		Connection conn = null;
		ResultSet rs = null;
		PreparedStatement stmt = null;
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "studybb", "wow130");

			String SQL = "select * from enrol " + "where study_no = ? " + "order by enrol_status";
			stmt = conn.prepareStatement(SQL);
			stmt.setInt(1, study_no);

			rs = stmt.executeQuery();

			while (rs.next()) {
				Enrol enrol = new Enrol();
				/*
				 * private Study study; //study_no 가지고있음 private Member member; //mem_id 가지고있음
				 * private String enrol_say; private String enrol_status; //0-대기중|1-승인|2-거절
				 * private Date enrol_date;
				 */
				Study study = new Study();
				study.setStudy_no(study_no);
				enrol.setStudy(study);
				Member member = new Member();// 가입신청자
				member.setMem_id(rs.getString("mem_id"));
				enrol.setMember(member);
				enrol.setEnrol_say(rs.getString("enrol_say"));
				enrol.setEnrol_status(rs.getInt("enrol_status"));

				list.add(enrol);
			}
			if (list.size() == 0) {
				throw new NotFoundException("가입신청내역이 없습니다!");
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

	public int editErol(int study_no, String mem_id, int approval) throws NotFoundException {

		Connection conn = null;
		int result = 0;
		PreparedStatement stmt = null;
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "studybb", "wow130");

			String SQL = "update enrol " + "set enrol_status = ? " + "where study_no = ? and mem_id = ?";
			stmt = conn.prepareStatement(SQL);
			stmt.setInt(1, approval);
			stmt.setInt(2, study_no);
			stmt.setString(3, mem_id);

			result = stmt.executeUpdate();

		} catch (ClassNotFoundException | SQLException e) {
			throw new NotFoundException(e.getMessage());
		} finally {
			try {
				stmt.close();
				conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return result;
	}

	// 정원 초과 여부 조회
	public boolean isMax(int study_no) throws NotFoundException {
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		int study_cap = -1;
		int people = -2;
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "studybb", "wow130");

			String SQL = "select e.study_no, study_cap, people "
					+ "from study join (select count(*) as people, study_no from enrol where enrol_status=1 group by study_no) e "
					+ "on study.study_no = e.study_no " + "where study.study_no = ?";
			stmt = conn.prepareStatement(SQL);
			stmt.setInt(1, study_no);

			rs = stmt.executeQuery();

			if (rs.next()) {
				study_cap = rs.getInt("study_cap");
				people = rs.getInt("people");
			}
		} catch (ClassNotFoundException | SQLException e) {
			throw new NotFoundException(e.getMessage());
		} finally {
			try {
				stmt.close();
				conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		if (study_cap == people)
			return true;
		return false;
	}

	public Enrol insert(Enrol enrol) throws AddException {
		Connection conn = null;
		ResultSet rs = null;
		PreparedStatement ptmt = null;

		try {
			String DB_URL = "jdbc:oracle:thin:@localhost:1521:xe";
			String DB_USER = "STUDYBB";
			String DB_PW = "wow130";
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PW);

			String SQL = "INSERT INTO ENROL VALUES(?, ?, ?, ?, TO_DATE(SYSDATE, 'yyyy-MM-dd hh24:mi:ss'))";
			ptmt = conn.prepareStatement(SQL);
			ptmt.setInt(1, enrol.getStudy().getStudy_no());
			ptmt.setString(2, enrol.getMember().getMem_id());
			ptmt.setString(3, enrol.getEnrol_say());
			ptmt.setInt(4, 0);
			ptmt.executeUpdate();

			return enrol;
		} catch (ClassNotFoundException | SQLException e) {
			throw new AddException(e.getMessage());
		} finally {
			try {
				if (ptmt != null && !ptmt.isClosed()) {
					ptmt.close();
					conn.close();
				}
				if (rs != null && !rs.isClosed()) {
					ptmt.close();
					conn.close();
				}

			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

	};

}
