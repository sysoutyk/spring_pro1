package com.kh.mw.controller;


import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.mw.service.UserService;
import com.kh.mw.service.Y_GuestService;
import com.kh.mw.vo.Y_AskVo;
import com.kh.mw.vo.Y_GuestPagingDto;
import com.kh.mw.vo.Y_MessageVo;

@Controller
@RequestMapping(value = "/yguest/*")
public class YGuestController {
	
	@Autowired
	UserService userService;
	@Autowired
	Y_GuestService y_guestService;

	
	//하객질문 보내기
	@RequestMapping(value = "/send", method= RequestMethod.POST)
	@ResponseBody
	public boolean insertQues(Y_AskVo quesVo, HttpSession session) {
		boolean result = y_guestService.insertQues(quesVo);
		if (result == true) {
			session.removeAttribute("unreadQues");
			int count = y_guestService.unreadQues(quesVo.getRecipient());
			session.setAttribute("unreadQues", count);
			return true;
		}
		return false;
	}
	//하객질문 읽음
	@RequestMapping(value="/read", method= RequestMethod.POST)
	@ResponseBody
	@Transactional
	public boolean readQues(String recipient, int qno, HttpSession session) {
		boolean result = y_guestService.readQues(recipient, qno);
		if(result == true) {
			return result;
		}
		return result;
	}
	//하객질문 읽은지 상태 체크
	@RequestMapping(value="/isread", method= RequestMethod.GET)
	@ResponseBody
	public String isread(String recipient, int qno) {
		return y_guestService.isRead(recipient, qno);
	
	}
	//업데이트
	@RequestMapping(value = "/update", method= RequestMethod.POST)
	@ResponseBody
	public boolean updateQues(Y_AskVo askVo, HttpSession session) {
		boolean result = y_guestService.updateQues(askVo);
		if (result == true) {
			session.removeAttribute("unreadQues");
			int count = y_guestService.unreadQues(askVo.getRecipient());
			session.setAttribute("unreadQues", count);
			return true;
		}
		return false;
	}

	//질문삭제
	@RequestMapping(value= "/deleachques", method=RequestMethod.POST)
	@ResponseBody
	public boolean del_eachques(
			@RequestParam(value="arr_qno[]")int[] arr_qno, String recipient, 
							int page, int perPage, HttpSession session) {
		System.out.println("arr_qno " + arr_qno);
		boolean result = false;
		for(int qno: arr_qno) {
			result = y_guestService.del_eachques(qno, recipient);
		}
		if(result == true) {
			session.removeAttribute("unreadQues");
			Y_GuestPagingDto dto = new Y_GuestPagingDto();
			int newPerpage = perPage - 1;
			dto.setPagingInfo(page, dto.getCount(), newPerpage);
			int currentEndrow = dto.getEndRow();
			int newEndRow = currentEndrow-1;
			dto.setEndRow(newEndRow);
			int count = y_guestService.unreadQues(recipient);
			session.setAttribute("unreadQues", count);
			return true;
		}
		return false;
	}
	//쪽지 읽은지 확인
	@RequestMapping(value="/ismesread", method=RequestMethod.GET)
	@ResponseBody
	public String ismesRead(String recipient, int bno, Model model) {
		Y_MessageVo messageVo = y_guestService.ismesread(recipient, bno);
		String rstat = messageVo.getRstat();
		return rstat;
	}
	//쪽지 업데이트
	@RequestMapping(value="/updatemes", method=RequestMethod.POST)
	@ResponseBody
	public boolean updatemes(int bno, String rstat, String message, String recipient, HttpSession session) {
		boolean result = y_guestService.updatemes(bno, rstat,message, recipient);
		if(result == true) {
			session.removeAttribute("unreadMes");
			int count = y_guestService.unreadmes(recipient);
			session.setAttribute("unreadMes", count);
			return result;
		}
		return result;
	}
	//쪽지 업로드
	@RequestMapping(value="/upload", method=RequestMethod.POST)
	@ResponseBody
	public boolean upload(String uploadstat, int bno, String recipient) {
		return y_guestService.upload(uploadstat, bno, recipient);
	}
	//쪽지 삭제
	@RequestMapping(value="/delmes", method=RequestMethod.GET)
	@ResponseBody
	public boolean delmes(@RequestParam (value="arr_bno[]")int[] arr_bno, String recipient, 
							int page, int perPage, HttpSession session) {
		Y_GuestPagingDto pagingDto = new Y_GuestPagingDto();
		boolean result = false;
		for(int bno:arr_bno) {
			result = y_guestService.delmes(bno, recipient);
			int mescount = y_guestService.getmescount(recipient);
			int updatePerPage = perPage - 1;
			pagingDto.setPagingInfo(page, mescount, updatePerPage);
			pagingDto.setEndRow(pagingDto.getEndRow()-1);
		}
		if(result == true) {
			session.removeAttribute("unreadMes");
			int count = y_guestService.unreadmes(recipient);
			session.setAttribute("unreadMes", count);
			return true;
		}
		return false;
	}//쪽지 삭제
}
