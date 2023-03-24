package com.kh.mw.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Y_AskVo {
	
	private int qno;
	private String recipient;
	private String question;
	private String answer;
	private String sender;
	private String readstat;
	private Date writedate;
	private Date replydate;
	private int likecount;
}
