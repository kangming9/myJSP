package kr.pet.vo;

import java.sql.Date;

public class PetVO {
	private int pet_num;
	private String pet_name;
	private String pet_type;
	private int pet_adopt;
	private String pet_detail;
	private Date pet_date;
	private String pet_photo;
	public int getPet_num() {
		return pet_num;
	}
	public void setPet_num(int pet_num) {
		this.pet_num = pet_num;
	}
	public String getPet_name() {
		return pet_name;
	}
	public void setPet_name(String pet_name) {
		this.pet_name = pet_name;
	}
	public String getPet_type() {
		return pet_type;
	}
	public void setPet_type(String pet_type) {
		this.pet_type = pet_type;
	}
	public int getPet_adopt() {
		return pet_adopt;
	}
	public void setPet_adopt(int pet_adopt) {
		this.pet_adopt = pet_adopt;
	}
	public String getPet_detail() {
		return pet_detail;
	}
	public void setPet_detail(String pet_detail) {
		this.pet_detail = pet_detail;
	}
	public Date getPet_date() {
		return pet_date;
	}
	public void setPet_date(Date pet_date) {
		this.pet_date = pet_date;
	}
	public String getPet_photo() {
		return pet_photo;
	}
	public void setPet_photo(String pet_photo) {
		this.pet_photo = pet_photo;
	}
	
	
}
