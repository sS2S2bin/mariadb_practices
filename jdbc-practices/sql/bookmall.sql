

insert into user(name, email, password, phone) values("데스트유저01", "test01@test.com", "1234", "010-0000-0000");
delete from user where no=3;
delete from category where no>0;
delete from book where no >0;
delete from orders where no >0;

delete from orders_book ;
delete from cart where user_no=1 and book_no=1;

truncate orders;
delete from orders;
-- truncate orders_book;
-- truncate cart;
truncate category;
truncate book;
truncate user;


select no, name from category;

insert into category(name) values("인문");
insert into category(name) values("컴퓨터");
insert into cart(quantity, book_no, user_no) values(2,3,3);
-- insert into orders(number, status, payment, shipping, user_no) values("20240520-000012","배송준비",82400,"서울시 은평구 진관3로 77 구파발 래미안 926-801",1)



select * from user; 
select * from category;
select * from book;
select * from cart;
select * from orders;
select * from orders_book;

select ob.order_no, ob.quantity, ob.price, ob.book_no, b.title
from orders_book ob, book b, orders o
where b.no = ob.book_no
and o.order_no = ob.order_no
and ob.order_no = 1
and o.user_no = 1
;