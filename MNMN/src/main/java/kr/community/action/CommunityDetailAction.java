package kr.community.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.community.dao.CommunityDAO;
import kr.community.vo.CommunityVO;
import kr.communityReply.dao.CommunityReplyDAO;
import kr.controller.Action;
import kr.member.dao.MemberDAO;
import kr.member.vo.MemberVO;

public class CommunityDetailAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// 로그인 안하면 목록까지밖에 못 봄
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		if(user_num == null) {//로그인 되지 않은 경우
			return "redirect:/member/loginForm.do";
		}
		
		int com_num = Integer.parseInt(request.getParameter("com_num"));
		
		CommunityDAO dao = CommunityDAO.getInstance();
		//조회수 증가
		dao.updateReadcount(com_num);
		
		CommunityVO com = dao.getCommunity(com_num);
		
		MemberDAO mdao = MemberDAO.getInstance();
		MemberVO member = mdao.getMember(user_num);
		
		com.setCom_member_id(member.getMember_id());
		com.setCom_title(com.getCom_title());
		com.setCom_content(com.getCom_content());
		
		request.setAttribute("com", com);
		
		//skr
		CommunityReplyDAO dao2 = CommunityReplyDAO.getInstance();
		int Rcount = dao2.getReplyCount(com_num);
		request.setAttribute("Rcount", Rcount);
		System.out.println(Rcount);
		
		return "/WEB-INF/views/community/communityDetail.jsp";
	}

}
