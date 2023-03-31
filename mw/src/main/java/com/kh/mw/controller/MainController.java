package com.kh.mw.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;


import com.kh.mw.service.Y_GuestService;
import com.kh.mw.vo.UserVo;

@Controller
@RequestMapping("/main/*")
public class MainController {
	
	@Autowired
	Y_GuestService y_guestService;
	
	@RequestMapping(value = "/home_form", method = RequestMethod.GET)
	public String home() {
		return "main/home_form";
	}
	
	@RequestMapping(value = "/dashboard", method = RequestMethod.GET)
	public String dataInsert() {
		return "main/updateBlog";
	}
	@RequestMapping(value = "/create_form", method = RequestMethod.GET)
	public String createForm(HttpSession session, Model Model) {
		UserVo userVo = (UserVo)session.getAttribute("loginInfo");
		Model.addAttribute("loginInfo", userVo);
		return "main/create_form";
	}
	@RequestMapping(value = "/choose_temp", method = RequestMethod.GET)
	public String chooseForm() {
		return "create/choose_temp";
	}
	// 메인페이지 - Log in
	@RequestMapping(value = "/login_form", method = RequestMethod.GET)
	public String login() {
		return "/main/login_form";
	}
	
	
}
