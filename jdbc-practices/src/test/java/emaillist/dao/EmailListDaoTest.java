package emaillist.dao;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.util.List;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.MethodOrderer;
import org.junit.jupiter.api.Order;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.TestMethodOrder;

import emaillist.vo.EmaillistVo;

@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
public class EmailListDaoTest {
	private static int count = 0;
	
	
	@BeforeAll
	public static void setUp() {
		List<EmaillistVo> list = new EmaillistDao().findAll();
		count = list.size(); // test전에 전체 사이즈를 미리 셋팅을 해두는거야.

	}
	
	@Test
	@Order(1)
	public void testInsert() {
		EmaillistVo vo = new EmaillistVo();
		vo.setFirstName("둘");
		vo.setLastName("리");
		vo.setEmail("dooly@gmail.com");
		
		boolean result = new EmaillistDao().insert(vo);
		
		assertTrue(result);
	}
	@Test
	@Order(2)
	public void testFindAll() {
		List<EmaillistVo> list = new EmaillistDao().findAll();
		assertEquals(count + 1, list.size()); //원하는 건 하나 리스트의 사이즈다.
		
	}

	
	@Test
	@Order(3)
	public void testDeleteByEmail() {
		boolean result = new EmaillistDao().deleteByEmail("dooly@gmail.com");
		
		assertTrue(result);
	}
	
	
	@AfterAll
	public static void cleanup() {
		
	}
	
}
