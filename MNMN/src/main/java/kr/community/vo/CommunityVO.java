package kr.community.vo;

import java.sql.Date;

public class CommunityVO {
	private int com_num;
	private String com_title;
	private int com_member_num;
	private String com_content;
	private Date com_date;
	private int com_hit;
	private String com_member_id;
	
	public int getCom_num() {
		return com_num;
	}
	public void setCom_num(int com_num) {
		this.com_num = com_num;
	}
	public String getCom_title() {
		return com_title;
	}
	public void setCom_title(String com_title) {
		this.com_title = com_title;
	}
	public int getCom_member_num() {
		return com_member_num;
	}
	public void setCom_member_num(int com_member_num) {
		this.com_member_num = com_member_num;
	}
	public String getCom_content() {
		return com_content;
	}
	public void setCom_content(String com_content) {
		this.com_content = com_content;
	}
	public Date getCom_date() {
		return com_date;
	}
	public void setCom_date(Date date) {
		this.com_date = date;
	}
	public int getCom_hit() {
		return com_hit;
	}
	public void setCom_hit(int com_hit) {
		this.com_hit = com_hit;
	}
	public String getCom_member_id() {
		return com_member_id;
	}
	public void setCom_member_id(String com_member_id) {
		this.com_member_id = com_member_id;
	}
	
	
	
	
}