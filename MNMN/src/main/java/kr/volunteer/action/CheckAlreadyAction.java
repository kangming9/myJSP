package kr.volunteer.action;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.codehaus.jackson.map.ObjectMapper;

import kr.controller.Action;
import kr.volunteer.dao.VolunteerDAO;

public class CheckAlreadyAction implements Action{
	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		//전송된 데이터 인코딩 처리
		request.setCharacterEncoding("utf-8");
		
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		if(user_num == null) {//로그인 되지 않은 경우
			return "redirect:/member/loginForm.do";
		}
		
		VolunteerDAO dao = VolunteerDAO.getInstance();
		int Count = dao.checkAlready(user_num);
		
		
		Map<String,String> mapAjax = new HashMap<String,String>();
		
		if(Count > 0) {//이미 봉사 신청
			mapAjax.put("result", "Already");
		}else {//봉사 신청 전
			mapAjax.put("result", "Yet");
		}
		
		/*
		 * JSON형식으로 변환하기를 원하는 문자열을 HashMap에 key와 value의 쌍으로 저장한 후
		 * ObjectMapper의 writeValueAsString에 Map 객체를 전달해서 일반 문자열 데이터를
		 * JSON형식의 문자열 데이터로 변환 후 반환
		 */
		ObjectMapper mapper = new ObjectMapper();
		String ajaxData = mapper.writeValueAsString(mapAjax);
		
		request.setAttribute("ajaxData", ajaxData);
		
		return "/WEB-INF/views/common/ajax_view.jsp";
	}
}
