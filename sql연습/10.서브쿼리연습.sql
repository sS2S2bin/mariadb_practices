-- 
-- subquery
-- 

-- 
-- 1) select 절 , insert into t1 values(...)
--
-- insert into board values (null, (select max(group_no) +1 from board),...,...);
select (select 1+2 from dual) from dual;

select a.* from (select 1+2 from dual) a;

-- 
-- 2) from 절의 서브쿼리
-- 
select now() as n, sysdate() as s, 3+1 as r from dual;
select *
from ( select now() as n, sysdate() as s, 3+1 as r from dual) a;


--
-- 3) where 절의 서브쿼리
--

-- 예제) 현재, fai bale이 근무하는 부서에서 근무하는 다른 직원의 사번과 이름을 출력하세요.
select *
from employees e, dept_emp de
where e.emp_no = de.emp_no
and de.to_date = '9999-01-01'
and concat(e.first_name, ' ', e.last_name) = 'Fai Bale';

-- 'd004'
select *
from employees e, dept_emp de
where e.emp_no = de.emp_no
and de.dept_no = 'd004';

-- 이렇게 푸는 것 보다 서브쿼리 쓰는게 좋다. 

select  e.emp_no, e.first_name
from employees e, dept_emp de
where e.emp_no = de.emp_no
and de.dept_no = (select b.dept_no
					from employees a, dept_emp b
                    where a.emp_no = b.emp_no
                    and b.to_date='9999-01-01'
                    and concat(e.first_name, ' ', e.last_name) = 'Fai Bale');
                    



-- 3-1) 단일행 연산자 = > < >= <= <> !=

-- 실습 문제 1
-- 현재, 전체 사원의 평균 연봉보다 적은 급여를 받는 사원의 이름과 급여를 출력

select *
from employees e, salaries s
where e.emp_no = s.emp_no
and s.to_date = '9999-01-01'
and s.salary < (select avg(salary)
				from salaries
				where to_date = '9999-01-01')
order by s.salary desc;

-- 실습문제 2
-- 현재 직책별 평균급여중에 가장 작은 직책 이름 과 평균 급여 출력
select avg(s.salary) as average , t.title
from titles t , salaries s
where t.emp_no = s.emp_no
and t.to_date = '9999-01-01'
and s.to_date = '9999-01-01'
group by t.title
order by average 
limit 1
;

-- 강사님 시범
-- 1) 직책별 평균 급여
select t.title, avg(s.salary)
from titles t, salaries s
where t.emp_no = s.emp_no
and s.to_date = '9999-01-01'
and t.to_date = '9999-01-01'
group by t.title;
-- 2) 직책별 가장 적은 평균 급여 from 절 subquery
-- 서브 쿼리를 쓸 때는 테이블로 생각하고 써.
select min(avg_salary) -- 집계 함수 있을 땐 다른 칼럼 오면 안돼!!!!!!!!!!!! a.title
from (	select t.title, avg(s.salary) as avg_salary
		from titles t, salaries s
		where t.emp_no = s.emp_no
		and s.to_date = '9999-01-01'
		and t.to_date = '9999-01-01'
		group by t.title
        ) a
;
-- 3) sol : where 절 subquery(=)
select a.title, avg(salary)
from titles a, salaries b
where a.emp_no = b.emp_no
and a.to_date = '9999-01-01'
and b.to_date = '9999-01-01'
group by a.title
having avg(salary) = ( select min(avg_sal)
						from ( select a.title as tt, avg(salary) as avg_sal
								from titles a, salaries b
								where a.emp_no = b.emp_no
								and a.to_date = '9999-01-01'
								and b.to_date = '9999-01-01'
								group by a.title) aa);



-- 4) top-k로 한방에 해결하
select t.title, avg(s.salary)
from titles t, salaries s
where t.emp_no = s.emp_no
and s.to_date = '9999-01-01'
and t.to_date = '9999-01-01'
group by t.title
order by avg(salary) asc
limit 0,1
;

-- 3-2) 복수행 연산자 in, not in , 비교연산자 any, 비교연산자 all
-- any 사용법
-- 1. =any : in
-- 2. >any >=any : 최솟값 어떤값보다도 작거나같으니까
-- 3. <any <=any : 최댓값
-- 4. <>any !=any : not in

-- all 사용법
-- 1. =all : (x)
-- 2. >all >=all 최대값 모든값보다 다 커야하니까
-- 3. <all <=all 최소값
-- 4. <>all !=all 


-- 실습문제3
-- 현재 급여가 50000 이상인 직원 이름과 급여 출력


-- sol1) join 
select s.salary, e.first_name
from employees e, salaries s
where e.emp_no = s.emp_no
and s.to_date = '9999-01-01'
and s.salary >= 50000
order by s.salary asc
;

-- sol2) subquery : where(in)
select e.first_name, s.salary
from employees e, salaries s
where e.emp_no = s.emp_no
and s.to_date = '9999-01-01'
and (e.emp_no, s.salary) in (select emp_no, salary 
							from salaries
							where to_date = '9999-01-01'
							and salary > 50000)
order by salary asc
;

-- 혼자 해본 것. emp_no를 비교하지 않았음
select s.salary, e.first_name
from employees e, salaries s
where e.emp_no = s.emp_no
and s.salary in (select salary
from salaries s
where s.to_date = '9999-01-01'
and s.salary > 50000
)
order by s.salary asc
;



-- sol3) subquery : where(=any)
select e.first_name, s.salary
from employees e, salaries s
where e.emp_no = s.emp_no
and s.to_date = '9999-01-01'
and (e.emp_no, s.salary) =any (select emp_no, salary 
							from salaries
							where to_date = '9999-01-01'
							and salary > 50000)
order by salary asc
;



-- 실습 문제 4
-- 현재, 각 부서별로 최고 급여를 받고 있는 직운의 이름과 월급
-- 부서 이름 / 이름 / 월급

-- sol1 where 절 subquery(in)
select d.dept_name, e.first_name, s.salary
from salaries s, dept_emp de, employees e, departments d
where de.emp_no and e.emp_no
and s.emp_no and e.emp_no
and de.dept_no = d.dept_no
and (de.dept_no, s.salary) in (select de.dept_no, max(salary)
				from salaries s, dept_emp de
				where s.emp_no = de.emp_no
				and de.to_date = '9999-01-01'
				and s.to_date = '9999-01-01'
				group by de.dept_no
				)
order by salary asc
;

-- 부서별 최고 급여
select de.dept_no, max(s.salary)
from dept_emp de, salaries s
where de.emp_no = s.emp_no
and de.to_date like '9999%'
and s.to_date like '9999%'
group by de.dept_no
;

-- sol2 from 절 suquery & join 테이블로써 취급

select dept_name, first_name, salary
from departments d, dept_emp de, employees e, salaries s,(
select de.dept_no, max(s.salary)
from dept_emp de, salaries s
where de.emp_no = s.emp_no
and de.to_date like '9999%'
and s.to_date like '9999%'
group by de.dept_no
) s                                                                      
where d.dept_no = de.dept_no
and de.emp_no = e.emp_no
and e.emp_no = s.emp_no
and s.to_date = '9999-01-01'
and de.to_date = '9999-01-01'
