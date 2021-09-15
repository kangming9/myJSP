package kr.pet.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import kr.pet.vo.PetVO;
import kr.util.DBUtil;

public class PetDAO {
	
	private static PetDAO instance = new PetDAO();
	
	public static PetDAO getInstance()throws Exception {
		return instance;
	}
	
	private PetDAO() {}

	//펫 등록
	public boolean insertPet(PetVO pet) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		PreparedStatement pstmt2 = null;
		ResultSet rs = null;
		String sql = null;
		int num = 0; //시퀀스 번호 저장
	
		try {
			conn = DBUtil.getConnection();
			conn.setAutoCommit(false);
			
			//펫 번호 생성
			sql = "SELECT pet_seq.nextval FROM dual";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				num = rs.getInt(1);
			}
			
			//펫 정보 저장
			sql = "INSERT INTO pet (pet_num, pet_name, pet_type, pet_detail, pet_photo) VALUES (?,?,?,?,?)";
			pstmt2 = conn.prepareStatement(sql);
			pstmt2.setInt(1, num);
			pstmt2.setString(2, pet.getPet_name());
			pstmt2.setString(3, pet.getPet_type());
			pstmt2.setString(4, pet.getPet_detail());
			pstmt2.setString(5, pet.getPet_photo());
			pstmt2.executeUpdate();
			
			conn.commit();
		}catch(Exception e) {
			conn.rollback();
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
			DBUtil.executeClose(null, pstmt2, null);
		}	
		
		return true;

	}
	
	//총 레코드 수
	public int getPetCount(String keyfield, String keyword) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		String sub_sql = null;
		int count = 0;
	
		try {
			conn = DBUtil.getConnection();

			if(keyword == null || "".equals(keyword)) {
			sql = "select count(*) from pet where pet_adopt=0";
			pstmt = conn.prepareStatement(sql);
			}else {
				//검색글 갯수
				if(keyfield.equals("1")) sub_sql = "pet_name LIKE ?";
				else if(keyfield.equals("2")) sub_sql = "pet_type LIKE ?";
				sql = "select count(*) from pet where pet_adopt=0 and " + sub_sql;
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "%"+keyword+"%");
			
		}
			
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

	
	//펫 목록
	public List<PetVO> getListPet(int start, int end, String keyfield, String keyword)throws Exception {

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		List<PetVO> list = null;
		String sub_sql = null;
		
		try {
			conn = DBUtil.getConnection();
			if(keyword == null || "".equals(keyword)) {
			sql = "select * from (select a.*, rownum rnum from (select * from pet p where pet_adopt=0 order by p.pet_num desc)a) where rnum >= ? and rnum <=?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
		
			}else {
				
			if(keyfield.equals("1")) sub_sql = "p.pet_name LIKE ?";
			else if(keyfield.equals("2")) sub_sql = "p.pet_type LIKE ?";
			
			sql = "select * from (select a.*, rownum rnum from (select * from pet p where pet_adopt=0 and (" + sub_sql +") order by p.pet_num desc)a) where rnum >= ? and rnum <=?";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, "%"+keyword+"%");
			pstmt.setInt(2, start);
			pstmt.setInt(3, end);
			
			}
			
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
	}


	
	
	//펫 상세
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
	}
	
	//펫 사진 수정
	public void updatePetPhoto(String photo, int member_num) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		
		try {
			conn = DBUtil.getConnection();
			sql = "update pet set photo=? where mem_num=?";
			
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
	
	//펫 수정
	public void updatePetDetail(PetVO petVO) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		
		try {
			conn = DBUtil.getConnection();
			
			//date는 수정 x : pet_date는 입양공고에 등록한 날짜
			sql = "update pet set pet_name=?,pet_type=?,pet_detail=?,pet_photo=? where pet_num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, petVO.getPet_name());
			pstmt.setString(2, petVO.getPet_type());
			pstmt.setString(3, petVO.getPet_detail());
			pstmt.setString(4, petVO.getPet_photo());
			pstmt.setInt(5, petVO.getPet_num());
			
			pstmt.executeUpdate();
			
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt, conn);
		}
		
	}

	//펫 삭제
	public void deletePetdetail(int pet_num) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		
		try {
			conn = DBUtil.getConnection();
			sql = "delete from pet where pet_num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, pet_num);
			
			pstmt.executeUpdate();
			
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt, conn);
		}
		
	}


	
	
}
	
