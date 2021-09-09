package kr.volunteer.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.controller.Action;
import kr.util.PagingUtil;
import kr.volunteer.dao.VolunteerDAO;
import kr.volunteer.vo.VolunteerVO;

public class ListVolunteerAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String pageNum = request.getParameter("pageNum");
		if(pageNum==null)pageNum = "1";
		
		VolunteerDAO dao = VolunteerDAO.getInstance();
		int count = dao.getVolunteerCount();
		
		//페이지 처리
		//currentPage, count, rowCount, pageCount, url
		PagingUtil page = new PagingUtil(Integer.parseInt(pageNum),count,20,10,"listVolunteer.do");
		
		List<VolunteerVO> list = null;
		if(count > 0) {
			list = dao.getListVolunteer(page.getStartCount(), page.getEndCount());
			
		}
		
		request.setAttribute("count", count);
		request.setAttribute("list", list);
		request.setAttribute("pagingHtml", page.getPagingHtml());
		
		return "/WEB-INF/views/volunteer/listVolunteer.jsp";
	}

}
