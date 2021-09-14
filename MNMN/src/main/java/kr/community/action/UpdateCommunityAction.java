package kr.community.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;

import kr.community.dao.CommunityDAO;
import kr.community.vo.CommunityVO;
import kr.controller.Action;
import kr.util.FileUtil;

public class UpdateCommunityAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		if(user_num == null) {
			//로그인 안된 경우
			return "redirect:/member/loginForm.do";
		}
		
		MultipartRequest multi = FileUtil.createFile(request);
		int com_num = Integer.parseInt(multi.getParameter("com_num"));
		
		CommunityVO com = new CommunityVO();
		com.setCom_num(com_num);
		com.setCom_member_num(user_num);
		com.setCom_title(multi.getParameter("com_title"));
		com.setCom_content(multi.getParameter("com_content"));
		
		CommunityDAO dao =CommunityDAO.getInstance();
		dao.updateCommunity(com);
		

		return "/WEB-INF/views/community/updateCommunity.jsp";
	}
}
