package bookmall.vo;

public class CartVo {
	// Long 이 아닌 int로 해도 되나요?
	private Long quantity;
	private Long bookNo;
	private Long userNo;
	
	private String bookTitle;
	
	public String getBookTitle() {
		return bookTitle;
	}
	public void setBookTitle(String bookTitle) {
		this.bookTitle = bookTitle;
	}

	public Long getQuantity() {
		return quantity;
	}
	public void setQuantity(int i) {
		this.quantity = Long.valueOf(i);
	}
	public void setQuantity(Long i) {
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
