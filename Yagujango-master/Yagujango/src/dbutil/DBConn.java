package dbutil;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConn {
	
	//DB 연결 정보
	private static final String DRIVER = "oracle.jdbc.driver.OracleDriver";
	private static final String URL = "jdbc:oracle:thin:@localhost:1521:xe";
	private static final String USERNAME = "semi";
	private static final String PASSWORD = "1234";
	
	//DB 연결 객체
	private static Connection conn = null;
	
	//private 생성자
	private DBConn() { }
	
	//Connection 객체 반환 - 싱글톤 패턴 유지
	public static Connection getConnection() {
		
		//DB 연결된 적이 없을 경우
		if( conn == null ) {
			
			try {
				Class.forName(DRIVER);
				
				conn = DriverManager.getConnection(URL, USERNAME, PASSWORD);
			} catch (ClassNotFoundException e) {
				e.printStackTrace();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return conn;
	}

}
