package kr.adopt.action;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.codehaus.jackson.map.ObjectMapper;

import kr.adopt.dao.AdoptDAO;
import kr.adopt.vo.AdoptVO;
import kr.controller.Action;
import kr.member.dao.MemberDAO;
import kr.member.vo.MemberVO;

public class CheckDuplicatedAdoptAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		request.setCharacterEncoding("UTF-8");
		
		int user_num = Integer.parseInt(request.getParameter("user_num"));
		int pet_num = Integer.parseInt(request.getParameter("pet_num"));
		
		AdoptDAO dao = AdoptDAO.getInstance();
		AdoptVO adopt = dao.adoptCountCheck(user_num, pet_num);
		
		Map<String,String> mapAjax = new HashMap<String,String>();
		if(adopt == null) {//동일한 동물친구 입양한적 없음
			mapAjax.put("result", "NotDuplicated");
		}else {//입양 중복
			mapAjax.put("result", "Duplicated");
		}
		
		ObjectMapper mapper = new ObjectMapper();
		String ajaxData = mapper.writeValueAsString(mapAjax);
		
		request.setAttribute("ajaxData", ajaxData);
		
		return "/WEB-INF/views/common/ajax_view.jsp";
	}

}
