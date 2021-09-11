package kr.adoptAfter.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;

import kr.adoptAfter.vo.AdoptAfterVO;
import kr.adotpAter.dao.AdoptAfterDAO;
import kr.controller.Action;
import kr.util.FileUtil;

public class ModifyAfterDetailAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		
		if(user_num == null) {
			return "redirect:/adoptAfter/list.do";
		}
		
		MultipartRequest multi = FileUtil.createFile(request);
		AdoptAfterVO adoptAfter = new AdoptAfterVO();
		adoptAfter.setAfter_num(Integer.parseInt(multi.getParameter("after_num")));
		adoptAfter.setAfter_title(multi.getParameter("after_title"));
		adoptAfter.setAfter_content(multi.getParameter("after_content"));
		adoptAfter.setAfter_photo(multi.getFilesystemName("after_photo"));
		adoptAfter.setAfter_member_num(user_num);
		AdoptAfterDAO dao = AdoptAfterDAO.getInstance();
		dao.updateAfterBoard(adoptAfter);
		
		return "/WEB-INF/views/adoptAfter/modifyAfterDetail.jsp";
	}

}
