package kr.adopt.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.adopt.dao.AdoptDAO;
import kr.adopt.vo.AdoptVO;
import kr.controller.Action;
import kr.member.dao.MemberDAO;
import kr.member.vo.MemberVO;
import kr.pet.dao.PetDAO;
import kr.pet.vo.PetVO;

public class AdoptRegisterFormAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		//로그인 체크
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		if(user_num == null) {//로그인 되지 않은 경우
			return "redirect:/member/loginForm.do";
		}

		//자격 미달 체크
		AdoptDAO dao = AdoptDAO.getInstance();
		
		int count = dao.adoptCheck(user_num);
		
		//60 미만이면 alert해야 함 -> 수정 필요
		if(count*3 < 60) {
			return "redirect:/adopt/petList.do";
		}
		
		int pet_num = Integer.parseInt(request.getParameter("pet_num"));
		
		PetDAO pdao = PetDAO.getInstance();
		PetVO pet = pdao.getPet(pet_num);
		
		MemberDAO mdao = MemberDAO.getInstance();
		MemberVO member = mdao.getMember(user_num);
		
		
		AdoptVO adopt = new AdoptVO();
		adopt.setAdopt_member_num(user_num);
		adopt.setAdopt_pet_num(pet_num);
		adopt.setAdopt_pet_name(pet.getPet_name());
		adopt.setAdopt_member_id(member.getMember_id());
		adopt.setAdopt_member_name(member.getMember_detail_name());
		
		request.setAttribute("adopt", adopt);
		
		return "/WEB-INF/views/adopt/adoptRegisterForm.jsp";
	}

}
