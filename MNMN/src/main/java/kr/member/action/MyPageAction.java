package kr.member.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.community.vo.CommunityVO;
import kr.communityReply.vo.CommunityReplyVO;
import kr.controller.Action;
import kr.member.dao.MemberDAO;
import kr.member.vo.MemberVO;
import kr.util.PagingUtil;

public class MyPageAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		
		if(user_num == null) {//로그인 상태가 아닌 경우
			return "redirect:/member/loginForm.do";
		}
		
		MemberDAO dao = MemberDAO.getInstance();
		MemberVO member = dao.getMember(user_num);
		
		int member_volunteer = dao.getVolunteer(user_num)*3;
		member.setMember_volunteer(member_volunteer);
		
		int member_adopt = dao.getAdopt(user_num);
		member.setMember_adopt(member_adopt);
		
		//자신이 기재한 게시글
		String pageNum = request.getParameter("pageNum");
		if(pageNum==null)pageNum = "1";
				
		int count = dao.getMyContentCount(user_num);
				
		//페이지 처리
		PagingUtil page = new PagingUtil(Integer.parseInt(pageNum),count,10,10,"myPage.do");
						
		List<CommunityVO> list = null;
		if(count > 0) {
			list = dao.getMyContent(user_num, page.getStartCount(), page.getEndCount());
		}
		
		//자신이 기재한 댓글
		int replyCount = dao.getMyReplyCount(user_num);
		
		//댓글 페이징 처리
		PagingUtil replyPage = new PagingUtil(Integer.parseInt(pageNum),replyCount,10,10,"myPage.do");
		List<CommunityReplyVO> replyList = null;
		if(replyCount > 0) {
			replyList = dao.getMyReply(user_num, page.getStartCount(), page.getEndCount());
		}
				
		
		request.setAttribute("member", member);
		
		request.setAttribute("count", count);
		request.setAttribute("list", list);
		
		request.setAttribute("replyCount", replyCount);
		request.setAttribute("replyList", replyList);
		
		request.setAttribute("pagingHtml", page.getPagingHtml());
		request.setAttribute("replyPagingHtml", replyPage.getPagingHtml());
		
		return "/WEB-INF/views/member/myPage.jsp";
	}

}
