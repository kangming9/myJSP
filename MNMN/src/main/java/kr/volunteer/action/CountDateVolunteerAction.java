package kr.volunteer.action;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.codehaus.jackson.map.ObjectMapper;

import kr.controller.Action;
import kr.volunteer.dao.VolunteerDAO;

public class CountDateVolunteerAction implements Action{
	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		//전송된 데이터 인코딩 처리
		request.setCharacterEncoding("utf-8");
		
		String date = request.getParameter("date");
		
		VolunteerDAO dao = VolunteerDAO.getInstance();
		int volCount[] = dao.countDateVolunteer(date);
		String strcnt = "";
		
		for(int i = 0; i < volCount.length; i++) {
			strcnt += volCount[i];
		}
		
		Map<String,String> mapAjax = new HashMap<String,String>();
		
		if(strcnt == "")
			mapAjax.put("result", "0000000000");
		else
			mapAjax.put("result", strcnt);
		
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
