package kr.adotpAter.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import kr.adoptAfter.vo.AdoptAfterVO;
import kr.util.DBUtil;

public class AdoptAfterDAO {

	private static AdoptAfterDAO instance = new AdoptAfterDAO();
	
	public static AdoptAfterDAO getInstance() {
		return instance;
	}
	
	private AdoptAfterDAO() {}
	
	//글 등록
	public void insertAdoptAfter(AdoptAfterVO adoptAfter)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		PreparedStatement pstmt2 = null;
		ResultSet rs = null;
		String sql = null;
		int afterPetNum = 1;
		
		try {
			conn = DBUtil.getConnection();
			conn.setAutoCommit(false);
			
			//펫넘 구하기
			sql = "select adopt_pet_num from adopt where adopt_member_num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, adoptAfter.getAfter_member_num());
			rs = pstmt.executeQuery();
			if(rs.next()) {
				afterPetNum = rs.getInt(1);
			}
			
			//글 등록하기
			sql = "insert into adopt_after(after_num, after_pet_num, after_title, after_content, after_member_num, after_photo)"
				+ "values(adopt_after_seq.nextval,?,?,?,?,?)";
			pstmt2 = conn.prepareStatement(sql);
			pstmt2.setInt(1, afterPetNum);
			pstmt2.setString(2, adoptAfter.getAfter_title());
			pstmt2.setString(3, adoptAfter.getAfter_content());
			pstmt2.setInt(4, adoptAfter.getAfter_member_num());
			pstmt2.setString(5, adoptAfter.getAfter_photo());
			pstmt2.executeUpdate();
			
			conn.commit();
		}catch(Exception e) {
			conn.rollback();
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt2, null);
			DBUtil.executeClose(rs, pstmt, conn);
		}
		
	}
	//총 레코드 수
	//테스트다3
	//글 목록
	//글 상세
	//글 수정
	//글 삭제
}
