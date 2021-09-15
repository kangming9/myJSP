package kr.community.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import kr.community.vo.CommunityVO;
import kr.util.DBUtil;

public class CommunityDAO {
	//싱글턴 패턴
	private static CommunityDAO instance = new CommunityDAO();
	
	public static CommunityDAO getInstance() {
		return instance;
	}
	private CommunityDAO() {}
	
	//글 등록
	public void insertCommunity(CommunityVO com)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		
		try {
			conn = DBUtil.getConnection();
			sql = "INSERT INTO community (com_num,com_title,com_member_num,com_content,com_date) VALUES (community_seq.nextval,?,?,?,sysdate)";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, com.getCom_title());
			pstmt.setInt(2, com.getCom_member_num());
			pstmt.setString(3, com.getCom_content());
			
			pstmt.executeUpdate();
		}catch(Exception e) {
			throw new Exception(e);
		}finally {

			DBUtil.executeClose(null, pstmt, conn);
		}
	}
	//총 레코드 수
	public int getCommunityCount(String keyfield, String keyword)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		String sub_sql = null;
		int count = 0;
		
		try {
			conn = DBUtil.getConnection();
			if(keyword == null || "".equals(keyword)) {
			sql = "select count(*) from community c join member m on c.com_member_num = m.member_num";
			pstmt = conn.prepareStatement(sql);
			}else {
				//검색글 갯수
				if(keyfield.equals("1")) sub_sql = "c.com_title LIKE ?";
				else if(keyfield.equals("2")) sub_sql = "m.member_id = ?";
				else if(keyfield.equals("3")) sub_sql = "c.com_content LIKE ?";
				
				sql = "select count(*) from community c join member m on c.com_member_num = m.member_num where (" + sub_sql + ")";
				pstmt = conn.prepareStatement(sql);
				if(keyfield.equals("2")) {
					pstmt.setString(1, keyword);
				}else{
					pstmt.setString(1, "%"+keyword+"%");
				}	
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
	
	//글 목록
	public List<CommunityVO> getCommunityList(int start, int end, String keyfield, String keyword)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<CommunityVO> list = null;
		String sql = null;
		String sub_sql = null;
		
		try {
			conn = DBUtil.getConnection();
			
			if(keyword == null || "".equals(keyword)) {
			sql = "select * from (select a.*, rownum rnum from (select * from community c join member m on c.com_member_num = m.member_num order by c.com_num DESC)a) WHERE rnum >= ? AND rnum <= ?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
		}else {
			if(keyfield.equals("1")) sub_sql = "c.com_title LIKE ?";
			else if(keyfield.equals("2")) sub_sql = "m.member_id = ?";
			else if(keyfield.equals("3")) sub_sql = "c.com_content LIKE ?";
			sql = "select * from (select a.*, rownum rnum from (select * from community c join member m on c.com_member_num = m.member_num where ("+sub_sql+") order by c.com_num DESC)a) WHERE rnum >= ? AND rnum <= ?";
			
			pstmt = conn.prepareStatement(sql);
			
			if(keyfield.equals("2")) {
				pstmt.setString(1, keyword);
			}else {
				pstmt.setString(1, "%"+keyword+"%");
			}
			pstmt.setInt(2, start);
			pstmt.setInt(3, end);
		}
			
			rs = pstmt.executeQuery();
			list = new ArrayList<CommunityVO>();
			while(rs.next()) {
				CommunityVO com = new CommunityVO();
				com.setCom_num(rs.getInt("com_num"));
				com.setCom_title(rs.getString("com_title"));
				com.setCom_member_num(rs.getInt("com_member_num"));
				com.setCom_member_id(rs.getString("member_id"));
				com.setCom_content(rs.getString("com_content"));
				com.setCom_date(rs.getDate("com_date"));
				com.setCom_hit(rs.getInt("com_hit"));
				
				list.add(com);
			}
			
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		return list;
	}
	
	//글상세
	public CommunityVO getCommunity(int com_num)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		CommunityVO com = null;
		String sql = null;
		
		try {
			conn = DBUtil.getConnection();
			sql = "select * from community c join member m on c.com_member_num = m.member_num where c.com_num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, com_num);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				com = new CommunityVO();
				com.setCom_num(rs.getInt("com_num"));
				com.setCom_title(rs.getString("com_title"));
				com.setCom_member_num(rs.getInt("com_member_num"));
				com.setCom_content(rs.getString("com_content"));
				com.setCom_date(rs.getDate("com_date"));
				com.setCom_hit(rs.getInt("com_hit"));
			}
			
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		
		return com;
	}
	
	//조회수 증가
	public void updateReadcount(int com_num)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		
		try {
			conn = DBUtil.getConnection();
			sql = "update community set com_hit=com_hit+1 where com_num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, com_num);
			pstmt.executeUpdate();
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt, conn);
		}
	}
	//글수정
	public void updateCommunity(CommunityVO com)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		
		try {
			conn = DBUtil.getConnection();
			sql = "update community set com_title=?, COM_CONTENT=? where com_num=?";
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, com.getCom_title());
			pstmt.setString(2, com.getCom_content());
			pstmt.setInt(3, com.getCom_num());
			pstmt.executeUpdate();
			
		}catch (Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt, conn);
		}
	}
	
	//글삭제
	public void deleteCommunity(int com_num)throws Exception{
	Connection conn = null;
	PreparedStatement pstmt = null;
	PreparedStatement pstmt2 = null;
	String sql = null;
	
	try {
		conn = DBUtil.getConnection();
		sql = "delete from community_reply where com_num=?";
		pstmt=conn.prepareStatement(sql);
		pstmt.setInt(1, com_num);
		pstmt.executeUpdate();
		
		sql = "delete from community where com_num=?";
		pstmt2 = conn.prepareStatement(sql);
		pstmt2.setInt(1, com_num);
		pstmt2.executeUpdate();
		
	}catch (Exception e) {
		throw new Exception(e);
	}finally {
		DBUtil.executeClose(null, pstmt2, null);
		DBUtil.executeClose(null, pstmt, conn);
	}
	
	}
}