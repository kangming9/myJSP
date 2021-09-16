package kr.donation.vo;

import java.sql.Date;

public class DonationVO {
	private int num;
	private String name;
	private Date birth;
	private String addr;
	private String tel;
	private int tel_rec;
	private String mail;
	private int mail_rec;
	private int routine;
	private int money;
	private String bank;
	private String account;
	private String bank_name;
	
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Date getBirth() {
		return birth;
	}
	public void setBirth(Date birth) {
		this.birth = birth;
	}
	public String getAddr() {
		return addr;
	}
	public void setAddr(String addr) {
		this.addr = addr;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public int getTel_rec() {
		return tel_rec;
	}
	public void setTel_rec(int tel_rec) {
		this.tel_rec = tel_rec;
	}
	public String getMail() {
		return mail;
	}
	public void setMail(String mail) {
		this.mail = mail;
	}
	public int getMail_rec() {
		return mail_rec;
	}
	public void setMail_rec(int mail_rec) {
		this.mail_rec = mail_rec;
	}
	public int getRoutine() {
		return routine;
	}
	public void setRoution(int routine) {
		this.routine = routine;
	}
	public int getMoney() {
		return money;
	}
	public void setMoney(int money) {
		this.money = money;
	}
	public String getBank() {
		return bank;
	}
	public void setBank(String bank) {
		this.bank = bank;
	}
	public String getAccount() {
		return account;
	}
	public void setAccount(String account) {
		this.account = account;
	}
	public String getBank_name() {
		return bank_name;
	}
	public void setBank_name(String bank_name) {
		this.bank_name = bank_name;
	}
}
