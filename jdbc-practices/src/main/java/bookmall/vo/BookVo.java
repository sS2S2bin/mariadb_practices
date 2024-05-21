package bookmall.vo;

public class BookVo {
	private Long no;
	private String title;
	private Long price;
	private Long categoryNo;

	
	public Long getNo() {
		return no;
	}

	public void setNo(Long no) {
		this.no = no;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public Long getPrice() {
		return price;
	}

	public void setPrice(Long price) {
		this.price = price;
	}

	public Long getCategoryNo() {
		return categoryNo;
	}

	public void setCategoryNo(Long categoryNo) {
		this.categoryNo = categoryNo;
	}

	public BookVo(String title, int price) {
		this.title = title;
		this.price = Long.valueOf(price);
	}

	public BookVo() {
		
	}

}
