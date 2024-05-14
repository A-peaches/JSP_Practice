package com.cal.db;

import java.sql.Date;

public class CalBean {
	private int cal_no;
	private Date cal_date;
	private String cal_op;
	private String cal_result;
	public int getCal_no() {
		return cal_no;
	}
	public void setCal_no(int cal_no) {
		this.cal_no = cal_no;
	}
	public Date getCal_date() {
		return cal_date;
	}
	public void setCal_date(Date cal_date) {
		this.cal_date = cal_date;
	}
	public String getCal_op() {
		return cal_op;
	}
	public void setCal_op(String cal_op) {
		this.cal_op = cal_op;
	}
	public String getCal_result() {
		return cal_result;
	}
	public void setCal_result(String cal_result) {
		this.cal_result = cal_result;
	}
	
	
}
