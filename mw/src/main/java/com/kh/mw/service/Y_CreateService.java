package com.kh.mw.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.mw.dao.Y_CreateDao;
import com.kh.mw.dao.Y_GuestDao;
import com.kh.mw.dao.Y_LikeDao;
import com.kh.mw.vo.Y_AskVo;
import com.kh.mw.vo.Y_GuestPagingDto;
import com.kh.mw.vo.Y_HomeVo;
import com.kh.mw.vo.Y_MessageVo;
import com.kh.mw.vo.Y_PhotoVo;
import com.kh.mw.vo.Y_QnaVo;
import com.kh.mw.vo.Y_StoryVo;
import com.kh.mw.vo.Y_TravelVo;

@Service
public class Y_CreateService {
	
	@Autowired
	Y_CreateDao y_createDao;
	@Autowired
	Y_LikeDao y_likeDao;
	@Autowired
	Y_GuestDao y_guestDao;

	public boolean insert(Y_HomeVo homeVo, Y_StoryVo storyVo, Y_TravelVo travelVo, Y_PhotoVo photoVo, int prevPjnum) {
		return y_createDao.insert(homeVo, storyVo, travelVo, photoVo, prevPjnum);
	}

	public boolean insertQnA(Y_QnaVo qnaVo) {
		System.out.println("service qna" + qnaVo);
		return y_createDao.insertQnA(qnaVo);
	}
	public int isExistQno(String userid, int prevqno) {
		return y_createDao.isExistQno(userid, prevqno);
	}
	public int getNextval_QnA() {
		return y_createDao.getNextVal_QnA();
	}
	public boolean updateQna(Y_QnaVo qnaVo) {
		System.out.println("service update qna: " + qnaVo);
		return y_createDao.updateQna(qnaVo);
	}
	public boolean delQna(int qno, String userid) {
		return y_createDao.delQna(qno, userid);
	}

	@Transactional
	public Map<String, Object> searchInfo(String userid, Y_GuestPagingDto pagingDto) {
		
//		System.out.println("service searchId" + userid);
		Y_HomeVo homeVo = y_createDao.searchHome(userid);
		Y_StoryVo storyVo = y_createDao.searchStory(userid);
		List<Y_QnaVo> qnaVo = y_createDao.searchQna(userid, pagingDto);
		if(qnaVo == null) {
			return null;
		}
		Y_TravelVo travelVo = y_createDao.searchTravel(userid);
		Y_PhotoVo photoVo = y_createDao.searchPhoto(userid);
		List<Y_MessageVo> mesVo = y_createDao.getMes(userid);
		List<Y_AskVo> askVo = y_guestDao.qnalist(userid, pagingDto);
		int askcount = y_guestDao.getreadcount(userid);
		pagingDto.setPagingInfo(pagingDto.getPage(), askcount, pagingDto.getPerPage());
		int qnacount = y_createDao.countQna(userid);
					

		Map<String, Object> map = new HashMap<>();
		map.put("homeVo", homeVo);
		map.put("storyVo", storyVo);
		map.put("qnaVo", qnaVo);
		map.put("travelVo", travelVo);
		map.put("photoVo", photoVo);
		map.put("mesVo", mesVo);
		map.put("askVo", askVo);
		map.put("pagingDto", pagingDto);
		map.put("qnacount", qnacount);
		
		return map;
	}

	public Y_HomeVo searchHome(String userid) {
		return y_createDao.searchHome(userid);
	}

	public Y_StoryVo searchStory(String userid) {
		return y_createDao.searchStory(userid);
	}

	public List<Y_QnaVo> searchQna(String userid, Y_GuestPagingDto pagingDto) {
		int qnacount = y_createDao.countQna(userid);
		pagingDto.setPagingInfo(pagingDto.getPage(), qnacount, pagingDto.getPerPage());
		return y_createDao.searchQna(userid, pagingDto);
	}

	public Y_TravelVo searchTravel(String userid) {
		return y_createDao.searchTravel(userid);
	}

	public Y_PhotoVo searchPhoto(String userid) {
		return y_createDao.searchPhoto(userid);
	}
	//하객 질문 서치
	public List<Y_AskVo> searchGuestqna(String userid, Y_GuestPagingDto pagingDto) {
		return y_guestDao.qnalist(userid, pagingDto);
	}
	// 하객 축하+감사 쪽지 입력
	public boolean insertMes(Y_MessageVo mesVo) {
		return y_createDao.insertMes(mesVo);
	}
	//하객 쪽지 서치
	public List<Y_MessageVo> searchMes(String userid) {
		return y_createDao.getMes(userid);
	}
	public boolean mescount (String userid) {
		return y_createDao.mescount(userid);
	}
	//하객 쪽지 삭제
	public boolean delMes(String userid) {
		return y_createDao.delMes(userid);
	}
	
	public boolean delete(String userid) {		
		return y_createDao.delete(userid);
	}

}
