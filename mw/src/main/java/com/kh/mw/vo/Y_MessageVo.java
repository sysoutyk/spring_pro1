package com.kh.mw.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Y_MessageVo {
	private int bno;
	private String writedate;
	private String message;
	private String mespic;
	private String writer;
	private String recipient;
	private String uploadstat;
	private String rstat;
	
	public void setMessageInfo(String writedate, String message, String mespic, String writer) {
		this.writedate = writedate;
		this.message = message;
		this.mespic = mespic;
		this.writer = writer;
	}
}
