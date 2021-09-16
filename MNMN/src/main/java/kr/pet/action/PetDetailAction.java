package kr.pet.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.member.dao.MemberDAO;
import kr.member.vo.MemberVO;
import kr.pet.dao.PetDAO;
import kr.pet.vo.PetVO;

public class PetDetailAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		int pet_num = Integer.parseInt(request.getParameter("pet_num"));
		
		//로그인 체크
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		if(user_num == null) {//로그인 되지 않은 경우
		return "redirect:/member/loginForm.do";
			}
		
		MemberDAO mdao = MemberDAO.getInstance();
		MemberVO member = mdao.getMember(user_num);
		int member_num = member.getMember_num();
		
		PetDAO dao = PetDAO.getInstance();
		
		PetVO pet = dao.getPet(pet_num);
		
		request.setAttribute("pet", pet);
		request.setAttribute("member_num", member_num);
		
		return "/WEB-INF/views/adopt/petDetail.jsp";
	}

}
