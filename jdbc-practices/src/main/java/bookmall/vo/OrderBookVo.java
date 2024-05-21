package bookmall.vo;

public class OrderBookVo {
	private Long quantity;
	private Long price;
	private Long bookNo;
	private Long orderNo;
	
	private String bookTitle;
	
	public Long getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = Long.valueOf(quantity);
	}
	public Long getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = Long.valueOf(price);
	}
	public Long getBookNo() {
		return bookNo;
	}
	public void setBookNo(Long bookNo) {
		this.bookNo = bookNo;
	}
	public Long getOrderNo() {
		return orderNo;
	}
	public void setOrderNo(Long orderNo) {
		this.orderNo = orderNo;
	}
	public String getBookTitle() {
		return bookTitle;
	}
	public void setQuantity(Long quantity) {
		this.quantity = quantity;
	}
	public void setPrice(Long price) {
		this.price = price;
	}
	public void setBookTitle(String bookTitle) {
		this.bookTitle = bookTitle;
	}
	
	
}
