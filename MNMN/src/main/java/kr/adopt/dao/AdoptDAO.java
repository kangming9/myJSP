package kr.adopt.dao;


public class AdoptDAO {
	private static AdoptDAO instance = new AdoptDAO();
		
		public static AdoptDAO getInstance() {
			return instance;
		}
		
		private AdoptDAO() {}
		
		
}
