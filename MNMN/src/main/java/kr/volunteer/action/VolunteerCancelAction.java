package kr.volunteer.action;

import java.sql.Date;
import java.text.SimpleDateFormat;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.volunteer.dao.VolunteerDAO;
import kr.volunteer.vo.VolunteerVO;


import java.util.logging.Logger;

public class VolunteerCancelAction implements Action{

	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		if(user_num == null) {//로그인 되지 않은 경우
			return "redirect:/member/loginForm.do";
		}
		
		//로그인 된 경우
		VolunteerVO vol = new VolunteerVO();
		
		vol.setVol_m_num(user_num);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		java.util.Date d = sdf.parse(request.getParameter("canceldate"));
		
		vol.setVol_date(new Date(d.getTime()));
		vol.setVol_time(Integer.parseInt(request.getParameter("canceltime")));
		VolunteerDAO dao = VolunteerDAO.getInstance(); 
		dao.deleteVolunteer(vol);
		
		return "/WEB-INF/views/volunteer/VolunteerCancel.jsp";
	}
}
