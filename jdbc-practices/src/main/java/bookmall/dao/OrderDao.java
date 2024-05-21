package bookmall.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import bookmall.vo.OrderBookVo;
import bookmall.vo.OrderVo;

public class OrderDao {
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
	

	public void insert(OrderVo vo) {
		try(
				Connection conn = getConnection(); 
				PreparedStatement pstmt = conn.prepareStatement("insert into orders(number, status, payment, shipping, user_no) values(?,?,?,?,?)");
				PreparedStatement pstmt2 = conn.prepareStatement("select last_insert_id() from dual"); 
				
			){
				pstmt.setString(1, vo.getNumber());
				pstmt.setString(2, vo.getStatus());
				pstmt.setLong(3, vo.getPayment());
				pstmt.setString(4, vo.getShipping());
				pstmt.setLong(5, vo.getUserNo());
				
				int result = pstmt.executeUpdate();
				System.out.println(result);
				
				ResultSet rs = pstmt2.executeQuery();

				vo.setNo(rs.next() ? rs.getLong(1):null);
				rs.close();
				
			} catch (SQLException e) {
				System.out.println("error : "+e);
			}

		
	
	}

	public void insertBook(OrderBookVo vo) {
		try(
				Connection conn = getConnection(); 
				PreparedStatement pstmt = conn.prepareStatement("insert into orders_book(quantity, price, book_no, order_no) values(?,?,?,?)");  
			){
				pstmt.setLong(1, vo.getQuantity());
				pstmt.setLong(2, vo.getPrice());
				pstmt.setLong(3, vo.getBookNo());
				pstmt.setLong(4, vo.getOrderNo());
				pstmt.executeUpdate();
				
			} catch (SQLException e) {
				System.out.println("error : "+e);
			}

		
	}


	public void deleteBooksByNo(Long no) {
		try(
				Connection conn = getConnection(); 
				PreparedStatement pstmt = conn.prepareStatement("delete from orders_book where order_no=?");  
			){
				pstmt.setLong(1, no);
				pstmt.executeUpdate();
				
			} catch (SQLException e) {
				System.out.println("error : "+e);
			}
		
	}
	


	public void deleteByNo(Long no) {
		try(
				Connection conn = getConnection(); 
				PreparedStatement pstmt = conn.prepareStatement("delete from orders where no=?");  
			){
				pstmt.setLong(1, no);
				pstmt.executeUpdate();
				
				
			} catch (SQLException e) {
				System.out.println("error : "+e);
			}
		
	}


	public OrderVo findByNoAndUserNo(long l, Long userNo) {
		OrderVo result = null;
		
		try(
			Connection conn = getConnection();
			PreparedStatement ptmt = conn.prepareStatement(
					"select number, payment, status, shipping"
					+ " from orders where no=? and user_no=?");
		){
			ptmt.setLong(1,l);
			ptmt.setLong(2, userNo);
			
			ResultSet rs = ptmt.executeQuery();
			
			while(rs.next()) {
				result = new OrderVo();
				
				String number = rs.getString(1);
				Long payment = rs.getLong(2);
				String status = rs.getString(3);
				String shipping = rs.getString(4);
				
				result.setNumber(number);
				result.setPayment(payment);
				result.setStatus(status);
				result.setShipping(shipping);
			}
			
		}catch(SQLException e) {
			System.out.println("orderDao Error: "+e);
		}
		
		return result;
	}


	public List<OrderBookVo> findBooksByNoAndUserNo(Long orderNo, Long userNo) {
		List<OrderBookVo> result = new ArrayList<>();
		try(
				Connection conn = getConnection();
				PreparedStatement ptmt = conn.prepareStatement(
						"select ob.order_no, ob.quantity, ob.price, ob.book_no, b.title"
						+ " from orders_book ob, book b, orders o "
						+ " where b.no = ob.book_no"
						+ " and o.no = ob.order_no"
						+ " and ob.order_no = ?"
						+ " and o.user_no = ? ");
			){
				ptmt.setLong(1, orderNo);
				ptmt.setLong(2, userNo);
				
				ResultSet rs = ptmt.executeQuery();
				
				while(rs.next()) {
					OrderBookVo vo = new OrderBookVo();
					
					Long no = rs.getLong(1);
					Long quantity = rs.getLong(2);
					Long price = rs.getLong(3);
					Long book_no = rs.getLong(4);
					String title = rs.getString(5);
					
					vo.setOrderNo(no);
					vo.setQuantity(quantity);
					vo.setPrice(price);
					vo.setBookNo(book_no);
					vo.setBookTitle(title);
					
					result.add(vo);
				}
				
			}catch(SQLException e) {
				System.out.println("orderDao Error: "+e);
			}
		return result;
	}
}
