package kr.communityReply.action;

import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.codehaus.jackson.map.ObjectMapper;

import kr.communityReply.dao.CommunityReplyDAO;
import kr.communityReply.vo.CommunityReplyVO;
import kr.controller.Action;
import kr.util.PagingUtil;

public class ListReplyAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		request.setCharacterEncoding("utf-8");
		
		String pageNum = request.getParameter("pageNum");
		
		if(pageNum==null) {
			pageNum = "1";
		}
		int com_num = Integer.parseInt(request.getParameter("com_num"));
		int rowCount = 10;
		
		CommunityReplyDAO dao = CommunityReplyDAO.getInstance();
		int count = dao.getReplyCount(com_num);
		
		PagingUtil page = new PagingUtil(Integer.parseInt(pageNum), count, rowCount, 1, null);
		
		List<CommunityReplyVO> list = null;
		if(count > 0) {
			list = dao.getListReply(page.getStartCount(), page.getEndCount(), com_num);
		}else {
			list = Collections.emptyList();
		}
		
		Map<String,Object> mapAjax = new HashMap<String,Object>();
		mapAjax.put("count", count);
		mapAjax.put("rowCount", rowCount);
		mapAjax.put("list", list);
		
		ObjectMapper mapper = new ObjectMapper();
		String ajaxData = mapper.writeValueAsString(mapAjax);
		
		request.setAttribute("ajaxData", ajaxData);
		
		return "/WEB-INF/views/common/ajax_view.jsp";
	}

}
