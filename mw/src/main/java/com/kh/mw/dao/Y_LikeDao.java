package com.kh.mw.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.mw.vo.Y_AskLikeVo;
import com.kh.mw.vo.Y_LikeVo;

@Repository
public class Y_LikeDao {
	private final String NAMESPACE_L = "mappers.like.";
	private final String NAMESPACE_A = "mappers.ask.";
	@Autowired
	private SqlSession sqlsession;

	//커플질문_하트입력
	public boolean sendLike(Y_LikeVo likeVo) {
		System.out.println("like Y_LikeDao:" + likeVo);
		int count = sqlsession.insert(NAMESPACE_L + "sendLike", likeVo);
		System.out.println("like dao: " + count);
		if (count > 0) {
			return true;
		}
		return false;
	}

	//커플질문_하트체크
	public int isLike(Y_LikeVo likeVo) {
		System.out.println("dao isLike likeVo: " + likeVo);
		int likeCount = sqlsession.selectOne(NAMESPACE_L + "isLike", likeVo);
		System.out.println("dao likeCOunt: " + likeCount);
		return likeCount;
	}
	
	//하객질문_하트체크
	public int likecheck(String userid) {
		System.out.println("dao checklike: " + userid);
		int likeCount = sqlsession.selectOne(NAMESPACE_L + "likecheck", userid);
		System.out.println("dao likecheck count: " + likeCount);
		return likeCount;
	}
	//커플질문_하트취소
	public boolean delLike(Y_LikeVo likeVo) {
		int count = sqlsession.delete(NAMESPACE_L + "delLike", likeVo);
		System.out.println("delLike count: " + count);
		if (count > 0) {
			return true;
		}
		return false;
	}
	//커플질문_하트전체삭제
	public boolean delete(String userid) {
		int count = sqlsession.delete(NAMESPACE_L + "delete", userid);
		System.out.println("delete count: " + count);
		if (count > 0) {
			return true;
		}
		return false;
	}
	//하객질문 하트입력
	public boolean send_askLike(Y_AskLikeVo likeVo) {
		System.out.println("like Y_LikeDao:" + likeVo);
		int count = sqlsession.insert(NAMESPACE_A + "sendLike", likeVo);
		System.out.println("like dao: " + count);
		if (count > 0) {
			return true;
		}
		return false;
	}
	//하객질문 하트 선택체스
	public int is_askLike(Y_AskLikeVo likeVo) {
		System.out.println("dao isLike likeVo: " + likeVo);
		int likeCount = sqlsession.selectOne(NAMESPACE_A + "isLike", likeVo);
		System.out.println("dao likeCOunt: " + likeCount);
		return likeCount;
	}
	//하객질문_하트체크
	public int asklike_check(String recipient) {
		System.out.println("dao checklike: " + recipient);
		int likeCount = sqlsession.selectOne(NAMESPACE_A + "likecheck", recipient);
		System.out.println("dao likecheck count: " + likeCount);
		return likeCount;
	}

	//하객질문_하트취소
	public boolean del_askLike(Y_AskLikeVo likeVo) {
		int count = sqlsession.delete(NAMESPACE_A + "delLike", likeVo);
		System.out.println("delLike count: " + count);
		if (count > 0) {
			return true;
		}
		return false;
	}
	//하객질문_하트전체삭제
	public boolean delete_askLike(String recipient) {
		int count = sqlsession.delete(NAMESPACE_A + "delAskLike", recipient);
		System.out.println("delete count: " + count);
		if (count > 0) {
			return true;
		}
		return false;
	}
}
