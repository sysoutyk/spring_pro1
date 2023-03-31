package com.kh.mw.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.mw.service.SmsService;
import com.kh.mw.service.Y_CreateService;
import com.kh.mw.vo.UserVo;
import com.kh.mw.vo.Y_HomeVo;

import net.nurigo.java_sdk.exceptions.CoolsmsException;

@Controller
@RequestMapping("/sms/*")
public class SmsController {
	
	@Autowired
	private SmsService smsService;
	@Autowired
	private Y_CreateService ycreateService;
	
	@RequestMapping(value = "/send", method = RequestMethod.POST)
	@ResponseBody
	public String sendMessage(@RequestParam(value="arr_g_no[]") String[] arr_g_no, String userid, HttpSession session) throws CoolsmsException {	// 15번 가능 -> 14
		System.out.println(arr_g_no);
		String phonenumber = String.join(",", arr_g_no);
		String to = phonenumber.replaceAll("-", "");
		String server_addr = "172.16.6.35/create/invite?url=";
		UserVo userVo = (UserVo)session.getAttribute("loginInfo");
		String web_addr = server_addr + userVo.getUrl();

		
		Y_HomeVo vo = ycreateService.searchHome(userVo.getUserid());
		System.out.println(vo);
		String groomNm = vo.getGroomNm();
		String brideNm = vo.getBrideNm();
		String webdate = vo.getWedDate();
		String webtime = vo.getWedTime();
		String webaddr = vo.getWed_addr();
		
		
		String text = "저희 결혼합니다♥\n" + groomNm + "♥" + brideNm + " 결혼식에 초대합니다.\n" + "일시 : " + webdate +"&nbsp"+ webtime + "\n장소 : " + webaddr +"\n청첩장 : " + web_addr;
		System.out.println(text);
		
		return smsService.certifiedPhoneNumber(to, text);		
	}
	
}
