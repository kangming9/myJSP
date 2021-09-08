package kr.volunteer.action;

import java.sql.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;

import kr.controller.Action;
import kr.util.FileUtil;
import kr.volunteer.dao.VolunteerDAO;
import kr.volunteer.vo.VolunteerVO;

public class VolunteerUserAction implements Action{
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		if(user_num == null) {//로그인 되지 않은 경우
			return "redirect:/member/loginForm.do";
		}
		
		//로그인 된 경우
		VolunteerVO vol = new VolunteerVO();
		vol.setVol_m_num(user_num);
	
		MultipartRequest multi = FileUtil.createFile(request);
		
		vol.setVol_date(Date.valueOf(multi.getParameter("vol_date")));
		vol.setVol_time(Integer.parseInt(multi.getParameter("vol_time")));
		
		VolunteerDAO dao = VolunteerDAO.getInstance();
		dao.insertVolunteer(vol);
		
		return "/WEB-INF/views/volunteer/volunteerUser.jsp";
	}

}
