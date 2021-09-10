package kr.adopt.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.adopt.dao.AdoptDAO;
import kr.adopt.vo.AdoptVO;
import kr.controller.Action;

public class DetailAdoptAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		int adopt_num = Integer.parseInt(request.getParameter("adopt_num"));
				
		AdoptDAO dao = AdoptDAO.getInstance();
		AdoptVO adopt = dao.getAdopt(adopt_num);
				
		request.setAttribute("adopt", adopt);
				
		return "/WEB-INF/views/adopt/detailAdopt.jsp";
	}

}
