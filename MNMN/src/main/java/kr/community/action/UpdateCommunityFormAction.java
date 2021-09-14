package kr.community.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.community.dao.CommunityDAO;
import kr.community.vo.CommunityVO;
import kr.controller.Action;

public class UpdateCommunityFormAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		if(user_num == null) {
			//로그인 안된 경우
			return "redirect:/member/loginForm.do";
		}
		
		int com_num = Integer.parseInt(request.getParameter("com_num"));
		
		CommunityDAO dao = CommunityDAO.getInstance();
		CommunityVO com = dao.getCommunity(com_num);
		
		request.setAttribute("com", com);
		
		return "/WEB-INF/views/community/updateCommunityForm.jsp";
	}

}
