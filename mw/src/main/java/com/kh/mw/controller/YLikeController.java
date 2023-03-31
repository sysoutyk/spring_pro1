package com.kh.mw.controller;


import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.mw.service.Y_LikeService;
import com.kh.mw.vo.Y_AskLikeVo;
import com.kh.mw.vo.Y_LikeVo;

@Controller
@RequestMapping(value="/like/*")
public class YLikeController {
	@Autowired
	 Y_LikeService y_likeService;
	
	//하트 쿠키저장
	@RequestMapping(value="/chkcookie", method=RequestMethod.GET)
	@ResponseBody
	public String checkCookie(HttpServletRequest request, Model model, HttpServletResponse response) {
		Cookie[] cookies = request.getCookies();
		String cvalue = null;
		for(Cookie aCookie : cookies) {
			String cname = aCookie.getName();
			cvalue = aCookie.getValue();
			aCookie.setMaxAge(60*60*24);
			response.addCookie(aCookie);
		}	
		return cvalue;
	}
	//커플 Q+A하트 보내기
	@RequestMapping(value="/sendLike", method= RequestMethod.POST)
	@ResponseBody
	public boolean sendLike(Y_LikeVo likeVo) {				
		return y_likeService.sendLike(likeVo);
	}
	//하트가 존재여부 확인
	@RequestMapping(value="/isLike", method= RequestMethod.GET)
	@ResponseBody
	public String isLike(Y_LikeVo likeVo) {
		int count = y_likeService.isLike(likeVo);
		return String.valueOf(count);
	}

	//하객질문 하트입력
	@RequestMapping(value="/sendaskLike", method= RequestMethod.POST)
	@ResponseBody
	public boolean send_askLike(Y_AskLikeVo likeVo) {				
		System.out.println("like controller:" + likeVo);		
		return y_likeService.send_askLike(likeVo);
	}
	
	//하객질문 하트체크
	@RequestMapping(value="/isaskLike", method= RequestMethod.GET)
	@ResponseBody
	public String is_askLike(Y_AskLikeVo likeVo) {
		int count  = y_likeService.is_askLike(likeVo);
		return String.valueOf(count);
	}
}
