package kr.adoptAfter.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.adotpAter.dao.AdoptAfterDAO;
import kr.controller.Action;

public class AfterDeleteAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		
		int after_num = Integer.parseInt(request.getParameter("after_num"));
		
		if(user_num==null) {
			return "redirect:/adoptAfter/list.do";
		}
		
		AdoptAfterDAO dao = AdoptAfterDAO.getInstance();
		dao.deleteAfterBoard(after_num);
		
		return "/WEB-INF/views/adoptAfter/afterDelete.jsp";
	}

}
