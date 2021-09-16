package kr.donation.action;

import java.sql.Date;
import java.text.SimpleDateFormat;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.donation.vo.DonationVO;
import kr.donation.dao.DonationDAO;
import kr.controller.Action;


public class DonationDoAction implements Action{
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		request.setCharacterEncoding("UTF-8");

		DonationVO don = new DonationVO();
		
		don.setName(request.getParameter("name"));
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		java.util.Date d = sdf.parse(request.getParameter("birth"));
		don.setBirth(new Date(d.getTime()));
		
		don.setAddr(request.getParameter("addr"));
		
		don.setTel(request.getParameter("phone"));
		if("수신 동의".equals(request.getParameter("susin_m"))){
			don.setTel_rec(1);
		}else {
			don.setTel_rec(0);
		}
		
		don.setMail(request.getParameter("email"));
		if("수신 동의".equals(request.getParameter("susin_e"))) {
			don.setMail_rec(1);
		}else {
			don.setMail_rec(0);
		}
		
		if("정기 후원".equals(request.getParameter("division"))) {
			don.setRoution(1);
		}else {
			don.setRoution(0);
		};
		
		don.setMoney(Integer.parseInt(request.getParameter("money")));
		don.setBank(request.getParameter("bank"));
		don.setAccount(request.getParameter("account"));
		don.setBank_name(request.getParameter("acname"));
		
		
		DonationDAO dao = DonationDAO.getInstance(); 
		dao.insertDonation(don);
		
		return "/WEB-INF/views/donation/donationComplete.jsp";
	}

}
