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
	public int getCommunityCount()throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int count = 0;
		
		try {
			conn = DBUtil.getConnection();
			sql = "select count(*) from community c join member m on c.com_member_num = m.member_num";
			
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
	
	//글 목록
	public List<CommunityVO> getCommunityList(int start, int end)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<CommunityVO> list = null;
		String sql = null;
		
		try {
			conn = DBUtil.getConnection();
			sql = "select * from (select a.*, rownum rnum from (select * from community c join member m on c.com_member_num = m.member_num order by c.com_num DESC)a) WHERE rnum >= ? AND rnum <= ?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			
			rs = pstmt.executeQuery();
			list = new ArrayList<CommunityVO>();
			while(rs.next()) {
				CommunityVO com = new CommunityVO();
				com.setCom_num(rs.getInt("com_num"));
				com.setCom_title(rs.getString("com_title"));
				com.setCom_member_num(rs.getInt("com_member_num"));
				com.setCom_content(rs.getString("com_content"));
				com.setCom_date(rs.getString("com_date"));
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
				com.setCom_date(rs.getString("com_date"));
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
			sql = "update community set hit=hit+1 where com_num=?";
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
	
	//글삭제
}