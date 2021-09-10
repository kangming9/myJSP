package kr.pet.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;

import kr.controller.Action;
import kr.pet.dao.PetDAO;
import kr.pet.vo.PetVO;
import kr.util.FileUtil;

public class RegisterPetAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
		Integer user_grade = (Integer)session.getAttribute("user_grade");
		
		if(user_grade == null) {//로그인 상태가 아닌 경우
			return "redirect:/member/loginForm.do";
		}
		
		request.setCharacterEncoding("UTF-8");

		MultipartRequest multi = FileUtil.createFile(request);
	
		PetVO pet = new PetVO();
		pet.setPet_name(multi.getParameter("name"));
		pet.setPet_type(multi.getParameter("type"));
		pet.setPet_detail(multi.getParameter("detail"));
		pet.setPet_photo(multi.getFilesystemName("photo"));
		
		PetDAO dao = PetDAO.getInstance();
		boolean check = false;
		
		//사용자가 관리자인지 확인
		if(user_grade == 1) {
			check = dao.insertPet(pet);
		}
		
		request.setAttribute("check", check);

		return "/WEB-INF/views/adopt/registerPet.jsp";
	}

}
