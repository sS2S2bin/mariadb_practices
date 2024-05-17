-- DDL/DML 연습
drop table member;
create table member(
	no int not null auto_increment,
    email varchar(200) not null,
    password varchar(64) not null,
    name varchar(50) not null,
    department varchar(100),
    primary key(no)
);

desc member;
alter table member add column juminbunho char(13) not null;
alter table member drop juminbunho;
-- 위치를 지정해서 컬럼 추가할 때 after
alter table member add column juminbunho char(13) not null after email;

alter table member change column department dept varchar(100) not null ;

alter table member add column self_intro text;
desc member;

alter table member drop juminbunho;
desc member;

-- insert
insert 
	into member
    values(null, 'kickscar@gmail.com', password('1234'), '안대혁', '개발팀', null );
    
	
insert  
	into member(no, email, name, dept, password)
    values( null, 'kickscar2@gmail.com', '안대혁2', '개발팀2', password('1234') );

-- update
update member
set email = 'kickscar3@gmail.com', password=password('4321')
where no =2;
select * from member;

delete 
from member
where no = 2;

select * from member;

-- transcation (두개가 서로 고립되있어 그래서 commit 날려야 )
-- (insert, update, delete)
-- 1. update - 계좌T(set 잔고 -= 금연, where 계좌번호 = 보내는 계좌)
-- 2. update - 계좌T(set 잔고 += 금액 where 계좌번호 = 받는 계좌)

-- commit이 날라가면 그때 두 결과가 실제 db에 반영되어서 변경된 데이터가 보임
-- "고립" 커밋 날라가기전에 또 날리면 변경된게 보여 나한테만!!! 근데 다른 사람들이 보면 변경사항 안보여
select no, email from member;

select @@autocommit; -- 1이면 insert 하더라도 자동 반영이됨

insert into member(no, email, name, dept, password) values(null, 'kickscar2@gmail.com', '안대혁2', '개발팀2', password('1234'));

select no, email from member;


-- tx begin
-- 이제 commit을 명시 해야 반영이 됨.
set autocommit = 0; 
select @@autocommit;

insert into member(no, email, name, dept, password) values(null, 'kickscar3@gmail.com', '안대혁3', '개발팀3', password('1234'));
select no, email from member;

-- tx end
commit;
select no, email from member;