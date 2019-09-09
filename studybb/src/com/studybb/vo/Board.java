package com.studybb.vo;

import java.util.Date;

public class Board {
	private int board_no;			// 글번호
	private Member mem = new Member();	// 작성자
	private Date board_date;		// 작성 날짜
	private String board_content;	// 내용
	private String board_tag;		// 글 태그
	private int parent_no = 0;		// 부모글 번호
	private int board_likes;		// 좋아요 수
	private int board_comments;		// 댓글 수 
	private int board_row;			// row number
	
	public Board() {}

	// all parameter
	public Board(int board_no, Member mem, Date board_date, String board_content, String board_tag, int parent_no,
			int board_likes, int board_comments, int board_row) {
		super();
		this.board_no = board_no;
		this.mem = mem;
		this.board_date = board_date;
		this.board_content = board_content;
		this.board_tag = board_tag;
		this.parent_no = parent_no;
		this.board_likes = board_likes;
		this.board_comments = board_comments;
		this.board_row = board_row;
	}
	
	// root board 생성자
	public Board(String mem_id, String board_content, String board_tag) {
		this.mem.setMem_id(mem_id);
		this.board_content = board_content;
		this.board_tag = board_tag;
	}
	
	// reply board 생성자
	public Board(String mem_id, String board_content, int parent_no) {
		this.mem.setMem_id(mem_id);
		this.board_content = board_content;
		this.parent_no = parent_no;
	}

	public int getBoard_no() {
		return board_no;
	}

	public void setBoard_no(int board_no) {
		this.board_no = board_no;
	}

	public Member getMem() {
		return mem;
	}

	public void setMem(Member mem) {
		this.mem = mem;
	}

	public Date getBoard_date() {
		return board_date;
	}

	public void setBoard_date(Date board_date) {
		this.board_date = board_date;
	}

	public String getBoard_content() {
		return board_content;
	}

	public void setBoard_content(String board_content) {
		this.board_content = board_content;
	}

	public int getBoard_likes() {
		return board_likes;
	}

	public void setBoard_likes(int board_likes) {
		this.board_likes = board_likes;
	}

	public String getBoard_tag() {
		return board_tag;
	}

	public void setBoard_tag(String board_tag) {
		this.board_tag = board_tag;
	}

	public int getParent_no() {
		return parent_no;
	}

	public void setParent_no(int parent_no) {
		this.parent_no = parent_no;
	}

	public int getBoard_comments() {
		return board_comments;
	}

	public void setBoard_comments(int board_comments) {
		this.board_comments = board_comments;
	}

	public int getBoard_row() {
		return board_row;
	}

	public void setBoard_row(int board_row) {
		this.board_row = board_row;
	}
}
