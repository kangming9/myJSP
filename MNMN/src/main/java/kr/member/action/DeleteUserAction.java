package kr.member.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.member.dao.MemberDAO;
import kr.member.vo.MemberVO;
import kr.util.FileUtil;

public class DeleteUserAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		
		if(user_num == null) {//로그인 상태가 아닌 경우
			return "redirect:/member/loginForm.do";
		}
		
		request.setCharacterEncoding("utf-8");
		
		String id = request.getParameter("id");
		String passwd = request.getParameter("passwd");
		//로그인한 아이디
		String user_id = (String)session.getAttribute("user_id");
		
		MemberDAO dao = MemberDAO.getInstance();
		MemberVO member = dao.checkMember(id);
		boolean check = false;
		
		//사용자 입력한 아이디가 존재 여부, 로그인한 아이디와 일치 여부 확인
		if(member!=null && id.equals(user_id)) {
			//비밀번호 일치 여부 확인
			check = member.isCheckedPassword(passwd);
		}
		
		if(check) {
			//회원정보 삭제
			dao.deleteMember(user_num);
			//프로필 사진 삭제
			FileUtil.removeFile(request, member.getMember_detail_photo());
			//로그아웃
			session.invalidate();
		}
		
		request.setAttribute("check", check);
		
		return "/WEB-INF/views/member/deleteUser.jsp";
	}

}
