package kr.pet.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import kr.member.vo.MemberVO;
import kr.pet.vo.PetVO;
import kr.util.DBUtil;

public class PetDAO {
	
	private static PetDAO instance = new PetDAO();
	
	public static PetDAO getInstance()throws Exception {
		return instance;
	}
	
	private PetDAO() {}

	//Æê µî·Ï
	//ÃÑ ·¹ÄÚµå ¼ö
	public int getPetCount() throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int count = 0;
	
		try {
			conn = DBUtil.getConnection();
			sql = "select count(*) from pet where pet_adopt=0";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				count = rs.getInt("count(*)");
			}
			
			
		}catch (Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt, conn);
		}
		
		return count;
	}

	
	//Æê ¸ñ·Ï
	public List<PetVO> getListPet(int start, int end)throws Exception {

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		List<PetVO> list = null;
		
		try {
			conn = DBUtil.getConnection();
			sql = "select * from (select a.*, rownum rnum from (select * from pet p where pet_adopt=0 order by p.pet_num desc)a) where rnum >= ? and rnum <=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			rs = pstmt.executeQuery();
			
			list = new ArrayList<PetVO>();
			
			while(rs.next()) {
				PetVO pet = new PetVO();
				pet.setPet_num(rs.getInt("pet_num"));
				pet.setPet_name(rs.getString("pet_name"));
				pet.setPet_type(rs.getString("pet_type"));
				pet.setPet_adopt(rs.getInt("pet_adopt"));
				pet.setPet_detail(rs.getString("pet_detail"));
				pet.setPet_date(rs.getDate("pet_date"));
				pet.setPet_photo(rs.getString("pet_photo"));
				
				list.add(pet);
				
			}
			
		}catch (Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt, conn);
		}
		
		return list;
	};


	
	
	//Æê »ó¼¼
	public PetVO getPet(int pet_num)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		PetVO pet = null;
		String sql = null;
		
		try {
			conn = DBUtil.getConnection();
			sql = "select * from pet where pet_adopt=0 and pet_num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, pet_num);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				pet = new PetVO();
				pet.setPet_num(rs.getInt("pet_num"));
				pet.setPet_name(rs.getString("pet_name"));
				pet.setPet_type(rs.getString("pet_type"));
				pet.setPet_adopt(rs.getInt("pet_adopt"));
				pet.setPet_detail(rs.getString("pet_detail"));
				pet.setPet_date(rs.getDate("pet_date"));
				pet.setPet_photo(rs.getString("pet_photo"));
			}
			
		}catch (Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt, conn);
		}
		
		return pet;
	};
	
	
};
	
