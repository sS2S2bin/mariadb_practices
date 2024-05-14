insert into dept values(null, '총무');
insert into dept values(null, '개발');
insert into dept values(null, '영업');
insert into dept values(null, '기획');

select * from dept;

insert into emp values(null, '둘리', 4);
insert into emp values(null, '마이콜', 3);
insert into emp values(null, '또치', 2);
insert into emp values(null, '길동', null);

select * from emp;

-- inner join
select a.name, b.name
from emp a join dept b on a.dept_no = b.no;

-- left(outer) join
select a.name as '이름' , b.name as '부서'
from emp a left join dept b on a.dept_no = b.no;


-- right(outer) join 
select a.name, b.name
from emp a right join dept b on a.dept_no = b.no;
