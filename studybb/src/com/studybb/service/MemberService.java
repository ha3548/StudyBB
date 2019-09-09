package com.studybb.service;

import org.json.simple.JSONObject;

import com.studybb.dao.MemberDAO;
import com.studybb.exception.AddException;
import com.studybb.exception.NotFoundException;
import com.studybb.vo.Member;

public class MemberService {
	private MemberDAO dao;
	public MemberService() {
		dao = new MemberDAO();
	}
	
	public String login(String id, String pwd) {
		int status = -1;
		try {
			Member m = dao.selectById(id);
			if (m.getMem_pwd().equals(pwd)) {
				status = 1; // 로그인성공
			}
		} catch(NotFoundException e) {
			e.printStackTrace();
		}
		
		//String str = "{\"status\":" + status + ", \"id\": \"" + id + "\"}";
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("status", status);
		jsonObj.put("id", id);
		String str = jsonObj.toString();
		return str;
	}
	
	public String join(Member m) {
		try {
			dao.insert(m);
			
			JSONObject jsonObj = new JSONObject();
			jsonObj.put("status", 1);
			String str = jsonObj.toString();
			return str; // 가입성공
			
		} catch(AddException e) {
			e.printStackTrace();
			
			JSONObject jsonObj = new JSONObject();
			jsonObj.put("status", -1);
			String str = jsonObj.toString();
			return str; // 가입실패
		}
	}
	
	public String dupchk(String id) {
		int status = -1; // 아이디중복안됨
		try {
			Member c = dao.selectById(id);
			if (c.getMem_id().equals(id)) {
				status = 1; // 아이디중복
			}
		} catch (NotFoundException e) {
			e.printStackTrace();
		}

		JSONObject jsonObj = new JSONObject();
		jsonObj.put("status", status);
		jsonObj.put("id", id);
		String str = jsonObj.toString();
		return str;
	}
	
	public String searchid(String email) {
		String id = null;
		try {
			Member m = dao.selectByIdEmail(id, email);
			if (m.getMem_email().equals(email)) {
				id = m.getMem_id();
			}
		} catch (NotFoundException e) {
			e.printStackTrace();
		}
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("id", id);
		String str = jsonObj.toString();
		return str;
	}

	public String searchpwd(String id, String email) {
		String pwd = null;
		try {
			Member m = dao.selectByIdEmail(id, email);
			pwd = m.getMem_pwd();
		} catch (NotFoundException e) {
			e.printStackTrace();
		}
		return pwd; //회원정보 없으면 null반환
	}
	
	public Member profile(String id) {
		Member member = new Member();
		try {
			member = dao.selectById(id);
		} catch (NotFoundException e) {
			e.printStackTrace();
		}
		return member;
	}
	
	public Member edit(Member m) {
		Member member = new Member();
		try {
			dao.update(m);
			
		} catch (AddException e) {
			e.printStackTrace();
		}
		return member;
	}
}
