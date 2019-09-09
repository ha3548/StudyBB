package com.studybb.dao;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import com.studybb.exception.AddException;
import com.studybb.exception.NotFoundException;
import com.studybb.vo.Board;
import com.studybb.vo.Member;

public class BoardDAO {
	private String url = "jdbc:oracle:thin:@localhost:1521:xe";
	private String user = "STUDYBB";
	private String pw = "wow130";
	private Connection conn = null;
	private ResultSet rs = null;
	private PreparedStatement pstmt = null;
	
	private String resource = "mybatis-config.xml";
	private InputStream inputStream = null;
	private SqlSession session = null;

	public int count() throws NotFoundException {
		try {
			inputStream = Resources.getResourceAsStream(resource);
			SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder().build(inputStream);
			session = sqlSessionFactory.openSession();
			
			// count 결과 가져오기
			int cnt = session.selectOne("com.my.vo.Board.countBoard");
			return cnt;
			
		} catch (Exception e) {
			// 사용자 정의 Exception 강제 발생
			throw new NotFoundException(e.getMessage());
		} finally {
			closeConnection();
		}
	}
	
	public int count(String input) throws NotFoundException {
		try {
			inputStream = Resources.getResourceAsStream(resource);
			SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder().build(inputStream);
			session = sqlSessionFactory.openSession();
			
			// count 결과 가져오기
			int cnt = session.selectOne("com.my.vo.Board.countBoard", input);
			return cnt;
			
		} catch (Exception e) {
			// 사용자 정의 Exception 강제 발생
			throw new NotFoundException(e.getMessage());
		} finally {
			closeConnection();
		}
	}
	
