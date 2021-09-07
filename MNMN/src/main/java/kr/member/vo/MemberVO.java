package kr.member.vo;

import java.sql.Date;

public class MemberVO {
	private int member_num;
	private String member_id;
	private int member_grade;
	private String member_detail_pw;
	private String member_detail_name;
	private String member_detail_phone;
	private String member_detail_photo;
	private Date member_detail_reg_date;
	private Date member_detail_new_date;
	
	//비밀번호 일치 여부 체크
	public boolean isCheckedPassword(String userPasswd) {
		//회원 등급(auth) : 탈퇴회원(0등급), 관리자(1등급), 입양회원(2등급), 일반회원(3등급)
		if(member_grade > 0 && member_detail_pw.equals(userPasswd)) {
			return true;
		}
		return false;
	}

	public int getMember_num() {
		return member_num;
	}

	public void setMember_num(int member_num) {
		this.member_num = member_num;
	}

	public String getMember_id() {
		return member_id;
	}

	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}

	public int getMember_grade() {
		return member_grade;
	}

	public void setMember_grade(int member_grade) {
		this.member_grade = member_grade;
	}

	public String getMember_detail_pw() {
		return member_detail_pw;
	}

	public void setMember_detail_pw(String member_detail_pw) {
		this.member_detail_pw = member_detail_pw;
	}

	public String getMember_detail_name() {
		return member_detail_name;
	}

	public void setMember_detail_name(String member_detail_name) {
		this.member_detail_name = member_detail_name;
	}

	public String getMember_detail_phone() {
		return member_detail_phone;
	}

	public void setMember_detail_phone(String member_detail_phone) {
		this.member_detail_phone = member_detail_phone;
	}

	public String getMember_detail_photo() {
		return member_detail_photo;
	}

	public void setMember_detail_photo(String member_detail_photo) {
		this.member_detail_photo = member_detail_photo;
	}

	public Date getMember_detail_reg_date() {
		return member_detail_reg_date;
	}

	public void setMember_detail_reg_date(Date member_detail_reg_date) {
		this.member_detail_reg_date = member_detail_reg_date;
	}

	public Date getMember_detail_new_date() {
		return member_detail_new_date;
	}

	public void setMember_detail_new_date(Date member_detail_new_date) {
		this.member_detail_new_date = member_detail_new_date;
	}
	
	
}



