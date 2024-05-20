package bookshop.example;

public class Book {
	private int bookNo;
	private String title;
	private String author;
	private int stateCode;
	
	public int getBookNo() {
		return bookNo;
	}
	public void setBookNo(int bookNo) {
		this.bookNo = bookNo;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getAuthor() {
		return author;
	}
	public void setAuthor(String author) {
		this.author = author;
	}
	public int getStateCode() {
		return stateCode;
	}
	public void setStateCode(int stateCode) {
		this.stateCode = stateCode;
	}
	
	
	public Book(int num, String title, String author) {
		this.bookNo = num;
		this.title = title;
		this.author = author;
		this.stateCode = 1;
	}
	public static void rent(Book books) {
		books.setStateCode(0);
		System.out.println(books.getTitle() +"가 대여 되었습니다.");
	}
//	public static void rent() {
//		setStateCode(0);
//		System.out.println(title + "이(가) 대여 됐습니다.");
//	}
}
