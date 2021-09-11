package kr.adoptAfter.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.adoptAfter.vo.AdoptAfterVO;
import kr.adotpAter.dao.AdoptAfterDAO;
import kr.controller.Action;

public class ModifyAfterDetailFormAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		
		if(user_num==null) {
			return "redirect:/adoptAfter/list.do";
		}
		
		int after_num = Integer.parseInt(request.getParameter("after_num"));
		
		AdoptAfterDAO dao = AdoptAfterDAO.getInstance();
		AdoptAfterVO after = dao.getAfterBoard(after_num);
		
		request.setAttribute("after", after);
		
		return "/WEB-INF/views/adoptAfter/modifyAfterDetailForm.jsp";
	}

}
