package kr.community.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;

import kr.community.dao.CommunityDAO;
import kr.community.vo.CommunityVO;
import kr.controller.Action;
import kr.util.FileUtil;
  
public class WriteCommunityAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		request.setCharacterEncoding("utf-8");
		
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		if(user_num == null) {//로그인 되지 않은 경우
			return "redirect:/member/loginForm.do";
		}
		
		//로그인 된 경우 수정해야 함
		MultipartRequest multi = FileUtil.createFile(request); CommunityVO com = new CommunityVO(); 
		com.setCom_title(multi.getParameter("com_title"));
		com.setCom_member_num(user_num);
		com.setCom_content(multi.getParameter("com_content"));
		
		CommunityDAO dao = CommunityDAO.getInstance(); 
		dao.insertCommunity(com);

		
		return "/WEB-INF/views/community/writeCommunity.jsp";
	}

}
