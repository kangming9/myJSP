package kr.adopt.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import kr.adopt.vo.AdoptVO;
import kr.member.vo.MemberVO;
import kr.pet.vo.PetVO;
import kr.util.DBUtil;

public class AdoptDAO {
	private static AdoptDAO instance = new AdoptDAO();
		
		public static AdoptDAO getInstance() {
			return instance;
		}
		private AdoptDAO() {}
		
		//member의 입양 자격 확인
		public int adoptCheck(int mem_num)throws Exception{
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			int count = 0;
		
			try {
				conn = DBUtil.getConnection();
				sql = "select count(vol_checked) from volunteer v join member m on v.vol_member_num=m.member_num where vol_checked=1 and m.member_num=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, mem_num);
				
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					count = rs.getInt("count(vol_checked)");
				}
				
				
			}catch (Exception e) {
				throw new Exception(e);
			}finally {
				DBUtil.executeClose(null, pstmt, conn);
			}
			return count;
		}
		
		//입양 신청 등록
		public boolean insertAdoptRegister(AdoptVO adoptVO) throws Exception {
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			
			try {
				conn = DBUtil.getConnection();
				
				sql = "insert into adopt (adopt_num,adopt_member_num,adopt_pet_num,adopt_date,adopt_intro,adopt_married,adopt_house,adopt_now) values (adopt_seq.nextval,?,?,sysdate,?,?,?,0)";
				pstmt=conn.prepareStatement(sql);
				pstmt.setInt(1, adoptVO.getAdopt_member_num());
				pstmt.setInt(2, adoptVO.getAdopt_pet_num());
				pstmt.setString(3, adoptVO.getAdopt_intro());
				pstmt.setInt(4, adoptVO.getAdopt_married());
				pstmt.setString(5, adoptVO.getAdopt_house());

				pstmt.executeUpdate();
					
			
			}catch(Exception e) {
				throw new Exception(e);
			}finally {
				DBUtil.executeClose(rs, pstmt, conn);
			}

			return true;
		}	
		
		
		//신규 입양 신청 개수
		public int getAdoptCount() throws Exception {
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			int count = 0;
				
			try {
				conn = DBUtil.getConnection();
					
				sql = "SELECT COUNT(*) FROM adopt WHERE adopt_now=0";
					
				pstmt = conn.prepareStatement(sql);
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
			
		//신규 입양 신청 목록
		public List<AdoptVO> getListAdopt(int start, int end) throws Exception{
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			List<AdoptVO> list = null;
			String sql = null;
				
			try {
				conn = DBUtil.getConnection();
					
				sql = "SELECT * FROM (SELECT a.*, rownum rnum FROM "
					+ "(SELECT * FROM adopt t JOIN member m ON t.adopt_member_num = m.member_num JOIN pet p ON t.adopt_pet_num = p.pet_num "
					+ "WHERE t.adopt_now=0 ORDER BY t.adopt_num DESC)a) WHERE rnum >= ? AND rnum <= ?";
					
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, start);
				pstmt.setInt(2, end);
					
				rs = pstmt.executeQuery();
				list = new ArrayList<AdoptVO>();
				while(rs.next()) {
					AdoptVO adopt = new AdoptVO();
					adopt.setAdopt_num(rs.getInt("adopt_num"));
					adopt.setAdopt_member_num(rs.getInt("adopt_member_num"));
					adopt.setAdopt_pet_num(rs.getInt("adopt_pet_num"));
					adopt.setAdopt_date(rs.getDate("adopt_date"));					
					adopt.setAdopt_intro(rs.getString("adopt_intro"));
					adopt.setAdopt_married(rs.getInt("adopt_married"));
					adopt.setAdopt_house(rs.getString("adopt_house"));
					adopt.setAdopt_now(rs.getInt("adopt_now"));
					adopt.setAdopt_why(rs.getString("adopt_why"));
					adopt.setAdopt_member_id(rs.getString("member_id"));
					adopt.setAdopt_pet_name(rs.getString("pet_name"));
					
					list.add(adopt);
				}
					
			}catch(Exception e) {
				throw new Exception(e);
			}finally {
				DBUtil.executeClose(rs, pstmt, conn);
			}
			return list;
		}
		
		//입양신청서 상세
		public AdoptVO getAdopt(int adopt_num) throws Exception{
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			AdoptVO adopt = null;
			String sql = null;
			
			try {
				conn = DBUtil.getConnection();
				
				sql = "SELECT * FROM adopt a JOIN member m ON a.adopt_member_num=m.member_num JOIN pet p ON a.adopt_pet_num=p.pet_num WHERE a.adopt_num=?";

				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, adopt_num);
				
				rs = pstmt.executeQuery();
				if(rs.next()) {
					adopt = new AdoptVO();
					adopt.setAdopt_num(rs.getInt("adopt_num"));
					adopt.setAdopt_member_num(rs.getInt("adopt_member_num"));
					adopt.setAdopt_pet_num(rs.getInt("adopt_pet_num"));
					adopt.setAdopt_date(rs.getDate("adopt_date"));					
					adopt.setAdopt_intro(rs.getString("adopt_intro"));
					adopt.setAdopt_married(rs.getInt("adopt_married"));
					adopt.setAdopt_house(rs.getString("adopt_house"));
					adopt.setAdopt_now(rs.getInt("adopt_now"));
					adopt.setAdopt_why(rs.getString("adopt_why"));
					adopt.setAdopt_member_id(rs.getString("member_id"));
					adopt.setAdopt_pet_name(rs.getString("pet_name"));
				}
				
			}catch(Exception e) {
				throw new Exception(e);
			}finally {
				DBUtil.executeClose(rs, pstmt, conn);
			}
			
			return adopt;
		}
		
		//입양 신청 승인
		public boolean approveAdopt(int adopt_num, int pet_num, int member_num) throws Exception {
			Connection conn = null;
			PreparedStatement pstmt = null;
			PreparedStatement pstmt2 = null;
			PreparedStatement pstmt3 = null;
			String sql = null;
				
			try {
				conn = DBUtil.getConnection();
				conn.setAutoCommit(false);
					
				sql = "UPDATE adopt SET adopt_now=? WHERE adopt_num=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, 1);
				pstmt.setInt(2, adopt_num);
				pstmt.executeUpdate();
				
				sql = "UPDATE pet SET pet_adopt=? WHERE pet_num=?";
				pstmt2 = conn.prepareStatement(sql);
				pstmt2.setInt(1, 1);
				pstmt2.setInt(2, pet_num);
				pstmt2.executeUpdate();
				
				sql = "UPDATE member SET member_grade=? WHERE member_num=?";
				pstmt3 = conn.prepareStatement(sql);
				pstmt3.setInt(1, 2);
				pstmt3.setInt(2, member_num);
				pstmt3.executeUpdate();
				
				conn.commit();
			}catch(Exception e) {
				conn.rollback();
				throw new Exception(e);
			}finally {
				DBUtil.executeClose(null, pstmt, conn);
			}
			
			return true;
		}
		
		//입양 신청 반려
		public boolean rejectAdopt(int adopt_num, String adopt_why) throws Exception {
			Connection conn = null;
			PreparedStatement pstmt = null;
			String sql = null;
				
			try {
				conn = DBUtil.getConnection();
					
				sql = "UPDATE adopt SET adopt_now=?, adopt_why=? WHERE adopt_num=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, 2);
				pstmt.setString(2, adopt_why);
				pstmt.setInt(3, adopt_num);
				
				pstmt.executeUpdate();
				
			}catch(Exception e) {
				throw new Exception(e);
			}finally {
				DBUtil.executeClose(null, pstmt, conn);
			}
			
			return true;
		}
			
}
