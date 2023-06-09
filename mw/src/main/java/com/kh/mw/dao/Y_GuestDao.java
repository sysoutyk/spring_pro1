package com.kh.mw.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.mw.vo.Y_AskVo;
import com.kh.mw.vo.Y_GuestPagingDto;
import com.kh.mw.vo.Y_MessageVo;

@Repository
public class Y_GuestDao {
	private final String NAMESPACE_A = "mappers.ask.";
	private final String NAMESPACE_R = "mappers.read.";
	private final String NAMESPACE_M= "mappers.message.";

	@Autowired
	private SqlSession sqlSession;
	
	// 하객 질문입력
	public boolean insertQues(Y_AskVo quesVo) {
		int count = sqlSession.insert(NAMESPACE_A + "insert", quesVo);
		if (count > 0) {
			return true;
		}
		return false;
	}
	//하객질문 목록 @청첩장
	public List<Y_AskVo> qnalist(String userid, Y_GuestPagingDto pagingDto){
		Map<String, Object> map = new HashMap<>();
		map.put("userid", userid);
		map.put("startRow", pagingDto.getStartRow());
		map.put("endRow", pagingDto.getEndRow());
		return sqlSession.selectList(NAMESPACE_A + "qnalist",  map);
	}
	//하객질문 목록 @마이페이지
	public List<Y_AskVo> selectQues(String userid, Y_GuestPagingDto pagingDto){	
		Map<String, Object> map = new HashMap<>();
		map.put("userid", userid);
		map.put("startRow", pagingDto.getStartRow());
		map.put("endRow", pagingDto.getEndRow());
		return sqlSession.selectList(NAMESPACE_A + "mypageques",  map);
	}
	//하객질문 읽음
	public boolean readQues(String recipient, int qno) {
		Map<String, Object> map = new HashMap<>();
		map.put("recipient", recipient);
		map.put("qno", qno);
		int count = sqlSession.insert(NAMESPACE_R + "insert", map);
		if(count>0) {
			return true;
		}
		return false;
	}
	//질문 읽은지 확인
	public String isRead(String recipient, int qno) {
		Map<String, Object> map = new HashMap<>();
		map.put("recipient", recipient);
		map.put("qno", qno);
		Y_AskVo askVo = sqlSession.selectOne(NAMESPACE_A + "isRead", map);
		String readstat = askVo.getReadstat();
		return readstat;
	}
	//읽지 않은 하객질문 카운트
	public int unreadQues(String userid) {
		int count = sqlSession.selectOne(NAMESPACE_A + "unread", userid);
		return count;
	}
	//전체 하객질문 카운트
	public int getcount(String userid) {
		int count = sqlSession.selectOne(NAMESPACE_A + "getcount", userid);
		return count;
	}
	//읽은 하객질문 카운트
	public int getreadcount(String userid) {
		int count = sqlSession.selectOne(NAMESPACE_A + "read", userid);
		return count;
	}
	//하객질문 업데이트
	public boolean updateQues(Y_AskVo askVo) {
		int count = sqlSession.update(NAMESPACE_A + "update", askVo);
		if(count > 0) {
			return true;
		}
		return false;
	}
	// 커플질문 하트업데이트
	public void updateAskLike(int qno, int count) {
		Map<String, Integer> map = new HashMap<>();
		map.put("qno", qno);
		map.put("count", count);
		sqlSession.update(NAMESPACE_A + "updateLikeCnt", map);
	}
	//질문 개별삭제
	public boolean del_eachques(int qno, String recipient) {
		Map<String, Object> map = new HashMap<>();
		map.put("recipient", recipient);
		map.put("qno", qno);
		int count = sqlSession.delete(NAMESPACE_A + "deleachques", map);
		if(count>0) {
			return true;
		}
		return false;
	}
	//전체질문 삭제
	public boolean delQues(String userid) {
		int count = sqlSession.delete(NAMESPACE_A + "delete", userid);
		if(count > 0) {
			return true;
		}
		return false;
	}

	//하객쪽지 읽은현황
	public Y_MessageVo ismesread(String recipient, int bno) {
		Map<String, Object> map = new HashMap<>();
		map.put("recipient", recipient);
		map.put("bno", bno);
		return sqlSession.selectOne(NAMESPACE_M + "isread",  map);
	}
	
	//하객쪽지 카운트
	public int getmescount(String recipient){
		int count = sqlSession.selectOne(NAMESPACE_M + "getcount", recipient);
		return count;
	}
	//읽지않은 하객쪽지
	public int unreadmes(String userid) {
		int count = sqlSession.selectOne(NAMESPACE_M + "unread", userid);
		return count;
	}
	//하객쪽지 리스트
	public List<Y_MessageVo> getmeslist(String recipient, Y_GuestPagingDto pagingDto){
		Map<String, Object> map = new HashMap<>();
		map.put("recipient", recipient);
		map.put("startRow", pagingDto.getStartRow());
		map.put("endRow", pagingDto.getEndRow());
		List<Y_MessageVo> list = sqlSession.selectList(NAMESPACE_M + "mypagemes", map);
		return list;
	}
	//하객쪽지 읽음 업데이트
	public boolean updatemes(int bno, String rstat, String message, String recipient) {
		Map<String, Object> map = new HashMap<>();
		map.put("rstat", rstat);
		map.put("message", message);
		map.put("recipient", recipient);
		map.put("bno", bno);
		int count = sqlSession.update(NAMESPACE_M + "update", map);
		if(count > 0) {
			return true;
		}
		return false;
	}
	//하객쪽지 업로드
	public boolean upload(String uploadstat, int bno, String recipient) {
		Map<String, Object> map = new HashMap<>();
		map.put("uploadstat", uploadstat);
		map.put("bno", bno);
		map.put("recipient", recipient);
		int count = sqlSession.update(NAMESPACE_M + "upload", map);
		if(count>0) {
			return true;
		}
		return false;
	}
	//하객쪽지 삭제
	public boolean delmes(int bno, String recipient) {
		Map<String, Object> map = new HashMap<>();
		map.put("bno", bno);
		map.put("recipient", recipient);
		int count = sqlSession.delete(NAMESPACE_M + "deleachmes", map);
		if(count> 0) {
			return true;
		}
		return false;
	}
	
	
}
