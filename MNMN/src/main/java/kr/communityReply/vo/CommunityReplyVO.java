package kr.communityReply.vo;

import java.sql.Date;

public class CommunityReplyVO {
	private int re_num;
	private String re_content;
	private Date re_date;
	private int com_num;
	private int member_num;
	private String member_id;
	private int rrr;
	
	public int getRrr() {
		return rrr;
	}
	public void setRrr(int rrr) {
		this.rrr = rrr;
	}
	public int getRe_num() {
		return re_num;
	}
	public void setRe_num(int re_num) {
		this.re_num = re_num;
	}
	public String getRe_content() {
		return re_content;
	}
	public void setRe_content(String re_content) {
		this.re_content = re_content;
	}
	public Date getRe_date() {
		return re_date;
	}
	public void setRe_date(Date re_date) {
		this.re_date = re_date;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public int getCom_num() {
		return com_num;
	}
	public void setCom_num(int com_num) {
		this.com_num = com_num;
	}
	public int getMember_num() {
		return member_num;
	}
	public void setMember_num(int member_num) {
		this.member_num = member_num;
	}
	
	
	
	
}
