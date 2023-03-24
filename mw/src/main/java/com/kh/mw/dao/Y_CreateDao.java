package com.kh.mw.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.mw.vo.Y_GuestPagingDto;
import com.kh.mw.vo.Y_HomeVo;
import com.kh.mw.vo.Y_MessageVo;
import com.kh.mw.vo.Y_PhotoVo;
import com.kh.mw.vo.Y_QnaVo;
import com.kh.mw.vo.Y_StoryVo;
import com.kh.mw.vo.Y_TravelVo;

@Repository
public class Y_CreateDao {

	private final String NAMESPACE_H = "mappers.home.";
	private final String NAMESPACE_S = "mappers.story.";
	private final String NAMESPACE_Q = "mappers.qna.";
	private final String NAMESPACE_T = "mappers.travel.";
	private final String NAMESPACE_P = "mappers.photo.";
	private final String NAMESPACE_M = "mappers.message.";

	@Autowired
	private SqlSession sqlSession;

	public boolean insert(Y_HomeVo homeVo, Y_StoryVo storyVo, Y_TravelVo travelVo, Y_PhotoVo photoVo, int prevPjnum) {
		if (prevPjnum == 0) {
			int count_h = sqlSession.insert(NAMESPACE_H + "insert", homeVo);
			int count_s = sqlSession.insert(NAMESPACE_S + "insert", storyVo);
			int count_t = sqlSession.insert(NAMESPACE_T + "insert", travelVo);
			int count_p = sqlSession.insert(NAMESPACE_P + "insert", photoVo);
			if (count_h > 0 && count_s > 0 && count_t > 0 && count_p > 0) {
				return true;
			}
		}
		if (prevPjnum == 1) {
			System.out.println("createDao update");
			System.out.println("dao homeVo: " + homeVo);
			int count_h = sqlSession.update(NAMESPACE_H + "update", homeVo);
			int count_s = sqlSession.update(NAMESPACE_S + "update", storyVo);
			int count_t = sqlSession.update(NAMESPACE_T + "update", travelVo);
			int count_p = sqlSession.update(NAMESPACE_P + "update", photoVo);
			if (count_h > 0 && count_s > 0 && count_t > 0 && count_p > 0) {
				return true;
			}
		}
		return false;
	}

	public boolean insertQnA(Y_QnaVo qnaVo) {
		System.out.println("qnaVo dao: " + qnaVo);
		int count = sqlSession.insert(NAMESPACE_Q + "insert", qnaVo);
		if (count > 0) {
			return true;
		}

		return false;
	}
	public int isExistQno(String userid, int prevqno) {
		System.out.println("userid: " + userid);
		System.out.println("qno: " + prevqno);
		Map<String, Object> map = new HashMap<>();
		map.put("userid", userid);
		map.put("qno", prevqno);
		Y_QnaVo qnaVo = sqlSession.selectOne(NAMESPACE_Q + "isExistQno", map);
		
		System.out.println("foundQno: " + qnaVo.getQno());
		return qnaVo.getQno();
	}
	public int getNextVal_QnA() {
		return sqlSession.selectOne(NAMESPACE_Q + "getNextval");
	}
	public boolean updateQna(Y_QnaVo qnaVo) {
		System.out.println("updateQna: " + qnaVo);
		int count = sqlSession.update(NAMESPACE_Q + "update", qnaVo);
		if (count > 0) {
			return true;
		}
		return false;
	}

	public boolean delQna(int qno, String userid) {
		Map<String, Object> map = new HashMap<>();
		map.put("qno", qno);
		map.put("userid", userid);
		int count = sqlSession.delete(NAMESPACE_Q + "delQna", map);
		if (count > 0) {
			return true;
		}
		return false;
	}

	public Y_HomeVo searchHome(String userid) {
		Y_HomeVo homeVo = sqlSession.selectOne(NAMESPACE_H + "search", userid);
//		System.out.println("dao homeVo: " + homeVo);
		return homeVo;
	}

