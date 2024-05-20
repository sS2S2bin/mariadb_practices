package bookshop.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import bookshop.vo.AuthorVo;

public class AuthorDao {
	// 중복코드 리펙토링 : 함수로 바꿔라
	private Connection getConnection() throws SQLException {
		Connection conn = null;
		
		try {
			Class.forName("org.mariadb.jdbc.Driver");
			
			String url = "jdbc:mariadb://192.168.64.3:3306/webdb?charset=utf-8";
			conn = DriverManager.getConnection(url, "webdb", "webdb");

		}catch (ClassNotFoundException e) {
			System.out.println("드라이버 로딩 실패: "+e);
		} //어차피 executeQuery 등 다른 곳에서도 필요함 throws 해주면 밑에 sql exception이 처리가 됌

		return conn;

	}

	public List<AuthorVo> findAll() {
		List<AuthorVo> result = new ArrayList<>();
		
		
		
		
		try(
			Connection conn = getConnection(); // finally 에서 close 안해도됨
			PreparedStatement pstmt = conn.prepareStatement("select no, name from author"); //이런 것 만 올 수 있음 // int j = 10 이런건 안돼!
			ResultSet rs = pstmt.executeQuery();
		){
			// binding이 있는 query는 아래에서 rs + rs next뒤에 rs.close()
			while(rs.next()) {
				Long no = rs.getLong(1);
				String name = rs.getString(2);
				
				System.out.println(no + ":" + name );
				
				AuthorVo vo = new AuthorVo();
				vo.setNo(no);
				vo.setName(name);
			
				result.add(vo);
			}
			
			
			} catch (SQLException e) {
				System.out.println("error : "+e);
			}
		
		return result;
	}

}
