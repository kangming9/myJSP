package kr.pet.vo;

import java.sql.Date;

public class AdoptVO {
	private int adopt_num;
	private int member_num;
	private int pet_num;
	private Date adopt_date;
	private String adopt_intro;
	private int adopt_married;
	private String adopt_house;
	private int adopt_now;
	private String adopt_why;
	public int getAdopt_num() {
		return adopt_num;
	}
	public void setAdopt_num(int adopt_num) {
		this.adopt_num = adopt_num;
	}
	public int getMember_num() {
		return member_num;
	}
	public void setMember_num(int member_num) {
		this.member_num = member_num;
	}
	public int getPet_num() {
		return pet_num;
	}
	public void setPet_num(int pet_num) {
		this.pet_num = pet_num;
	}
	public Date getAdopt_date() {
		return adopt_date;
	}
	public void setAdopt_date(Date adopt_date) {
		this.adopt_date = adopt_date;
	}
	public String getAdopt_intro() {
		return adopt_intro;
	}
	public void setAdopt_intro(String adopt_intro) {
		this.adopt_intro = adopt_intro;
	}
	public int getAdopt_married() {
		return adopt_married;
	}
	public void setAdopt_married(int adopt_married) {
		this.adopt_married = adopt_married;
	}
	public String getAdopt_house() {
		return adopt_house;
	}
	public void setAdopt_house(String adopt_house) {
		this.adopt_house = adopt_house;
	}
	public int getAdopt_now() {
		return adopt_now;
	}
	public void setAdopt_now(int adopt_now) {
		this.adopt_now = adopt_now;
	}
	public String getAdopt_why() {
		return adopt_why;
	}
	public void setAdopt_why(String adopt_why) {
		this.adopt_why = adopt_why;
	}
	
	
}
