package kr.donation.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import kr.donation.vo.DonationVO;

import kr.util.DBUtil;

public class DonationDAO {
private static DonationDAO instance = new DonationDAO();
	
	public static DonationDAO getInstance() {
		return instance;
	}
	
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
		
		public void insertDonation(DonationVO don)throws Exception{
			Connection conn = null;
			PreparedStatement pstmt = null;
			String sql = null; 
			
			try{
				//커넥션풀로부터 커넥션을 할당
				conn = DBUtil.getConnection();
				
				//봉사번호(vol_num) 생성
				sql = "INSERT INTO donation (don_num, don_name, don_birth, don_addr, don_tel, don_tel_rec, "
						+ "don_mail, don_mail_rec, don_routine, don_money, don_bank, don_account, don_bank_name)"
						+ " VALUES (volunteer_seq.nextval, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
				
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setString(1, don.getName());
				pstmt.setDate(2, don.getBirth());
				pstmt.setString(3, don.getAddr());
				pstmt.setString(4, don.getTel());
				pstmt.setInt(5, don.getTel_rec());
				pstmt.setString(6, don.getMail());
				pstmt.setInt(7, don.getMail_rec());
				pstmt.setInt(8, don.getRoution());
				pstmt.setInt(9, don.getMoney());
				pstmt.setString(10, don.getBank());
				pstmt.setString(11, don.getAccount());
				pstmt.setString(12, don.getBank_name());
				
				pstmt.executeUpdate();
				
			}catch(Exception e) {
				throw new Exception(e);
			}finally {
				//자원정리
				executeClose(null, pstmt, conn);
			}
		}
		
}
