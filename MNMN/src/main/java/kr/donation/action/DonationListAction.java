package kr.donation.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.util.PagingUtil;
import kr.donation.dao.DonationDAO;
import kr.donation.vo.DonationVO;

public class DonationListAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		if(user_num == null) {
			return "redirect:/member/loginForm.do";
		}
		
		Integer user_grade = (Integer)session.getAttribute("user_grade");
		boolean check= false;
		
		if(user_grade == 1) {
			check = true;
			
			String pageNum = request.getParameter("pageNum");
			if(pageNum==null)pageNum = "1";

			String keyfield = request.getParameter("keyfield");
			if(keyfield == null) keyfield = "";
			
			int key = 0;
			if("1".equals(keyfield)) key = 1;
			else if("0".equals(keyfield)) key = 0;
			else key = 2;
			
			DonationDAO dao = DonationDAO.getInstance();
			int count = dao.getDonationCount();
			
			PagingUtil page = new PagingUtil(keyfield, "",Integer.parseInt(pageNum),count,15,10,"listDonation.do");
			
			List<DonationVO> list = null;
			if(count > 0) {
				list = dao.getListDonation(page.getStartCount(), page.getEndCount(), key);
				
			}
			
			request.setAttribute("count", count);
			request.setAttribute("list", list);
			request.setAttribute("pagingHtml", page.getPagingHtml());
			
		}
		
		request.setAttribute("check", check);
		
		return "/WEB-INF/views/donation/listDonation.jsp";
	}

}
