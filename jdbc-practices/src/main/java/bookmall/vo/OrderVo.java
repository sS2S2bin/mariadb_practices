package bookmall.vo;

public class OrderVo {
	private Long no;
	private Long payment;
	private Long userNo;
	private String number;
	private String status;
	private String shipping;
	public Long getNo() {
		return no;
	}
	public void setNo(Long no) {
		this.no = no;
	}
	public Long getPayment() {
		return payment;
	}
	public void setPayment(int i) {
		this.payment = Long.valueOf(i);
	}
	public void setPayment(Long payment2) {
		this.payment = payment2;
	}
	public Long getUserNo() {
		return userNo;
	}
	public void setUserNo(Long userNo) {
		this.userNo = userNo;
	}
	public String getNumber() {
		return number;
	}
	public void setNumber(String number) {
		this.number = number;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getShipping() {
		return shipping;
	}
	public void setShipping(String shipping) {
		this.shipping = shipping;
}
	
	
}
