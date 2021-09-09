package kr.pet.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.controller.Action;
import kr.pet.dao.PetDAO;
import kr.pet.vo.PetVO;

public class PetDetailAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		int pet_num = Integer.parseInt(request.getParameter("pet_num"));
		
		PetDAO dao = PetDAO.getInstance();
		
		PetVO pet = dao.getPet(pet_num);
		
		request.setAttribute("pet", pet);
		
		return "/WEB-INF/views/adopt/petDetail.jsp";
	}

}
