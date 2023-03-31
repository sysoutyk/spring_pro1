package com.kh.mw.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.mw.service.UserService;
import com.kh.mw.service.Y_CreateService;
import com.kh.mw.service.Y_GuestService;
import com.kh.mw.vo.UserVo;
import com.kh.mw.vo.Y_AskVo;
import com.kh.mw.vo.Y_GuestPagingDto;
import com.kh.mw.vo.Y_MessageVo;

@Controller
@RequestMapping("/user/*")
public class UserController {
	
	final String MANAGERID = "admin";
	
	@Autowired
	UserService userService;
	@Autowired
	Y_GuestService y_guestService;
	@Autowired
	Y_CreateService y_createService;
	
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String login() {
		return "user/login";
	}
	
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String login_run(String userid, String userpw, HttpSession session, RedirectAttributes rttr, Model model) {
		UserVo vo = userService.login_run(userid, userpw);
		int unreadQues = y_guestService.unreadQues(userid);
		int unreadMes = y_guestService.unreadmes(userid);
		//로그인이 안되거나 탈퇴한 회원이면
		if(vo==null) {
			rttr.addFlashAttribute("loginResult","fail");
			return "redirect:/user/login";
		}else if(vo.getWithdraw()!=null) {
			rttr.addFlashAttribute("loginResult","withdraw");
			return "redirect:/user/login";
		}
		session.setAttribute("loginInfo", vo);
		session.setAttribute("unreadQues", unreadQues);
		session.setAttribute("unreadMes", unreadMes);
		rttr.addFlashAttribute("loginResult","success");
		
		if(vo.getUserid().equals(MANAGERID)) {
			rttr.addFlashAttribute("loginResult","manager");	
		}
		
		// 로그인 시 페이지 상태 유지 추가 
		String targetLocation = (String)session.getAttribute("targetLocation");
		session.removeAttribute("targetLocation");
		String page = "";
		if(targetLocation != null && !targetLocation.equals("")) {
			page = "redirect:" + targetLocation;
		} else {
			
			page = "redirect:/main/home_form";
		}
		return page;
	}
	//회원등록
	@RequestMapping(value ="/register", method = RequestMethod.GET)
	public String register() {
		return "user/register_form";
	}
	//회원등록처리
	@RequestMapping(value = "/register_run", method = RequestMethod.POST)
	public String registerRun(UserVo userVo, RedirectAttributes rttr) {
		userService.registerRun(userVo);
		rttr.addFlashAttribute("register_result", "success");
		return "redirect:/user/login";
	}
	
	@RequestMapping(value = "/isExistId", method = RequestMethod.GET)
	@ResponseBody
	public String checkId(String inputId) {
		boolean result = userService.isExistId(inputId);
		String strResult = "";
		if(result ==true) {
			strResult = "true";
		}else{
			strResult = "false";
		}
		System.out.println(strResult);
		return strResult;
	}
	@RequestMapping(value = "/isExistUrl", method = RequestMethod.GET)
	@ResponseBody
	public boolean checkUrl(String url) {
		return  userService.isExistUrl(url);
	}

	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/main/home_form";
	}
	
	//마이페이지 하객질문
	@Transactional
	@RequestMapping(value = "/mypage", method= RequestMethod.GET)
	public String mypage(HttpSession session, Model model, Y_GuestPagingDto pagingDto) {
		UserVo userVo = (UserVo) session.getAttribute("loginInfo");
		String unreadQues = String.valueOf(y_guestService.unreadQues(userVo.getUserid()));
		String unreadMes = String.valueOf(y_guestService.unreadmes(userVo.getUserid()));
		
		int count = y_guestService.getcount(userVo.getUserid());
		pagingDto.setPagingInfo(pagingDto.getPage(),count, pagingDto.getPerPage());
		List<Y_AskVo> list = y_guestService.selectQues(userVo.getUserid(), pagingDto);
		
		model.addAttribute("list", list);
		model.addAttribute("unreadQues", unreadQues);
		model.addAttribute("unreadMes", unreadMes);
		model.addAttribute("url", userVo.getUrl());
		model.addAttribute("pagingDto", pagingDto);
		
		return "/user/mypage";
	}
	//마이페이지 하객쪽지
	@RequestMapping(value="/guestmes", method= RequestMethod.GET)
	public String guestmessage(HttpSession session, Model model, Y_GuestPagingDto pagingDto) {
		UserVo userVo = (UserVo) session.getAttribute("loginInfo");
		String unreadQues = String.valueOf(y_guestService.unreadQues(userVo.getUserid()));
		String unreadMes = String.valueOf(y_guestService.unreadmes(userVo.getUserid()));
		
		int count = y_guestService.getmescount(userVo.getUserid());
		pagingDto.setPagingInfo(pagingDto.getPage(), count, pagingDto.getPerPage());
		List<Y_MessageVo> list = y_guestService.getmeslist(userVo.getUserid(), pagingDto);
		
		model.addAttribute("url", userVo.getUrl());
		model.addAttribute("list", list);
		model.addAttribute("unreadQues", unreadQues);
		model.addAttribute("unreadMes", unreadMes);
		model.addAttribute("pagingDto", pagingDto);
		
		return "/user/guestmes";
	}
	@RequestMapping(value = "/inputpassword", method = RequestMethod.GET)
	public String inputpassword(HttpSession session) {
		return "/user/inputpassword";
	}
	//userinfo페이지
	@RequestMapping(value = "/userinfo", method = RequestMethod.GET)
	public String userinfo(HttpSession session) {
		return "/user/userinfo";
	}
	@RequestMapping(value = "/userinfo", method = RequestMethod.POST)
	public String userinfo(HttpSession session, String userpw, RedirectAttributes rttr) {
		UserVo vo = (UserVo)session.getAttribute("loginInfo");
		if(userpw.equals(vo.getUserpw())){
			session.setAttribute("vo", vo);
			return "/user/userinfo";
		}else {
			rttr.addFlashAttribute("checkPw","wrong");
			return "redirect:/user/inputpassword";
		}
	}
	//회원정보수정
	@RequestMapping(value="/modify", method = RequestMethod.POST)
	public String modify(UserVo userVo, RedirectAttributes rttr) {
		boolean result = userService.modify(userVo);
		rttr.addFlashAttribute("update", "success");
		return "redirect:/user/login";
	}
	//회원탈퇴
	@RequestMapping(value="/delAccount", method = RequestMethod.GET)
	@ResponseBody
	public boolean delAccount(String userid, HttpSession session) {
		boolean result = userService.delAccount(userid);
		if(result == true) {
			session.invalidate();
			return true;
		}
		return false;
	}
}
