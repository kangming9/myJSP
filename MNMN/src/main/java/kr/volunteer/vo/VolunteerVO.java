package kr.volunteer.vo;

import java.sql.Date;

public class VolunteerVO {
	private int vol_num;
	private int vol_m_num;
	private Date vol_date;
	private int vol_time;
	private Date vol_reg_date;
	
	
	public int getVol_num() {
		return vol_num;
	}
	public void setVol_num(int vol_num) {
		this.vol_num = vol_num;
	}
	public int getVol_m_num() {
		return vol_m_num;
	}
	public void setVol_m_num(int vol_m_num) {
		this.vol_m_num = vol_m_num;
	}
	public Date getVol_date() {
		return vol_date;
	}
	public void setVol_date(Date vol_date) {
		this.vol_date = vol_date;
	}
	public int getVol_time() {
		return vol_time;
	}
	public void setVol_time(int vol_time) {
		this.vol_time = vol_time;
	}
	public Date getVol_reg_date() {
		return vol_reg_date;
	}
	public void setVol_reg_date(Date vol_reg_date) {
		this.vol_reg_date = vol_reg_date;
	}
}
