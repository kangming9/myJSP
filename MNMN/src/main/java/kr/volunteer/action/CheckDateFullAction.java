package kr.volunteer.action;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.codehaus.jackson.map.ObjectMapper;

import kr.controller.Action;
import kr.volunteer.dao.VolunteerDAO;

import java.util.logging.Logger;

public class CheckDateFullAction implements Action{
	
	private final static Logger LOG = Logger.getGlobal();

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		//전송된 데이터 인코딩 처리
		request.setCharacterEncoding("utf-8");
		
		String date = request.getParameter("date");
		date = date.replace("-", "/");
		date = date.substring(2);
		
		int time = Integer.parseInt(request.getParameter("time"));
		
		VolunteerDAO dao = VolunteerDAO.getInstance();
		int volCount = dao.checkDateFull(date, time);
		
		
		LOG.info("봉사자수 : " + volCount);
		
		
		
		
		Map<String,String> mapAjax = new HashMap<String,String>();
		
		if(volCount < 5) {//봉사자 수 미초과
			mapAjax.put("result", "LessThan");
			LOG.info("봉사자 수 미초과");
		}else {//봉사자 수 초과
			mapAjax.put("result", "MoreThan");
			LOG.info("봉사자 수 초과");
		}
		
		/*
		 * JSON형식으로 변환하기를 원하는 문자열을 HashMap에 key와 value의 쌍으로 저장한 후
		 * ObjectMapper의 writeValueAsString에 Map 객체를 전달해서 일반 문자열 데이터를
		 * JSON형식의 문자열 데이터로 변환 후 반환
		 */
		ObjectMapper mapper = new ObjectMapper();
		String ajaxData = mapper.writeValueAsString(mapAjax);
		
		
		
		LOG.info(ajaxData);
		
		
		
		request.setAttribute("ajaxData", ajaxData);
		
		return "/WEB-INF/views/common/ajax_view.jsp";
	}
}
