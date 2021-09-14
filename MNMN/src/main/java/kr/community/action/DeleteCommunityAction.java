package kr.community.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.community.dao.CommunityDAO;
import kr.controller.Action;

public class DeleteCommunityAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		int com_num = Integer.parseInt(request.getParameter("com_num"));
		CommunityDAO dao = CommunityDAO.getInstance();
		dao.deleteCommunity(com_num);
		
		return "/WEB-INF/views/community/deleteCommunity.jsp";
	}
}
