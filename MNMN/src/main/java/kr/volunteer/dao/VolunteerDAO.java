package kr.volunteer.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import kr.volunteer.vo.VolunteerVO;
import kr.util.DBUtil;

public class VolunteerDAO {
private static VolunteerDAO instance = new VolunteerDAO();
	
	public static VolunteerDAO getInstance() {
		return instance;
	}
	private VolunteerDAO() {}
	
	//context.xml에서 설정 정보를 읽어들여 커넥션풀로부터 커넥션을 할당
	private Connection getConnection()throws Exception{
		Context initCtx = new InitialContext();
		DataSource ds = (DataSource)initCtx.lookup("java:comp/env/jdbc/xe");
		return ds.getConnection();
	}
	//자원정리
	private void executeClose(ResultSet rs, PreparedStatement pstmt, Connection conn) {
		if(rs!=null)try {rs.close();}catch(SQLException e) {}
		if(pstmt!=null)try {pstmt.close();}catch(SQLException e) {}
		if(conn!=null)try {conn.close();}catch(SQLException e) {}
	}
	
	public void insertVolunteer(VolunteerVO vol)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null; 
		
		try{
			//커넥션풀로부터 커넥션을 할당
			conn = DBUtil.getConnection();
			
			//봉사번호(vol_num) 생성
			sql = "INSERT INTO volunteer (vol_num, vol_member_num, vol_date, vol_time, vol_reg_date)"
					+ " VALUES (volunteer_seq.nextval, ?, ?, ?, SYSDATE)";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, vol.getVol_m_num());
			pstmt.setDate(2, vol.getVol_date());
			pstmt.setInt(3, vol.getVol_time());
			
			pstmt.executeUpdate();
			
		}catch(Exception e) {
			//SQL문장이 하나라도 실패하면 rollback
		    conn.rollback();
			throw new Exception(e);
		}finally {
			//자원정리
			executeClose(null, pstmt, conn);
		}
	}
	
	public int checkDateFull(String date)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		
		int volCount = 0;
		
		try {
			//커넥션풀로부터 커넥션 할당
			conn = DBUtil.getConnection();
			//zmember와 zmember_detail 조인시 zmember의 누락된 데이터가 보여야 id 중복 체크 가능함
			sql = "select count(*) as count from volunteer where to_char(vol_date, 'YY/MM/DD') = ?;";
			
			//PreparedStatement 객체 생성
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, date);
			
			//SQL문을 실행해서 결과행을 ResultSet에 담음
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				volCount = rs.getInt("count");
			}
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			//자원정리
			DBUtil.executeClose(rs, pstmt, conn);
		}
		return volCount;
	}
	
	
}
