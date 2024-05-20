package bookmall.vo;

public class CartVo {
	// Long 이 아닌 int로 해도 되나요?
	private int quantity;
	private Long bookNo;
	private Long userNo;
	
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int i) {
		this.quantity = i;
	}
	public Long getBookNo() {
		return bookNo;
	}
	public void setBookNo(Long bookNo) {
		this.bookNo = bookNo;
	}
	public Long getUserNo() {
		return userNo;
	}
	public void setUserNo(Long userNo) {
		this.userNo = userNo;
	}
	
	
}
