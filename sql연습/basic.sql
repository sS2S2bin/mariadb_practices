select version(), current_date, now() from dual;

-- 수학 함수, 사칙연산도 된다.
select sin(pi()/4), 1+2*3-4/5 from dual;

-- 대소문자 구분이 없다.
select VERSION(), current_DATE, NOW() from dual;

-- table 생성 : DDL
create table pet(
	name varchar(100),
    owner varchar(50), 
    species varchar(20), 
    gender char(1), 
    birth date, 
    death date
);

-- schema 확인 
describe pet;
desc pet;

-- table 삭제
drop table pet;
show tables;

-- insert: DML(C)
insert into pet values('귀요미', '이수빈', 'rabbit', "f",'2008-12-28',null);

-- select : DML(R)
select * from pet;

-- udpate :  DML(U)
update pet set name='귀욤이' where name='귀요미';

-- delete : DML(D)
delete from pet where name='귀욤이';

-- load data
load data local infile '/root/pet.txt' into table pet;

-- select 연습
select name, species from pet
where name ='bowser';

select name, species from pet
where birth>='1998-01-1';


select name, species,gender from pet
where gender='f' and species='dog';

select name, species from pet
where species='bird' or species='snake';


select name, birth
from pet order by birth asc;

select name, birth
from pet order by birth desc;

select name from pet
where name like '%fy';

select name from pet
where name like '__';
