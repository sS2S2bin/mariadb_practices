package bookmall.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import bookmall.vo.CartVo;
import bookmall.vo.UserVo;

public class CartDao {
	private Connection getConnection() throws SQLException {
		Connection conn = null;
		try {
		Class.forName("org.mariadb.jdbc.Driver");
		
		String url = "jdbc:mariadb://192.168.64.3:3306/bookmall?charset=utf-8";
		
		conn = DriverManager.getConnection(url, "bookmall", "bookmall");
		}catch (ClassNotFoundException e) {
			System.out.println("드라이버 로딩 실패: "+e);
		} 
		return conn;
	}
	
	public void insert(CartVo vo) {
		try(
				Connection conn = getConnection(); 
				PreparedStatement pstmt = conn.prepareStatement("insert into cart(quantity, book_no, user_no) values(?,?,?)");  
			){
				pstmt.setLong(1, vo.getQuantity());
				pstmt.setLong(2, vo.getBookNo());
				pstmt.setLong(3, vo.getUserNo());
				pstmt.executeUpdate();
				
			} catch (SQLException e) {
				System.out.println("error : "+e);
			}

		
	
		
	}

	public List<CartVo> findByUserNo(Long no) {
		List<CartVo> result = new ArrayList<>();
		try( 
				Connection conn = getConnection();
				PreparedStatement pstmt = conn.prepareStatement(
				"select b.title, b.no, c.quantity from book b, cart c where b.no = c.book_no and c.user_no = ? "); //이런 것 만 올 수 있음 // int j = 10 이런건 안돼!
				
			){
				pstmt.setLong(1, no);
				ResultSet rs = pstmt.executeQuery();
				while(rs.next()) {
				
				String title = rs.getString(1);
				Long bookNo = rs.getLong(2);
				Long quantity = rs.getLong(3);
	
				
				System.out.println(no + ":" + title +" "+quantity);
				
				CartVo vo = new CartVo();
				vo.setBookNo(bookNo);
				vo.setBookTitle(title);
				vo.setQuantity(quantity);
				
			
				result.add(vo);
			}  
			
			
			} catch (SQLException e) {
				System.out.println("error : "+e);
			}
		
		return result;
	}

	public void deleteByUserNoAndBookNo(Long userNo, Long bookNo) {
		try(
				Connection conn = getConnection(); 
				PreparedStatement pstmt = conn.prepareStatement("delete from cart where book_no=? and user_no=?");  
			){
				pstmt.setLong(1, bookNo);
				pstmt.setLong(2, userNo);
				pstmt.executeUpdate();
				
				
			} catch (SQLException e) {
				System.out.println("error : "+e);
			}
		
	}
}