	public int count(int parent_no) throws NotFoundException {
		try {
			// 1) JDBC 드라이버 로드
			Class.forName("oracle.jdbc.driver.OracleDriver");

			// 2) DB 연결
			conn = DriverManager.getConnection(url, user, pw);
			System.out.println("connection 성공");

			// 3) SQL 구문 송신
			String selectSQL = "SELECT COUNT(*) FROM BOARD "
					+ "WHERE parent_no = ?";
			pstmt = conn.prepareStatement(selectSQL);
			pstmt.setInt(1, parent_no);

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

	public List<Board> selectList(int startRow, int endRow, String type, String input) 
			throws NotFoundException {
		List<Board> list = new ArrayList<Board>();
		try {
			// 1) JDBC 드라이버 로드
			Class.forName("oracle.jdbc.driver.OracleDriver");

			// 2) DB 연결
			conn = DriverManager.getConnection(url, user, pw);
			System.out.println("connection 성공");

			// 3) SQL 구문 송신
			String selectSQL = "SELECT A.*, rno\r\n"
					+ "FROM (SELECT B.* , rownum AS rno\r\n" 
					+ "      FROM (SELECT * \r\n"
					+ "            FROM BOARDLIST\r\n";
			
			// input이 있을 경우 검색 결과 필터링
			if(!input.equals("")) {
				selectSQL += "WHERE board_content LIKE '%"+input+"%' \r\n"
						+ "OR board_tag LIKE '%"+input+"%' \r\n";
			}
			// type에 따라 정렬 기준 변경
			if(type.equals("likes")) {
				selectSQL += "ORDER BY board_likes DESC) B) A\r\n"
						+ "WHERE rno BETWEEN ? AND ?";
			} else {
				selectSQL += "ORDER BY board_date DESC) B) A\r\n"
						+ "WHERE rno BETWEEN ? AND ?";
			}

			pstmt = conn.prepareStatement(selectSQL);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);
			rs = pstmt.executeQuery(); // 실행

			// 4) SQL구문 처리 & 결과 수신
			System.out.println(startRow + ", " + endRow);

			// 5) 결과 확인
			while (rs.next()) {
				int board_no = rs.getInt("board_no");
				Member mem = new Member();
				mem.setMem_id(rs.getString("mem_id"));
				mem.setMem_name(rs.getString("mem_name"));
				Date board_date = rs.getDate("board_date");
				String board_content = rs.getString("board_content");
				String board_tag = rs.getString("board_tag");
				int board_likes = rs.getInt("board_likes");
				int board_comments = rs.getInt("board_comments");
				int board_row = rs.getInt("rno");

				// 대입
				Board board = new Board(board_no, mem, board_date, board_content, board_tag, 0, board_likes,
						board_comments, board_row);
				list.add(board);
				System.out.println(board_no);
			}
			if (list.size() == 0) {
				throw new NotFoundException("게시목록이 없습니다.");
			}
		} catch (Exception e) {
			// 사용자 정의 Exception 강제 발생
			throw new NotFoundException(e.getMessage());
		} finally {
			closeConnection();
		}
		return list;

	}

	public List<Board> selectComment(int parent, int startRow, int endRow) throws NotFoundException {
		List<Board> list = new ArrayList<Board>();
		
		try {
			// 1) JDBC 드라이버 로드
			Class.forName("oracle.jdbc.driver.OracleDriver");

			// 2) DB 연결
			conn = DriverManager.getConnection(url, user, pw);
			System.out.println("connection 성공");

			// 3) SQL 구문 송신
			String selectSQL = "SELECT A.*, rno\r\n" + 
					"FROM (SELECT B.*, rownum AS rno\r\n" + 
					"      FROM (SELECT C.*, M.mem_name\r\n" + 
					"            FROM BOARD C, MEMBER M\r\n" + 
					"            WHERE C.mem_id = M.mem_id\r\n" + 
					"            AND C.parent_no = ? \r\n" + 
					"            ORDER BY C.board_date) B) A\r\n" + 
					"WHERE rno BETWEEN ? AND ?";

			pstmt = conn.prepareStatement(selectSQL);
			pstmt.setInt(1, parent);
			pstmt.setInt(2, startRow);
			pstmt.setInt(3, endRow);
			System.out.println(parent + " " +startRow+ " "+endRow);
			rs = pstmt.executeQuery(); // 실행

			// 4) SQL구문 처리 & 결과 수신
			System.out.println(rs);

			// 5) 결과 확인
			while (rs.next()) {
				int board_no = rs.getInt("board_no");
				Member mem = new Member();
				mem.setMem_id(rs.getString("mem_id"));
				mem.setMem_name(rs.getString("mem_name"));
				Date board_date = rs.getDate("board_date");
				String board_content = rs.getString("board_content");

				// 대입
				Board comment = new Board(board_no, mem, board_date, board_content, null, parent, 0, 0, 0);
				list.add(comment);
			}
			if (list.size() == 0) {
				throw new NotFoundException("댓글이 없습니다.");
			}
		} catch (Exception e) {
			// 사용자 정의 Exception 강제 발생
			throw new NotFoundException(e.getMessage());
		} finally {
			closeConnection();
		}
		return list;

	}

	public void insert(Board board) throws AddException {
		try {
			// 1) JDBC 드라이버 로드
			Class.forName("oracle.jdbc.driver.OracleDriver");

			// 2) DB 연결
			conn = DriverManager.getConnection(url, user, pw);
			System.out.println("connection 성공");

			// 3) SQL 구문 송신
			String selectSQL = "INSERT INTO BOARD \r\n" 
					+ "VALUES (board_seq.NEXTVAL, ?, SYSDATE, ?, 0, ?, ?)";
			pstmt = conn.prepareStatement(selectSQL);

			Member mem = board.getMem();
			// System.out.println(mem.getMem_id() + " " + board.getBoard_content() + " " +
			// board.getParent_no());
			pstmt.setString(1, mem.getMem_id());
			pstmt.setString(2, board.getBoard_content());

			if (board.getParent_no() == 0) {
				// 원글 쓰기: 태그 있음, parent_no 없음
				pstmt.setString(3, board.getBoard_tag());
				pstmt.setObject(4, null);
			} else {
				// 답글 쓰기: 태그 없음, parent_no 있음
				pstmt.setObject(3, null);
				pstmt.setInt(4, board.getParent_no());
			}

			rs = pstmt.executeQuery(); // 실행

			// 4) 결과 확인
			if (rs.next()) {
				return; // insert 성공
			}
			throw new AddException("게시물 등록에 실패하였습니다.");
		} catch (Exception e) {
			// 사용자 정의 Exception 강제 발생
			throw new AddException(e.getMessage());
		} finally {
			closeConnection();
		}
	}

	public void delete(int board_no) throws NotFoundException {
		try {
			// 1) JDBC 드라이버 로드
			Class.forName("oracle.jdbc.driver.OracleDriver");

			// 2) DB 연결
			conn = DriverManager.getConnection(url, user, pw);
			System.out.println("connection 성공");

			// 3) SQL 구문 송신
			String selectSQL = "DELETE FROM BOARD " 
					+ "WHERE board_no = ?";

			// 4) SQL구문 처리 & 결과 수신
			pstmt = conn.prepareStatement(selectSQL);
			pstmt.setInt(1, board_no);
			int rowcnt = pstmt.executeUpdate();

			// 5) 결과 확인
			if (rowcnt != 0) {
				return;		// 삭제 성공
			}
			throw new NotFoundException("삭제할 행이 없습니다");
		} catch (Exception e) {
			// 사용자 정의 Exception 강제 발생
			throw new NotFoundException(e.getMessage());
		} finally {
			closeConnection();
		}
	}

	public void closeConnection() {
		// 연결 닫기
		try {
			if(session != null)
				session.close();
			
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
