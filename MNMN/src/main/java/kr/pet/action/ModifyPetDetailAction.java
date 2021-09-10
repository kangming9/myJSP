package kr.pet.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;

import kr.controller.Action;
import kr.pet.dao.PetDAO;
import kr.pet.vo.PetVO;
import kr.util.FileUtil;
public class ModifyPetDetailAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		if(user_num == null) {//로그인 되지 않은 경우
			return "redirect:/member/loginForm.do";
		}
		
		request.setCharacterEncoding("utf-8");
		
		MultipartRequest multi = FileUtil.createFile(request);
		PetVO petVO = new PetVO();
		
		petVO.setPet_num(Integer.parseInt(multi.getParameter("num")));
		petVO.setPet_name(multi.getParameter("name"));
		petVO.setPet_type(multi.getParameter("type"));
		petVO.setPet_detail(multi.getParameter("detail"));
		petVO.setPet_photo(multi.getFilesystemName("photoname"));
		
		PetDAO dao = PetDAO.getInstance();
		dao.updatePetDetail(petVO);
		
		PetVO pet = dao.getPet(petVO.getPet_num());
		
		request.setAttribute("pet", pet);

		
		return "/WEB-INF/views/adopt/modifyPetDetail.jsp";
	}

}
