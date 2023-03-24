package com.kh.mw.interceptor;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;


public class YurlInterceptor extends HandlerInterceptorAdapter{
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		System.out.println("preHandle");
		HttpSession session = request.getSession();
		// 입력한 url 알아내기
		String uri = request.getRequestURI();
		System.out.println("yurl: " + uri);
		int slashIndex = uri.lastIndexOf("/");
		String strUri = uri.substring(slashIndex+1);
		System.out.println("strUri: "+strUri);
		if(strUri != "story" || strUri != "qna" || strUri != "showmes" || strUri != "guestqna" || strUri != "travel" || strUri != "insertmes") {
			session.setAttribute("url_keyword", strUri);
			RequestDispatcher dispatcher = request.getRequestDispatcher("/create/invite");
			dispatcher.forward(request, response);
			return false;
		}else {
			uri = request.getRequestURI();
			System.out.println("yurl: " + uri);
			slashIndex = uri.lastIndexOf("/");
			strUri = uri.substring(slashIndex+1);
			System.out.println("strUri: "+strUri);
			RequestDispatcher dispatcher = request.getRequestDispatcher("/create/invite");
			dispatcher.forward(request, response);
			return false;
		}
		
//		return super.preHandle(request, response, handler);
	}
	
}
