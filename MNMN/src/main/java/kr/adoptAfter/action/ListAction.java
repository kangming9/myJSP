package kr.adoptAfter.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.adoptAfter.vo.AdoptAfterVO;
import kr.adotpAter.dao.AdoptAfterDAO;
import kr.controller.Action;
import kr.util.PagingUtil;

public class ListAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String pageNum = request.getParameter("pageNum");
		if(pageNum==null) pageNum = "1";
		
		AdoptAfterDAO dao = AdoptAfterDAO.getInstance();
		int count = dao.getAfterBoardCount(); //게시판 총 레코드 수
		
		PagingUtil page = new PagingUtil(Integer.parseInt(pageNum), count, 6, 5, "list.do");
		
		List<AdoptAfterVO> list = null;
		if(count > 0) {
			list = dao.getAfterListBoard(page.getStartCount(), page.getEndCount());
		}
		
		request.setAttribute("count", count);
		request.setAttribute("list", list);
		request.setAttribute("pagingHtml", page.getPagingHtml());
		
		return "/WEB-INF/views/adoptAfter/list.jsp";
	}

}
