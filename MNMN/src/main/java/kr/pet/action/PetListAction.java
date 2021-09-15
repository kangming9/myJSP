package kr.pet.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.controller.Action;
import kr.pet.dao.PetDAO;
import kr.pet.vo.PetVO;
import kr.util.PagingUtil;

public class PetListAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		//로그인에 관계없이 확인 가능
		
		String pageNum = request.getParameter("pageNum");
		if(pageNum==null)pageNum = "1";
		
		String keyfield = request.getParameter("keyfield");
		String keyword = request.getParameter("keyword");
		
		if(keyfield == null) keyfield = "";
		if(keyword == null) keyword = "";
		
		PetDAO dao = PetDAO.getInstance();
		int count = dao.getPetCount();
		
		//페이징 처리
		PagingUtil page = new PagingUtil(keyfield, keyword, Integer.parseInt(pageNum),count,12,12,"petList.do");
		
		List<PetVO> list = null;
		if(count > 0) {
			list = dao.getListPet(page.getStartCount(), page.getEndCount(), keyfield, keyword);
		}
	    
	    request.setAttribute("count", count);
		request.setAttribute("list", list);
		request.setAttribute("pagingHtml", page.getPagingHtml());
		
		return "/WEB-INF/views/adopt/petList.jsp";
	}

}
