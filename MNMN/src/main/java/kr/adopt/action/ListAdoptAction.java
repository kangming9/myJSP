package kr.adopt.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.adopt.dao.AdoptDAO;
import kr.adopt.vo.AdoptVO;
import kr.controller.Action;
import kr.util.PagingUtil;

public class ListAdoptAction implements Action{

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
			
			AdoptDAO dao = AdoptDAO.getInstance();
			int count = dao.getAdoptCount(keyfield);
			
			PagingUtil page = new PagingUtil(keyfield, "", Integer.parseInt(pageNum),count,20,10,"listAdopt.do");
			
			List<AdoptVO> list = null;
			if(count > 0) {
				list = dao.getListAdopt(page.getStartCount(), page.getEndCount(), keyfield);
				
			}
			
			request.setAttribute("count", count);
			request.setAttribute("list", list);
			request.setAttribute("pagingHtml", page.getPagingHtml());
		}
		
		request.setAttribute("check", check);
		
		return "/WEB-INF/views/adopt/listAdopt.jsp";
	}

}
