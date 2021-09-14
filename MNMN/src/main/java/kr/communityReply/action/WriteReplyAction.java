package kr.communityReply.action;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.codehaus.jackson.map.ObjectMapper;

import kr.communityReply.dao.CommunityReplyDAO;
import kr.communityReply.vo.CommunityReplyVO;
import kr.controller.Action;

public class WriteReplyAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		//로그인 확인
		Map<String,String> mapAjax = new HashMap<String,String>();
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		if(user_num==null) {// 로그인 안한 상태
			mapAjax.put("result", "logout");
		}else {//로그인 상태
			CommunityReplyVO reply = new CommunityReplyVO();
			reply.setRe_content(request.getParameter("re_content"));
			reply.setCom_num(Integer.parseInt(request.getParameter("com_num")));
			reply.setMember_num(user_num);
			
			CommunityReplyDAO dao = CommunityReplyDAO.getInstance();
			dao.insertReply(reply);
			
			mapAjax.put("result", "success");
		}
		
		ObjectMapper mapper = new ObjectMapper();
		String ajaxData = mapper.writeValueAsString(mapAjax);
		
		request.setAttribute("ajaxData", ajaxData);
		
		return "/WEB-INF/views/common/ajax_view.jsp";
	}

}
