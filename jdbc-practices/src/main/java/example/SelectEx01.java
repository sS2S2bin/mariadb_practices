package example;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class SelectEx01 {
	
	public static void main(String[] args) {
		
		search("pat");
		

	}
	
	public static void search(String keyword) {
		boolean result = false;
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		try {
			// 1. JDBC Driver 로딩
			Class.forName("org.mariadb.jdbc.Driver");
			//2. 연결
			String url = "jdbc:mariadb://192.168.64.3:3306/employees?charset=utf-8";
			conn = DriverManager.getConnection(url, "hr", "hr");

			//3. Statement 생성
			stmt = conn.createStatement();
			
			
			//4. SQL 실행
			String sql = "select emp_no, first_name, last_name "
					+ "from employees "
					+ "where first_name like '%" +keyword+"%';"
					;
			rs = stmt.executeQuery(sql);
			// 1 : Success
			// 0 : Fail
			
			
			//5. 결과 처리 
			while(rs.next()) {
				Long empNo = rs.getLong(1);
				String firstName = rs.getString(2);
				String lastName = rs.getString(3);
				
				System.out.println(empNo + ":" + firstName + lastName);
			}
			
			
			
			} catch (SQLException e) {
				System.out.println("error : "+e);
			}
			catch (ClassNotFoundException e) {
			System.out.println("드라이버 로딩 실패: "+e);
			}finally {
				try {
					if(rs!=null) {
						rs.close();
					}
					if(stmt!=null) {
						stmt.close();
					}
					if(conn!=null) {
						conn.close();	
					}
				} catch (SQLException e) {
					System.out.println("error: "+e);
				}
			}
		
	}
}
