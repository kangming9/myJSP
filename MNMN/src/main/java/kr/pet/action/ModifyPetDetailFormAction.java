package kr.pet.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.pet.dao.PetDAO;
import kr.pet.vo.PetVO;

public class ModifyPetDetailFormAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		if(user_num == null) {
			//로그인 안된 경우
			return "redirect:/member/loginForm.do";
			
		}
		int pet_num = Integer.parseInt(request.getParameter("pet_num"));
		
		PetDAO dao = PetDAO.getInstance();
		PetVO pet = dao.getPet(pet_num);
		
		request.setAttribute("pet", pet);
		
		return "/WEB-INF/views/adopt/modifyPetDetailForm.jsp";
	}

}
