package kr.donation.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

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
				pstmt.setInt(8, don.getRoutine());
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
		
		//후원 신청 개수
		public int getDonationCount() throws Exception {
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			int count = 0;
				
			try {
				conn = DBUtil.getConnection();
				sql = "SELECT COUNT(*) FROM donation";
				pstmt = conn.prepareStatement(sql);
				
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
		
		//봉사 신청 목록
		public List<DonationVO> getListDonation(int start, int end, int key) throws Exception{
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			List<DonationVO> list = null;
			String sql = null;
			String subsql = null;
				
			try {
				conn = DBUtil.getConnection();
				
				sql = "SELECT * FROM\r\n"
						+ "(SELECT a.*, rownum rnum FROM\r\n"
						+ "(SELECT * FROM donation d ORDER BY d.don_num DESC)a)\r\n"
						+ "WHERE rnum >= ? AND rnum <= ?\r\n";
				
				if(key < 2) subsql = "AND don_routine = ?";
				else subsql = "";
				
				sql = sql + subsql;
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, start);
				pstmt.setInt(2, end);
				if(key < 2) pstmt.setInt(3, key);
					
				rs = pstmt.executeQuery();
				list = new ArrayList<DonationVO>();
				while(rs.next()) {
					DonationVO don = new DonationVO();
					don.setName(rs.getString("don_name"));
					don.setBirth(rs.getDate("don_birth"));
					don.setAddr(rs.getString("don_addr"));
					don.setTel(rs.getString("don_tel"));
					don.setTel_rec(rs.getInt("don_tel_rec"));
					don.setMail(rs.getString("don_mail"));
					don.setMail_rec(rs.getInt("don_mail_rec"));
					don.setRoution(rs.getInt("don_routine"));
					don.setMoney(rs.getInt("don_money"));
					don.setBank(rs.getString("don_bank"));
					don.setAccount(rs.getString("don_account"));
					don.setBank_name(rs.getString("don_bank_name"));

					list.add(don);
				}
					
			}catch(Exception e) {
				throw new Exception(e);
			}finally {
				DBUtil.executeClose(rs, pstmt, conn);
			}
			return list;
		}
}
