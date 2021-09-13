package kr.communityReply.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;

import kr.communityReply.vo.CommunityReplyVO;
import kr.util.DBUtil;

public class CommunityReplyDAO {
	private static CommunityReplyDAO instance =new CommunityReplyDAO();
	
	public static CommunityReplyDAO getInstance() {
		return instance;
	}
	
	private CommunityReplyDAO() {}
	
	//´ñ±Û µî·Ï
	public void insertReply(CommunityReplyVO reply)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		
		try {
			conn = DBUtil.getConnection();
			
			sql = "insert into community_reply (re_num, re_content, com_num, member_num) values(reply_seq.nextval,?,?,?)";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, reply.getRe_content());
			pstmt.setInt(2, reply.getCom_num());
			pstmt.setInt(3, reply.getMember_num());
			
			pstmt.executeUpdate();
			
		}catch(Exception e) {
			throw new Exception(e);
		}finally{
			DBUtil.executeClose(null, pstmt, conn);
		}
	}
		
	//´ñ±Û °¹¼ö
	public int getReplyCount(int com_num)throws Exception{

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int count = 0;
		
		try {
			conn = DBUtil.getConnection();
			sql = "select count(*) from community_reply b join community m on b.member_num=m.member_num where b.com_num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, com_num);
			
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
	//´ñ±Û ¸ñ·Ï
	public List<CommunityReplyVO> getListReply(int start, int end, int com_num)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<CommunityReplyVO> list = null;
		String sql = null;
		
		try {
			conn = DBUtil.getConnection();
			sql = "";
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		return list;
	}
	//´ñ±Û ¼öÁ¤
	public void updateReply(CommunityReplyVO reply)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		
		try {
			conn = DBUtil.getConnection();
			sql = "update community_reply set re_content=? where re_num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, reply.getRe_content());
			pstmt.setInt(2, reply.getRe_num());
			pstmt.executeUpdate();
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt, conn);
		}
	}
	//´ñ±Û »èÁ¦
	public void deleteReply(int re_num)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		
		try {
			conn = DBUtil.getConnection();
			sql = "delete from community_reply where re_num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, re_num);
			pstmt.executeUpdate();
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt, conn);
		}
	}
}
