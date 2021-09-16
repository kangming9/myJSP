package kr.volunteer.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.util.PagingUtil;
import kr.volunteer.dao.VolunteerDAO;
import kr.volunteer.vo.VolunteerVO;

public class ListVolunteerAction implements Action{

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
			
			VolunteerDAO dao = VolunteerDAO.getInstance();
			int count = dao.getVolunteerCount(keyfield);
			
			PagingUtil page = new PagingUtil(keyfield, "", Integer.parseInt(pageNum),count,15,10,"listVolunteer.do");
			
			List<VolunteerVO> list = null;
			if(count > 0) {
				list = dao.getListVolunteer(page.getStartCount(), page.getEndCount(), keyfield);
				
			}
			
			request.setAttribute("count", count);
			request.setAttribute("list", list);
			request.setAttribute("pagingHtml", page.getPagingHtml());
			
		}
		
		request.setAttribute("check", check);
		
		return "/WEB-INF/views/volunteer/listVolunteer.jsp";
	}

}
