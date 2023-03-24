package com.kh.mw.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.mw.dao.Y_GuestDao;
import com.kh.mw.vo.Y_AskVo;
import com.kh.mw.vo.Y_GuestPagingDto;
import com.kh.mw.vo.Y_MessageVo;

@Service
public class Y_GuestService {
	@Autowired
	Y_GuestDao y_guestDao;
	
	public boolean insertQues(Y_AskVo quesVo) {
		return y_guestDao.insertQues(quesVo);
	}
	public List<Y_AskVo> qnalist(String userid, Y_GuestPagingDto pagingDto){
		return y_guestDao.qnalist(userid, pagingDto);
	}
	public List<Y_AskVo> selectQues(String userid, Y_GuestPagingDto pagingDto) {
		return y_guestDao.selectQues(userid, pagingDto);
	}
	public boolean readQues(String recipient, int qno) {
		return y_guestDao.readQues(recipient, qno);
	}
	public String isRead(String recipient, int qno) {
		return y_guestDao.isRead(recipient, qno);
	}
	public int unreadQues(String userid) {
		return y_guestDao.unreadQues(userid);
	}
	public int getcount(String userid) {
		return y_guestDao.getcount(userid);
	}
	public int getreadcount(String userid) {
		return y_guestDao.getreadcount(userid);
	}
	public boolean quescount(String userid) {
		return y_guestDao.quescount(userid);
	}
	public boolean updateQues(Y_AskVo askVo) {
		return y_guestDao.updateQues(askVo);
	}
	public boolean del_eachques(int qno, String recipient) {
		return y_guestDao.del_eachques(qno, recipient);
	}
	public boolean delQues(String userid) {
		return y_guestDao.delQues(userid);
	}
	//하객쪽지 읽은상태
	public Y_MessageVo ismesread(String recipient, int bno) {
		return y_guestDao.ismesread(recipient, bno);
	}
	//읽지않은 하객쪽지 
	public int unreadmes(String userid) {
		return y_guestDao.unreadmes(userid);
	}
	//하객쪽지 읽음 업데이트
	public boolean updatemes(int bno, String rstat, String message,String recipient) {
		return y_guestDao.updatemes(bno, rstat, message, recipient);
	}
	//쪽지 승인
	public boolean upload(String uploadstat, int bno, String recipient) {
		return y_guestDao.upload(uploadstat, bno, recipient);
	}
	//하객쪽지 카운트
	public int getmescount(String recipient) {
		return y_guestDao.getmescount(recipient);
	}
	//하객쪽지 리스트
	public List<Y_MessageVo> getmeslist(String recipient, Y_GuestPagingDto pagingDto){
		return y_guestDao.getmeslist(recipient, pagingDto);
	}
	//하객쪽지 삭제
	public boolean delmes(int bno, String recipient) {
		return y_guestDao.delmes(bno, recipient);
	}
	
}
