package com.kh.mw.dao;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.mw.vo.UserVo;

@Repository
public class UserDao {
	private final String NAMESPACE = "mappers.user.";
	
	@Autowired
	private SqlSession sqlSession;
	//회원등록 런
	public boolean registerRun(UserVo userVo) {
		int count = sqlSession.insert(NAMESPACE + "insertUser", userVo);
		if(count>0) {
			return true;
		}
		return false;
	}
	//로그인 런
	public UserVo login_run(String userid, String userpw) {
		Map<String, String> map = new HashMap<>();
		map.put("userid", userid);
		map.put("userpw", userpw);
		UserVo vo = sqlSession.selectOne(NAMESPACE + "login", map);
		return vo;
	}
	//id존재 여부확인
	public boolean isExistId(String inputId) {
		int count = sqlSession.selectOne(NAMESPACE + "isExistId" , inputId);
		if(count>0) {
			return true;
		}
		return false;
	}
	//url존재 여부 확인
	public boolean isExistUrl(String url) {
		int count = sqlSession.selectOne(NAMESPACE + "isExistUrl" , url);
		if(count>0) {
			return true;
		}
		return false;
	}
	//회원정보 상세보기
	public UserVo detail(String userid, String userpw) {
		Map<String, String> map = new HashMap<>();
		map.put("userid", userid);
		map.put("userpw", userpw);
		UserVo userVo = sqlSession.selectOne(NAMESPACE + "detail", map);
		return userVo;
	}
	//회원정보 수정
	public boolean modify(UserVo userVo) {
		Map<String, String> map = new HashMap<>();
		map.put("userid", userVo.getUserid());
		map.put("userpw", userVo.getUserpw());
		map.put("username", userVo.getUsername());
		map.put("email", userVo.getEmail());
		map.put("phonenum", userVo.getPhonenum());
		map.put("url", userVo.getUrl());
		int count = sqlSession.update(NAMESPACE + "modify", map);
		if(count>0) {
			return true;
		}
		return false;
	}

	//pjnum status 체크
	public int checkpjnum(String userid) {
		UserVo userVo = sqlSession.selectOne(NAMESPACE + "checkpjnum", userid);
		return userVo.getPjnum();
	}
	//업데이트 pjnum
	public int updatepjnum(int prevPjnum, String userid) {
		int pjnum = 0;
		Map<String,Object> map = new HashMap<>();
		if(prevPjnum == 0) {
			pjnum = prevPjnum + 1;
			map.put("pjnum", pjnum);
			map.put("userid", userid);
			System.out.println("pjnum: " + pjnum);
		}else if(prevPjnum == 1) {
			pjnum = prevPjnum - 1;
			map.put("pjnum", pjnum);
			map.put("userid", userid);
			System.out.println("pjnum: " + pjnum);
		}
		return sqlSession.update(NAMESPACE + "updatepjnum", map);
	}
	//템플렛 타입 업데이트
	public int updateTemptype(String temptype, String userid) {
		Map<String,Object> map = new HashMap<>();
		map.put("temptype", temptype);
		map.put("userid", userid);
		return sqlSession.update(NAMESPACE + "updateTemptype", map);
	}
	//템플렛 타입 기본값설정
	public boolean defaultTemptype(String temptype, String userid) {
		Map<String,Object> map = new HashMap<>();
		map.put("temptype", temptype);
		map.put("userid", userid);
		int count = sqlSession.update(NAMESPACE + "defaultTemptype", map);
		if(count > 0) {
			return true;
		}
			return false;
	}
	//회원탈퇴
	public boolean delAccount(String userid) {
		int count = sqlSession.update(NAMESPACE + "delAccount", userid);
		if(count > 0) {
			return true;
		}
		return false;
	}
	//url로 userid 찾기
	public String findid(String url) {
		UserVo userVo = sqlSession.selectOne(NAMESPACE + "findid", url);
		String userid = userVo.getUserid();
		return userid;
	}
}
