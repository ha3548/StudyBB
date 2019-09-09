package com.studybb.service;

import org.json.simple.JSONObject;

import com.studybb.dao.LikeDAO;
import com.studybb.exception.AddException;
import com.studybb.vo.Likes;

public class LikeService {
	private LikeDAO dao;
	
	public LikeService(){
		dao = new LikeDAO();
	}

	public String boardlike(String mem_id, int board_no) {
		int status = -1;
		String msg = "like failed";
		
		// Like 생성자
		Likes like = new Likes(mem_id, board_no);
		try {
			dao.insert(like);
			status = 1;
		} catch (AddException e) {
			msg += "이미 좋아요한 게시글입니다.";
		}
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("status", status);
		jsonObj.put("msg", msg);
		
		String str = jsonObj.toString();
		return str;
	}
}
