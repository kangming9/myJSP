package kr.pet.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.controller.Action;
import kr.pet.dao.PetDAO;

public class DeletePetDetailAction implements Action{
	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		Integer pet_num = Integer.parseInt(request.getParameter("pet_num"));
		
		PetDAO dao = PetDAO.getInstance();
		dao.deletePetdetail(pet_num);
		
		
		return "/WEB-INF/views/adopt/deletePetDetail.jsp";
	}
}
