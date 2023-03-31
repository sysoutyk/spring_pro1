package com.kh.mw.service;

import java.util.HashMap;

import org.json.simple.JSONObject;
import org.springframework.stereotype.Service;

import net.nurigo.java_sdk.api.Message;
import net.nurigo.java_sdk.exceptions.CoolsmsException;

@Service
public class SmsService {
	public String certifiedPhoneNumber(String to, String text) throws CoolsmsException {
	String api_key = "NCSMREBU1X8GCSHH";
	String api_secret = "1MFRJCKEFFPA42PLLFCG4HIAF91AUUSL";
	Message coolsms = new Message(api_key, api_secret);
	
	HashMap<String, String> params = new HashMap<String, String>();
	params.put("to", to);
	params.put("from", "01050741929");
	params.put("type", "LMS");
	params.put("text", text);
	params.put("app_version",  "test app 1.2");
	
	System.out.println("params: " + params);
	
	JSONObject object = coolsms.send(params);
	System.out.println("object:"  + object);
	
	return "success";
	}
}