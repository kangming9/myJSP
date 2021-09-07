package kr.member.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.member.dao.MemberDAO;
import kr.member.vo.MemberVO;

public class LoginAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		request.setCharacterEncoding("UTF-8");
		
		String id = request.getParameter("id");
		String userPasswd = request.getParameter("passwd");
		
		MemberDAO dao = MemberDAO.getInstance();
		MemberVO member = dao.checkMember(id);
		boolean check = false;
		
		if(member!=null) {
			check = member.isCheckedPassword(userPasswd);
		}
		
		if(check) { //인증 성공
			HttpSession session = request.getSession();
			session.setAttribute("user_num", member.getMember_num());
			session.setAttribute("user_id", member.getMember_id());
			session.setAttribute("user_grade", member.getMember_grade());
			
			return "redirect:/main/main.do";
		}
		
		//인증 실패
		return "/WEB-INF/views/member/login.jsp";
	}

}
