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
import com.studybb.vo.Member;
import com.studybb.vo.Study;

public class StudyDAO {
	
	private String url = "jdbc:oracle:thin:@localhost:1521:xe";
	private String user = "STUDYBB";
	private String pw = "wow130";
	private Connection conn = null;
	private ResultSet rs = null;
	private PreparedStatement pstmt = null;
	 
	public Study getStudyDetail(int study_no) throws NotFoundException {
		Study study = null;

		Connection conn = null;
		ResultSet rs = null;
		PreparedStatement stmt = null;
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "STUDYBB", "wow130");
			String SQL = "select  s.*, m.mem_name " + 
					"from study s join member m " + 
					"on s.mem_id = m.mem_id " + 
					"where s.study_no = ?";
			stmt = conn.prepareStatement(SQL);
			stmt.setInt(1, study_no);

			rs = stmt.executeQuery();

			if (rs.next()) {
				Member member = new Member();
				member.setMem_id(rs.getString("mem_id"));
				member.setMem_name(rs.getString("mem_name"));
				String study_leader_intro = rs.getString("study_leader_intro");
				String study_title = rs.getString("study_title"); //스터디제목
				String study_area = rs.getString("study_area"); //스터디지역
				Date study_start = rs.getDate("study_start"); //스터디 개강날짜
				int study_week = rs.getInt("study_week"); //몇주과정인가
				Date study_due = rs.getDate("study_due"); //모집공고 마감일
				String study_content = rs.getString("study_content"); //스터디설명글
				String study_tag = rs.getString("study_tag");  //스터디 태그
				Date study_upload = rs.getDate("study_upload"); //모집공고 게시일
				int study_type = rs.getInt("study_type"); //자율-0 / 멘토링-1
				int study_price = rs.getInt("study_price"); //가격
				int study_cap = rs.getInt("study_cap");//최대참가인원
				int study_status = rs.getInt("study_status");// 모집중-0 / 스터디진행중-1 / 종료-2
				
				study = new Study(study_no, member, study_leader_intro, 
						study_title, study_area, study_start, study_week, study_due, 
						study_content, study_tag, study_upload, study_type, study_price, study_cap, study_status);
			} else {
				throw new NotFoundException("해당 스터디가 없습니다.");
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
		return study;
	}

	public int deleteStudy(int study_no) throws NotFoundException {
		Connection conn = null;
		PreparedStatement stmt = null;
		int result;
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "STUDYBB", "wow130");

			String SQL = "delete from study where study_no = ?";
			stmt = conn.prepareStatement(SQL);
			stmt.setInt(1, study_no);

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

	public int editStatus(int study_no) throws NotFoundException {
		Connection conn = null;
		PreparedStatement stmt = null;
		int result = -1;
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "STUDYBB", "wow130");

			String SQL = "update study set study_status = 1 where study_no = ?";
			stmt = conn.prepareStatement(SQL);
			stmt.setInt(1, study_no);

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

	public int getStatus(int study_no) throws NotFoundException {
		int status = -1;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "STUDYBB", "wow130");

			String SQL = "select nvl(to_number(study_status),0) from study where study_no = ?";
			stmt = conn.prepareStatement(SQL);
			stmt.setInt(1, study_no);
			
			rs = stmt.executeQuery();
			
