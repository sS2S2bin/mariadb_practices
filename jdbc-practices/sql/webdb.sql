-- insert
insert into dept values(null, '디자인팀');


-- delete
delete from dept where no = 7;
-- 1번 삭제 오류 : 무결성 오류 : 1번을 갖고 있는 애가 emp에 있음

-- update
update dept set name = '시스템개발' where no = 2;

-- select
select * from dept;

select * from emp;