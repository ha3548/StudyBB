package com.studybb.vo;

public class Likes {
	private String mem_id;	// 좋아요한 사용자 id
	private int board_no;	// 좋아요한 게시글 넘버
	
	public Likes() {}

	public Likes(String mem_id, int board_no) {
		super();
		this.mem_id = mem_id;
		this.board_no = board_no;
	}

	public String getMem_id() {
		return mem_id;
	}

	public void setMem_id(String mem_id) {
		this.mem_id = mem_id;
	}

	public int getBoard_no() {
		return board_no;
	}

	public void setBoard_no(int board_no) {
		this.board_no = board_no;
	}
}
