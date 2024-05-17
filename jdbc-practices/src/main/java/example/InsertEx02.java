package example;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class InsertEx02 {
public static void insert(String deptName) {
	boolean result = false;
	Connection conn = null;
	PreparedStatement pstmt = null;
	try {
		// 1. JDBC Driver 로딩
		Class.forName("org.mariadb.jdbc.Driver");
		//2. 연결
		String url = "jdbc:mariadb://192.168.64.3:3306/webdb?charset=utf-8";
		conn = DriverManager.getConnection(url, "webdb", "webdb");

		//3. Statement 준비
		String sql = "insert into dept values(null, ?)";
		pstmt = conn.prepareStatement(sql);
		
		//4. binding
		pstmt.setString(1,"%"+deptName+"%");
		
		//5. SQL 실행
		int count = pstmt.executeUpdate();
		
		// 1 : Success
		// 0 : Fail
		result = count ==1;
		} catch (SQLException e) {
			System.out.println("error : "+e);
		}
		catch (ClassNotFoundException e) {
		System.out.println("드라이버 로딩 실패: "+e);
		}finally {
			try {
				if(pstmt!=null) {
					pstmt.close();
				}
				if(conn!=null) {
					conn.close();	
				}
			} catch (SQLException e) {
				System.out.println("error: "+e);
			}
		}
	

}

public static void main(String[] args) {
	
		insert("기획1팀");
		insert("기획2팀");
		
	}

}
