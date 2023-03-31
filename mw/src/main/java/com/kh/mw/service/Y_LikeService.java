package com.kh.mw.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.mw.dao.Y_CreateDao;
import com.kh.mw.dao.Y_GuestDao;
import com.kh.mw.dao.Y_LikeDao;
import com.kh.mw.vo.Y_AskLikeVo;
import com.kh.mw.vo.Y_LikeVo;

@Service
public class Y_LikeService {
	@Autowired
	Y_LikeDao y_likeDao;
	@Autowired
	Y_CreateDao y_createDao;
	@Autowired
	Y_GuestDao y_guestDao;
	
	@Transactional
	public boolean sendLike(Y_LikeVo likeVo) {
		y_createDao.updateLikecnt(likeVo.getQno(), 1);
		System.out.println("like service:" + likeVo);
		return y_likeDao.sendLike(likeVo);
	}

	public int isLike(Y_LikeVo likeVo) {
		return y_likeDao.isLike(likeVo);
	}
	public int likecheck(String userid) {
		return y_likeDao.likecheck(userid);
	}
	public boolean delLike(Y_LikeVo likeVo) {
		return y_likeDao.delLike(likeVo);		
	}
	public boolean delete(String userid) {
		return y_likeDao.delete(userid);		
	}
	@Transactional
	public boolean send_askLike(Y_AskLikeVo likeVo) {
		y_guestDao.updateAskLike(likeVo.getQno(), 1);
		return y_likeDao.send_askLike(likeVo);
	}
	public int is_askLike(Y_AskLikeVo likeVo) {
		return y_likeDao.is_askLike(likeVo);
	}
	public boolean del_askLike(Y_AskLikeVo likeVo) {
		return y_likeDao.del_askLike(likeVo);		
	}
	public boolean delete_askLike(String recipient) {
		return y_likeDao.delete_askLike(recipient);		
	}

}
