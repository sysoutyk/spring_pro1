package com.kh.mw.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.mw.dao.UserDao;
import com.kh.mw.vo.UserVo;

@Service
public class UserService {
	
	@Autowired
	UserDao userDao;
	
	public boolean registerRun(UserVo userVo) {
		return userDao.registerRun(userVo);
	}

	public UserVo login_run(String userid, String userpw) {
		UserVo vo = userDao.login_run(userid, userpw);
		return vo;
	}
	
	public boolean isExistId(String inputId) {
		return userDao.isExistId(inputId);
	}
	public boolean isExistUrl(String url) {
		return userDao.isExistUrl(url);
	}
	public UserVo detail(String userid, String userpw) {
		UserVo userVo = userDao.detail(userid, userpw);
		return userVo;
	}
	public boolean modify(UserVo userVo) {
		return userDao.modify(userVo);
	}
	//회원 탈퇴
		public boolean delAccount(String userid) {
			return userDao.delAccount(userid);
		}
	//pjnum status 체크
	public int checkpjnum (String userid) {
		return userDao.checkpjnum(userid);
	}
	
	public int updatepjnum(int prevPjnum, String userid) {
		return userDao.updatepjnum(prevPjnum, userid);		
	}
	//temptype 업데이트
	public int updateTemptype(String temptype, String userid) {
		return userDao.updateTemptype(temptype, userid);		
	}
	//템프 타입 기본값으로 변경
	public boolean defaultTemptype(String temptype, String userid) {
		return userDao.defaultTemptype(temptype, userid);
	}
	
	//url값으로 userid찾기
	public String findid(String url) {
		return userDao.findid(url);
	}

}