			if(rs.next()) {
				status = rs.getInt(1);
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
		return status;
	}
	public List<Study> selectBySearch(String study_area, int study_type,String study_tag) throws NotFoundException {

		List<Study> list = new ArrayList<Study>();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");

			String url = "jdbc:oracle:thin:@localhost:1521:xe";
			String user = "STUDYBB";
			String password = "wow130";
			con = DriverManager.getConnection(url, user, password);
			String selectSQL = /*
								 * "SELECT S.STUDY_TITLE,S.STUDY_PRICE,S.STUDY_WEEK,M.MEM_NAME,S.STUDY_UPLOAD\r\n"
								 * + "from STUDY S JOIN MEMBER M ON S.MEM_ID = M.MEM_ID\r\n" +
								 * "WHERE (REGEXP_LIKE(STUDY_TAG, '취업|컴공')) AND (STUDY_AREA = '인천') AND (STUDY_TYPE = 0)\r\n"
								 * + "ORDER BY STUDY_UPLOAD DESC";
								 */
					"SELECT STUDY_NO, STUDY_TITLE,STUDY_PRICE,STUDY_WEEK,MEM_ID,STUDY_START\r\n" + //
					"from STUDY \r\n" + 
					"WHERE (REGEXP_LIKE(STUDY_TAG, ?)) ";
			//if(전체가 아닐때) {
			if(!"전체".equals(study_area)) {	 
				selectSQL += "AND (STUDY_AREA = '" + study_area + "')\r\n";
			} 
			
			if(study_type != 2) {
				
				selectSQL += "AND (STUDY_TYPE = " + study_type + ")\r\n";
			} 
//			if(좋아요 일때)
//				selectSQL += "ORDER BY STUDY_LIKES DESC";
//			else
				selectSQL += "ORDER BY STUDY_UPLOAD DESC";
			pstmt = con.prepareStatement(selectSQL);
			pstmt.setString(1,study_tag);
			//pstmt.setString(2, study_area);
			//pstmt.setInt(3, study_type);
			rs = pstmt.executeQuery();	
			while (rs.next()) {
				//Member m = new Member();
				int setStudy_no = rs.getInt(1);
				String setStudy_title=rs.getString("STUDY_TITLE");
				System.out.println("in searchDAO study_title:" + setStudy_title);
				int setStudy_price = rs.getInt("STUDY_PRICE");
				int setStudy_week = rs.getInt("STUDY_WEEK");
				//m.setMem_name(rs.getString("mem_name");
				String setmem_id = rs.getString("MEM_ID");
				Date setStudy_start = rs.getDate("STUDY_START");
				Study study = new Study(setStudy_no, setStudy_title,setStudy_price,setStudy_week,setmem_id,setStudy_start);
				// 대입
				list.add(study);
				
			}
			if(list.size() == 0) {
				throw new NotFoundException("검색결과가 없습니다.");
			}
		} catch (Exception e) {
			throw new NotFoundException(e.getMessage());
		} finally {
			closeConnection();
		}
		return list;
		
	}
	
	 public List<Study> selectBySearch(String area, int type, String tag, int startRow, int endRow) 
	         throws NotFoundException {

	      List<Study> list = new ArrayList<Study>();
	      try {
	         // 1) JDBC 드라이버 로드
	         Class.forName("oracle.jdbc.driver.OracleDriver");

	         // 2) DB 연결
	         conn = DriverManager.getConnection(url, user, pw);
	         System.out.println("connection 성공");

	         // 3) SQL 구문 송신
	         String selectSQL = "SELECT A.*, rno\r\n" + 
	               "FROM (SELECT B.* , rownum AS rno\r\n" + 
	               "      FROM (SELECT s.*, m.mem_name\r\n" + 
	               "            FROM study s, member m\r\n" + 
	               "            WHERE s.mem_id = m.mem_id\r\n";
	         
	         // if(전체가 아닐때)
	         if(!"".equals(tag)) {
	            selectSQL += "AND REGEXP_LIKE(study_tag, '" + tag + "') \r\n";
	         }
	         if(!"전체".equals(area)) {    
	            selectSQL += "AND study_area = '" + area + "' \r\n";
	         } 
	         if(type != 2) {
	            selectSQL += "AND study_type = '" + type + "' \r\n";
	         } 

	         selectSQL += "ORDER BY STUDY_UPLOAD DESC) B) A\r\n" + 
	               "WHERE rno BETWEEN ? AND ?";
	         pstmt = conn.prepareStatement(selectSQL);
	         pstmt.setInt(1, startRow);
	         pstmt.setInt(2, endRow);
	         rs = pstmt.executeQuery();
	         
	         while (rs.next()) {
	            //Member m = new Member();
	            int study_no = rs.getInt("study_no");
	            String study_title=rs.getString("study_title");
	            int study_price = rs.getInt("study_price");
	            int study_week = rs.getInt("study_week");
	            Date study_due = rs.getDate("study_due");
	            String mem_id = rs.getString("mem_id");
	            String mem_name = rs.getString("mem_name");
	            Date study_start = rs.getDate("study_start");
	            Date study_upload = rs.getDate("study_upload");
	            String study_area = rs.getString("study_area");
	            String study_tag = rs.getString("study_tag");
	            int study_type = rs.getInt("study_type");
	            int study_status = rs.getInt("study_status");
	            Member mem = new Member();
	            mem.setMem_id(mem_id);
	            mem.setMem_name(mem_name);
	            
	            Study study = new Study(study_no, mem, "", study_title, study_area, study_start, study_week,
	                     study_due, "", study_tag, study_upload, study_type, study_price, 1, study_status);
	            // 대입
	            list.add(study);
	         }
	         if(list.size() == 0) {
	            throw new NotFoundException("검색결과가 없습니다.");
	         }
	      } catch (Exception e) {
	         throw new NotFoundException(e.getMessage());
	      } finally {
	         closeConnection();
	      }
	      return list;
	      
	   }

	
	public void closeConnection() {
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
	
	
	
	public int selectById(String id) throws NotFoundException {
		Connection conn = null;
		ResultSet rs = null;
		PreparedStatement stmt = null;
		int result = -1;
		try {
			String DB_URL = "jdbc:oracle:thin:@localhost:1521:xe";
			String DB_USER = "STUDYBB";
			String DB_PW = "wow130";
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PW);

			String SQL = "SELECT * FROM mentor WHERE mem_id=?";
			stmt = conn.prepareStatement(SQL);
			stmt.setString(1, id);
			rs = stmt.executeQuery();
			if (rs.next()) {
				result = 1;
			} 
			return result;
		}catch(Exception e) {
			throw new NotFoundException(e.getMessage());
		} 
		finally {
			if(rs != null)
				try {
					rs.close();
				} catch(SQLException e) {}
			if(stmt != null)
				try {
					stmt.close();
				} catch(SQLException e) {}
			if(conn != null)
				try {
					conn.close();
				} catch(SQLException e) {}
		}
	}
	/**
	 * study행 추가후 추가한  study_no값반환한다
	 * @param study
	 * @return
	 * @throws AddException
	 */
	public int insertStudyAndSelectStudy_seq(Study study) throws AddException{
		Connection conn = null;
		try {
			String DB_URL = "jdbc:oracle:thin:@localhost:1521:xe";
			String DB_USER = "STUDYBB";
			String DB_PW = "wow130";
			Class.forName("oracle.jdbc.driver.OracleDriver");
			
			conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PW);
			insertStudy(conn, study);
//			System.out.println(selectStudy_seqByCurrent(conn));
			return selectStudy_seqByCurrent(conn);
		}catch(Exception e) {
			throw new AddException(e.getMessage());
		}finally {
			if(conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
	}
	
	/**
	 * study_seq의 현재값을 검색한다
	 * @return
	 */
	private int selectStudy_seqByCurrent(Connection conn) throws NotFoundException{;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			String SQL = "SELECT study_seq.CURRVAL FROM dual";
			stmt = conn.prepareStatement(SQL);
			rs = stmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1);
			} else {
				return -1;
			}
		}catch(Exception e) {
			throw new NotFoundException(e.getMessage());
		}finally {
			try {
				if (stmt != null && !stmt.isClosed())
					stmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			
			try {
				if (rs != null && !rs.isClosed())
					rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}	
	}
	
	private void insertStudy(Connection conn, Study study) throws AddException{
		PreparedStatement stmt = null;
		try {
			String SQL = "insert into study(study_no, mem_id, study_leader_intro, study_title, study_area, study_start, study_week, study_price, study_due, study_content, study_tag, study_cap, study_type, study_status, study_upload) values "
					+ "(study_seq.NEXTVAL, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, sysdate)";
			stmt = conn.prepareStatement(SQL);
			stmt.setString(1, study.getMember().getMem_id()); //현재 로그인되어있는 id
			stmt.setString(2, study.getStudy_leader_intro());
			stmt.setString(3,study.getStudy_title());
			stmt.setString(4, study.getStudy_area());
			stmt.setDate(5, new java.sql.Date(study.getStudy_start().getTime()));
			stmt.setInt(6, study.getStudy_week());
			stmt.setInt(7, study.getStudy_price());
			stmt.setDate(8, new java.sql.Date(study.getStudy_due().getTime()));
			stmt.setString(9, study.getStudy_content());
			stmt.setString(10, study.getStudy_tag());
			stmt.setInt(11, study.getStudy_cap());
			if(study.getStudy_price()==0) {
				stmt.setInt(12, 0); //study_type: 0(자율스터디)
			} else {
				stmt.setInt(12, 1); //study_type: 1(멘토스터디)
			}
			stmt.setInt(13, 0); //study_status: 0(미승인 상태)
			stmt.executeUpdate();
		}catch(Exception e) {
			throw new AddException(e.getMessage());
		} 
		finally {
			try {
				if (stmt != null && !stmt.isClosed())
					stmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			
		}
	}	
	
	public void updateStudy(Study study) throws AddException {
		Connection conn = null;
		ResultSet rs = null;
		PreparedStatement stmt = null;
		try {
			String DB_URL = "jdbc:oracle:thin:@localhost:1521:xe";
			String DB_USER = "STUDYBB";
			String DB_PW = "wow130";
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PW);
			
			String SQL = "UPDATE study SET study_leader_intro=?, study_title=?, study_area=?, study_start=?, study_week=?, study_due=?, study_content=?, study_tag=?, study_type=?, study_price=?, study_cap=?, study_status=? WHERE study_no=?";
			stmt = conn.prepareStatement(SQL);
			stmt.setString(1, study.getStudy_leader_intro());
			stmt.setString(2,study.getStudy_title());
			stmt.setString(3, study.getStudy_area());
			stmt.setDate(4, new java.sql.Date(study.getStudy_start().getTime()));
			stmt.setInt(5, study.getStudy_week());
			stmt.setDate(6, new java.sql.Date(study.getStudy_due().getTime()));
			stmt.setString(7, study.getStudy_content());
			stmt.setString(8, study.getStudy_tag());
			stmt.setInt(9, study.getStudy_type());
			stmt.setInt(10, study.getStudy_price());
			stmt.setInt(11, study.getStudy_cap());
			stmt.setInt(12, 0);
			stmt.setInt(13, study.getStudy_no());
			stmt.executeUpdate();
		}catch(Exception e) {
			throw new AddException(e.getMessage());
		} 
		finally {
			if(rs != null)
				try {
					rs.close();
				} catch(SQLException e) {}
			if(stmt != null)
				try {
					stmt.close();
				} catch(SQLException e) {}
			if(conn != null)
				try {
					conn.close();
				} catch(SQLException e) {}
		}
	}

	public int count(String study_area, int study_type, String study_tag) throws NotFoundException {
		try {
			// 1) JDBC 드라이버 로드
			Class.forName("oracle.jdbc.driver.OracleDriver");

			// 2) DB 연결
			conn = DriverManager.getConnection(url, user, pw);
			System.out.println("connection 성공");

			// 3) SQL 구문 송신
			String selectSQL = "SELECT count(*) \r\n" + 
					"           FROM study s, member m\r\n" + 
					"           WHERE s.mem_id = m.mem_id\r\n";
			
			// if(전체가 아닐때)
			if(!"".equals(study_tag)) {
				selectSQL += "AND REGEXP_LIKE(study_tag, '" + study_tag + "') \r\n";
			}
			if(!"전체".equals(study_area)) {	 
				selectSQL += "AND study_area = '" + study_area + "' \r\n";
			} 
			if(study_type != 2) {
				selectSQL += "AND study_type = '" + study_type + "' \r\n";
			}
			pstmt = conn.prepareStatement(selectSQL);

			// 4) SQL구문 실행
			rs = pstmt.executeQuery();

			// 5) 결과 확인
			// count는 테이블이 없을 경우 바로 exception을 날리기 때문에 rs.next()를 체크해줄 필요가 없다
			// 행이 없을 경우에는 0 반환
			rs.next();
			return rs.getInt(1);
		} catch (Exception e) {
			// 사용자 정의 Exception 강제 발생
			throw new NotFoundException(e.getMessage());
		} finally {
			closeConnection();
		}
	}


}
