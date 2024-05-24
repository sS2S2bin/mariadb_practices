desc emaillist;

-- (c)reate 
insert into emaillist values(null, '둘','리','dooly@gmail.com');
-- (r)ead

select no, first_name, last_name,email from emaillist order by no desc;

-- (d)elete
delete from emaillist where email = 'dooly@gmail.com';
-- set sql_safe_updates = 0;


insert into author values(null, '....');
-- insert into author(name) values(?)

select * from author;

select * from author;
select * from book a, author b where a.author_no and b.no order by a.no desc;
select * from book; 
select a.no, a.title, a.status, b.name from book a, author b where a.author_no and b.no order by b.no desc;

select * from emaillist;
delete from emaillist where no=12;
select * from guestbook;
select no from guestbook;
select last_insert_id() from guestbook;
delete from emaillist;

insert into guestbook(6, 3,3,3,now());