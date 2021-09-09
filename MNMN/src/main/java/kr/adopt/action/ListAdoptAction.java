package kr.adopt.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.adopt.dao.AdoptDAO;
import kr.adopt.vo.AdoptVO;
import kr.controller.Action;
import kr.util.PagingUtil;

public class ListAdoptAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String pageNum = request.getParameter("pageNum");
		if(pageNum==null)pageNum = "1";
		
		AdoptDAO dao = AdoptDAO.getInstance();
		int count = dao.getAdoptCount();
		
		//페이지 처리
		//currentPage, count, rowCount, pageCount, url
		PagingUtil page = new PagingUtil(Integer.parseInt(pageNum),count,20,10,"listAdopt.do");
		
		List<AdoptVO> list = null;
		if(count > 0) {
			list = dao.getListAdopt(page.getStartCount(), page.getEndCount());
			
		}
		
		request.setAttribute("count", count);
		request.setAttribute("list", list);
		request.setAttribute("pagingHtml", page.getPagingHtml());
		
		return "/WEB-INF/views/adopt/listAdopt.jsp";
	}

}
