package com.kh.mw.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping(value = "/ysample/*")
public class YSampleController {
	
	//샘플구현
	@RequestMapping(value="/sampleHome", method=RequestMethod.GET)
	public String sampleHome() {
		return "/create/ysample/ysample_home";
	}
	@RequestMapping(value="/sampleStory", method=RequestMethod.GET)
	public String sampleStory() {
		return "/create/ysample/ysample_story";
	}
	@RequestMapping(value="/sampleQna", method=RequestMethod.GET)
	public String sampleQna() {
		return "/create/ysample/ysample_qna";
	}
	@RequestMapping(value="/sampleMes", method=RequestMethod.GET)
	public String sampleMes() {
		return "/create/ysample/ysample_mes";
	}
	@RequestMapping(value="/sampleGuestQna", method=RequestMethod.GET)
	public String sampleGuestQna() {
		return "/create/ysample/ysample_guestqna";
	}
	@RequestMapping(value="/sampleSend", method=RequestMethod.GET)
	public String sampleSend() {
		return "/create/ysample/ysample_send";
	}
	@RequestMapping(value="/sampleTravel", method=RequestMethod.GET)
	public String sampleTravel() {
		return "/create/ysample/ysample_travel";
	}
		
	
}