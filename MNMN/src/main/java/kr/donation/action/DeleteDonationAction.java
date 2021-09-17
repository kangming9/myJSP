package kr.donation.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


import kr.controller.Action;
import kr.donation.dao.DonationDAO;

public class DeleteDonationAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		//傈价等 单捞磐 牢内爹 贸府
		request.setCharacterEncoding("utf-8");
		
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		if(user_num == null) {
			return "redirect:/member/loginForm.do";
		}
		
		Integer user_grade = (Integer)session.getAttribute("user_grade");
		
		if(user_grade == 1) {
			
			int num = Integer.parseInt(request.getParameter("dnum"));
			
			DonationDAO dao = DonationDAO.getInstance();
			String comp = dao.DeleteDonation(num);

		}
		
		return "/WEB-INF/views/donation/listDonation.jsp";
	}

}
