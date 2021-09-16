package kr.member.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import kr.community.vo.CommunityVO;
import kr.communityReply.vo.CommunityReplyVO;
import kr.member.vo.MemberVO;
import kr.util.DBUtil;

public class MemberDAO {
	//싱글턴 패턴
	private static MemberDAO instance = new MemberDAO();
	
	public static MemberDAO getInstance() {
		return instance;
	}
	private MemberDAO() {}
	
	//ID 중복 체크 및 로그인
	public MemberVO checkMember(String id) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		MemberVO member = null;
		String sql = null;
		
		try {
			conn = DBUtil.getConnection();

			sql = "SELECT * FROM member m LEFT OUTER JOIN member_detail d "
				+ "ON m.member_num = d.member_detail_num WHERE m.member_id=?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				member = new MemberVO();
				member.setMember_num(rs.getInt("member_num"));
				member.setMember_id(rs.getString("member_id"));
				member.setMember_grade(rs.getInt("member_grade"));
				member.setMember_detail_pw(rs.getString("member_detail_pw"));
				member.setMember_detail_photo(rs.getString("member_detail_photo"));
			}
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		return member;
	}
	
	//회원가입
	public void insertMember(MemberVO member) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		PreparedStatement pstmt2 = null;			
		PreparedStatement pstmt3 = null;
		ResultSet rs = null;
		String sql = null;
		int num = 0; //시퀀스 번호 저장
	
		try {
			conn = DBUtil.getConnection();
			conn.setAutoCommit(false);
			
			//회원 번호 생성
			sql = "SELECT member_seq.nextval FROM dual";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				num = rs.getInt(1);
			}
			
			//회원 정보 저장
			sql = "INSERT INTO member (member_num, member_id) VALUES (?,?)";
			pstmt2 = conn.prepareStatement(sql);
			pstmt2.setInt(1, num);
			pstmt2.setString(2, member.getMember_id());
			pstmt2.executeUpdate();
			
			//회원 정보 저장2
			sql = "INSERT INTO member_detail (member_detail_num, member_detail_pw, member_detail_name, member_detail_phone) VALUES (?,?,?,?)";
			pstmt3 = conn.prepareStatement(sql);
			pstmt3.setInt(1, num);
			pstmt3.setString(2, member.getMember_detail_pw());
			pstmt3.setString(3, member.getMember_detail_name());
			pstmt3.setString(4, member.getMember_detail_phone());
			pstmt3.executeUpdate();
			
			conn.commit();
		}catch(Exception e) {
			conn.rollback();
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
			DBUtil.executeClose(null, pstmt3, null);
			DBUtil.executeClose(null, pstmt2, null);
		}
	}
	
	//회원 상세 정보
	public MemberVO getMember(int member_num)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		MemberVO member = null;
		String sql = null;
		
		try {
			conn = DBUtil.getConnection();
			
			sql = "SELECT * FROM member m JOIN member_detail d ON m.member_num=d.member_detail_num WHERE m.member_num=?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, member_num);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				member = new MemberVO();
				member.setMember_num(rs.getInt("member_num"));
				member.setMember_id(rs.getString("member_id"));
				member.setMember_grade(rs.getInt("member_grade"));
				member.setMember_detail_pw(rs.getString("member_detail_pw"));
				member.setMember_detail_name(rs.getString("member_detail_name"));
				member.setMember_detail_phone(rs.getString("member_detail_phone"));
				member.setMember_detail_photo(rs.getString("member_detail_photo"));
				member.setMember_detail_reg_date(rs.getDate("member_detail_reg_date"));//가입일
				member.setMember_detail_new_date(rs.getDate("member_detail_new_date"));//수정일
			}
			
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		return member;
	}
	
	//회원 봉사 시간
	public int getVolunteer(int member_num) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int count = 0;
		
		try {
			conn = DBUtil.getConnection();
			
			sql = "SELECT COUNT(*) FROM volunteer v, member m where v.vol_member_num = m.member_num and v.vol_checked=1 "
					+ "and m.member_num=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, member_num);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				count = rs.getInt(1);
			}
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		return count;
	}
	
	//회원 입양 회수
	public int getAdopt(int member_num) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int count = 0;
		
		try {
			conn = DBUtil.getConnection();
			
			sql = "SELECT COUNT(*) FROM adopt a, member m where a.adopt_member_num = m.member_num and a.adopt_now=1 "
					+ "and m.member_num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, member_num);
				
			rs = pstmt.executeQuery();
			if(rs.next()) {
				count = rs.getInt(1);
			}
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		return count;
	}
	
	//프로필 사진 수정
	public void updateMyPhoto(String photo, int member_num) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		
		try {
			conn = DBUtil.getConnection();
			
			sql = "UPDATE member_detail SET member_detail_photo=? WHERE member_detail_num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, photo);
			pstmt.setInt(2, member_num);
			
			pstmt.executeUpdate();
			
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt, conn);
		}
		
	}
	
	//회원 정보 수정
	public MemberVO updateMember(MemberVO member) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		
		try {
			conn = DBUtil.getConnection();
			
			sql = "UPDATE member_detail SET member_detail_phone=?, member_detail_new_date=SYSDATE WHERE member_detail_num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, member.getMember_detail_phone());
			pstmt.setInt(2, member.getMember_num());
			
			pstmt.executeUpdate();
			
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt, conn);
		}
		return null;
	}
	
	//비밀번호 수정
	public MemberVO updatePassword(String member_detail_pw, int member_num) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
			
		try {
			conn = DBUtil.getConnection();
				
			sql = "UPDATE member_detail SET member_detail_pw=?, member_detail_new_date=SYSDATE WHERE member_detail_num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, member_detail_pw);
			pstmt.setInt(2, member_num);
			
			pstmt.executeUpdate();
			
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt, conn);
		}
		return null;
	}
	
	//회원 탈퇴
	public void deleteMember(int member_num)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		PreparedStatement pstmt2 = null;
		String sql = null;
		
		try {
			conn = DBUtil.getConnection();
			conn.setAutoCommit(false);
			
			sql = "Update member SET member_grade=0 WHERE member_num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, member_num);
			pstmt.executeUpdate();
			
			sql = "DELETE FROM member_detail WHERE member_detail_num=?";
			pstmt2 = conn.prepareStatement(sql);
			pstmt2.setInt(1, member_num);
			pstmt2.executeUpdate();
			
			conn.commit();
		}catch(Exception e) {
			conn.rollback();
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt2, null);
			DBUtil.executeClose(null, pstmt, conn);
		}
	}
	
	public int getMemberCountByAdmin(String keyfield, String keyword) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		String sub_sql = null;
		int count = 0;
		
		try {
			conn = DBUtil.getConnection();
			
			if(keyword == null || "".equals(keyword)) {
				//전체글 갯수
				sql = "SELECT COUNT(*) FROM member m LEFT OUTER JOIN member_detail d ON m.member_num=d.member_detail_num";
				pstmt = conn.prepareStatement(sql);
			}else {
				//검색글 갯수
				if(keyfield.equals("1")) sub_sql = "member_id LIKE ?";
				else if(keyfield.equals("2")) sub_sql = "member_detail_name LIKE ?";
				
				sql = "SELECT COUNT(*) FROM member m LEFT OUTER JOIN "
					+ "member_detail d ON m.member_num=d.member_detail_num WHERE " + sub_sql;
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, "%"+keyword+"%");
			}
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				count = rs.getInt(1);
			}
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		return count;
	}
	
	//목록,검색 글 목록
	public List<MemberVO> getListMemberByAdmin(int start, int end, String keyfield, String keyword) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<MemberVO> list = null;
		String sql = null;
		String sub_sql = null;
		
		try {
			conn = DBUtil.getConnection();
			if(keyword == null || "".equals(keyword)) {
				//전체글 보기
				sql = "SELECT * FROM (SELECT a.*, rownum rnum FROM "
					+ "(SELECT * FROM member m LEFT OUTER JOIN member_detail d "
					+ "ON m.member_num=d.member_detail_num ORDER BY member_detail_reg_date DESC NULLS LAST)a) "
					+ "WHERE rnum >= ? AND rnum <= ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, start);
				pstmt.setInt(2, end);
			}else {
				//검색글 보기
				if(keyfield.equals("1")) sub_sql = "member_id LIKE ?";
				else if(keyfield.equals("2")) sub_sql = "member_detail_name LIKE ?";
				
				sql = "SELECT * FROM (SELECT a.*, rownum rnum FROM "
					+ "(SELECT * FROM member m LEFT OUTER JOIN member_detail d "
					+ "ON m.member_num=d.member_detail_num WHERE " + sub_sql 
					+ " ORDER BY member_detail_reg_date DESC NULLS LAST)a) "
					+ "WHERE rnum >= ? AND rnum <= ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, "%"+keyword+"%");
				pstmt.setInt(2, start);
				pstmt.setInt(3, end);
			}
			
			rs = pstmt.executeQuery();
			
			list = new ArrayList<MemberVO>();
			while(rs.next()) {
				MemberVO member = new MemberVO();
				member.setMember_num(rs.getInt("member_num"));
				member.setMember_id(rs.getString("member_id"));
				member.setMember_grade(rs.getInt("member_grade"));
				member.setMember_detail_pw(rs.getString("member_detail_pw"));
				member.setMember_detail_name(rs.getString("member_detail_name"));
				member.setMember_detail_phone(rs.getString("member_detail_phone"));
				member.setMember_detail_reg_date(rs.getDate("member_detail_reg_date"));
				member.setMember_detail_new_date(rs.getDate("member_detail_new_date"));
				
				list.add(member);
			}
			
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		return list;
	}
	
	//회원정보 수정
	public void updateMemberByAdmin(MemberVO member) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		PreparedStatement pstmt2 = null;
		String sql = null;
		
		try {
			conn = DBUtil.getConnection();
			conn.setAutoCommit(false);
			
			System.out.println(member.getMember_num());
			
			sql = "UPDATE member SET member_grade=? WHERE member_num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, member.getMember_grade());
			pstmt.setInt(2, member.getMember_num());
			pstmt.executeUpdate();
			
			sql = "UPDATE member_detail SET member_detail_name=?, member_detail_phone=?, member_detail_new_date=SYSDATE WHERE member_detail_num=?";
			pstmt2 = conn.prepareStatement(sql);
			pstmt2.setString(1, member.getMember_detail_name());
			pstmt2.setString(2, member.getMember_detail_phone());
			pstmt2.setInt(3, member.getMember_num());
			pstmt2.executeUpdate();
			
			conn.commit();
		}catch(Exception e) {
			conn.rollback();
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt, conn);
			DBUtil.executeClose(null, pstmt2, null);
		}
	}
	
	
	//내가 쓴 글 카운트
	public int getMyContentCount(int member_num)throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int count = 0;
		
		try {
			conn = DBUtil.getConnection();
			sql = "select count(*) from community c join member m on c.com_member_num=m.member_num where m.member_num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, member_num);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				count = rs.getInt(1);
			}
			
		}catch (Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt, conn);
		}
		
		return count;
		
	}
	
	//내가 쓴 글 목록
	public List<CommunityVO> getMyContent(int member_num, int start, int end)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs =null;
		List<CommunityVO> list = null;
		String sql = null;
		
		try {
			conn = DBUtil.getConnection();
			sql = "select * from (select a.*, rownum rnum from (select * from community c join member m on c.com_member_num=m.member_num where m.member_num=? order by c.com_num desc)a) where rnum >= ? and rnum <=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, member_num);
			pstmt.setInt(2, start);
			pstmt.setInt(3, end);
			
			rs = pstmt.executeQuery();
			
			list = new ArrayList<CommunityVO>();
			while(rs.next()) {
				CommunityVO com = new CommunityVO();
				com.setCom_num(rs.getInt("com_num"));
				com.setCom_title(rs.getString("com_title"));
				com.setCom_content(rs.getString("com_content"));
				com.setCom_date(rs.getDate("com_date"));
				
				list.add(com);
			}
			
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt, conn);
		}
		
		return list;
	}
	
	//내가 쓴 댓글 카운트
	public int getMyReplyCount(int member_num)throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int count = 0;
		
		try {
			conn = DBUtil.getConnection();
			sql = "select count(*) from community_reply r join member m on r.member_num=m.member_num where m.member_num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, member_num);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				count = rs.getInt(1);
			}
			
		}catch (Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt, conn);
		}
		
		return count;
		
	}
	
	//내가 쓴 댓글 목록
	public List<CommunityReplyVO> getMyReply(int member_num, int start, int end)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs =null;
		List<CommunityReplyVO> list = null;
		String sql = null;
		
		try {
			conn = DBUtil.getConnection();
			sql = "select * from (select a.*, rownum rnum from (select * from community_reply r join member m on r.member_num=m.member_num where m.member_num=? order by r.re_num desc)a) where rnum >= ? and rnum <=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, member_num);
			pstmt.setInt(2, start);
			pstmt.setInt(3, end);
			
			rs = pstmt.executeQuery();
			
			list = new ArrayList<CommunityReplyVO>();
			while(rs.next()) {
				CommunityReplyVO reply = new CommunityReplyVO();
				reply.setRe_num(rs.getInt("re_num"));
				reply.setRe_content(rs.getString("re_content"));
				reply.setRe_date(rs.getDate("re_date"));
				reply.setCom_num(rs.getInt("com_num"));
				
				list.add(reply);
			}
			
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt, conn);
		}
		
		return list;
	}
	
}











