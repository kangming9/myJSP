package kr.member.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.member.dao.MemberDAO;
import kr.member.vo.MemberVO;

public class DetailUserFormAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		if(user_num == null) {
			return "redirect:/member/loginForm.do";
		}
		
		Integer user_grade = (Integer)session.getAttribute("user_grade");
		boolean check = false;
		
		if(user_grade == 1) {
			check = true;
			
			int mem_num = Integer.parseInt(request.getParameter("mem_num"));
			
			MemberDAO dao = MemberDAO.getInstance();
			MemberVO member = dao.getMember(mem_num);
			
			request.setAttribute("member", member);
		}
		
		request.setAttribute("check", check);
		
		return "/WEB-INF/views/member/detailUserForm.jsp";
	}

}