	public Y_StoryVo searchStory(String userid) {
		Y_StoryVo storyVo = sqlSession.selectOne(NAMESPACE_S + "search", userid);
//		System.out.println("dao storyVo: " + storyVo);
		return storyVo;
	}

	public List<Y_QnaVo> searchQna(String userid, Y_GuestPagingDto pagingDto) {
		Map<String, Object> map = new HashMap<>();
		map.put("startRow", pagingDto.getStartRow());
		map.put("endRow", pagingDto.getEndRow());
		map.put("userid", userid);
		List<Y_QnaVo> qnaVo = sqlSession.selectList(NAMESPACE_Q + "search", map);
//		System.out.println("searchQna pagingDto" + pagingDto.toString());
//		System.out.println("dao QnaVo: " + qnaVo);
		return qnaVo;
	}

	public Y_TravelVo searchTravel(String userid) {
		Y_TravelVo travelVo = sqlSession.selectOne(NAMESPACE_T + "search", userid);
//		System.out.println("dao TravelVo: " + travelVo);
		return travelVo;
	}

	public Y_PhotoVo searchPhoto(String userid) {
		Y_PhotoVo photoVo = sqlSession.selectOne(NAMESPACE_P + "search", userid);
//		System.out.println("dao photoVo: " + photoVo);
		return photoVo;
	}

	public int countQna(String userid) {
		int count = sqlSession.selectOne(NAMESPACE_Q + "countqna", userid);
		System.out.println("dao count :" + count);
		return count;
	}

	// 하객 쪽지입력
	public boolean insertMes(Y_MessageVo mesVo) {
		int count = sqlSession.insert(NAMESPACE_M + "insert", mesVo);
		System.out.println("dao insertMes" + count);
		if (count > 0) {
			return true;
		}
		return false;
	}
	//하객 쪽지 서치
	public List<Y_MessageVo> getMes(String userid) {
		System.out.println("dao getMes" + userid);
		return sqlSession.selectList(NAMESPACE_M + "search", userid);
	}
	
	public boolean mescount(String userid) {
		int mesCount = sqlSession.selectOne(NAMESPACE_M + "mescheck", userid);
		System.out.println("dao mesCount count: " + mesCount);
		if(mesCount > 0) {
			return true;
		}
		return false;
	}
	
	//하객 쪽지 삭제
	public boolean delMes(String userid) {
		int count = sqlSession.delete(NAMESPACE_M + "delete", userid);
		System.out.println("dao delMes" + count);
		if (count > 0) {
			return true;
		}
		return false;
	}

	
	// 커플질문 하트업데이트
	public void updateLikecnt(int qno, int count) {
		System.out.println("updateLikecnt qno: " + String.valueOf(qno));
		System.out.println("updateLikecnt count: " + String.valueOf(count));
		Map<String, Integer> map = new HashMap<>();
		map.put("qno", qno);
		map.put("count", count);
		int result = sqlSession.update(NAMESPACE_Q + "updateLikeCnt", map);
		System.out.println("result: " + result);
	}


	public boolean delete(String userid) {
		int count_q = sqlSession.delete(NAMESPACE_Q + "delete", userid);
		int count_h = sqlSession.delete(NAMESPACE_H + "delete", userid);
		int count_s = sqlSession.delete(NAMESPACE_S + "delete", userid);
		int count_t = sqlSession.delete(NAMESPACE_T + "delete", userid);
		int count_p = sqlSession.delete(NAMESPACE_P + "delete", userid);
//		System.out.println("count_h: " + count_h);
//		System.out.println("count_s: " + count_s);
//		System.out.println("count_t: " + count_t);
//		System.out.println("count_p: " + count_p);
//		System.out.println("count_q: " + count_q);
		if (count_h > 0 && count_s > 0 && count_t > 0 && count_p > 0 && count_q > 0) {
			return true;
		}
		return false;
	}
}
