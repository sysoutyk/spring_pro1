package com.kh.mw.vo;

import lombok.Data;

@Data
public class Y_GuestPagingDto {
	private int page = 1; 
	private int perPage = 5; 
	private int startRow = 1;
	private int endRow = 5;
	private int totalPage;
	private int count;
	
	
	public void setPagingInfo(int page, int count, int perPage) {
		this.page = page;
		this.count = count;
		this.perPage = perPage;
		this.endRow = page * perPage;
		this.startRow = this.endRow - (perPage - 1);
		this.totalPage = (int)Math.ceil((float)count / perPage);
		if(this.totalPage == this.page) {
			this.totalPage = this.page;
		}
	}
}
