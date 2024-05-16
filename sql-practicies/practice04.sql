-- 서브쿼리(SUBQUERY) SQL 문제입니다.
--  
-- 문제1. 1255038
-- 현재 평균 연봉보다 많은 월급을 받는 직원은 몇 명이나 있습니까?
select count(s.emp_no)
from salaries s
where s.salary > (select avg(salary)
from salaries)
;



-- 문제2.
-- 현재, 각 부서별로 최고의 급여를 받는 사원의 사번, 이름, 부서 연봉을 조회하세요. 단 조회결과는 연봉의 내림차순으로 정렬되어 나타나야 합니다.
select e.emp_no, e.first_name, d.dept_name, s.salary
from dept_emp de, departments d, salaries s, employees e
where e.emp_no = s.emp_no
and e.emp_no = de.emp_no
and de.dept_no = d.dept_no
and de.to_date = '9999-01-01'
and s.to_date = '9999-01-01'
and (de.dept_no, salary) in ( select de.dept_no, max(salary)
from salaries s, dept_emp de
where de.emp_no = s.emp_no
and de.to_date = '9999-01-01'
and s.to_date = '9999-01-01'
group by de.dept_no )
order by salary desc
;


-- 문제3. 
-- 현재, 자신의 부서 평균 급여보다 연봉(salary)이 많은 사원의 사번, 이름과 연봉을 조회하세요
select e.emp_no, concat(e.first_name, ' ', e.last_name) as name , s.salary
from dept_emp de, salaries s, employees e, 
(select de.dept_no, avg(salary) as avg_salary
							from salaries s, dept_emp de
							where s.emp_no = de.emp_no
							and de.to_date = '9999-01-01'
							and s.to_date = '9999-01-01'
							group by de.dept_no
							) a
where de.emp_no = s.emp_no
and de.emp_no = e.emp_no
and de.dept_no = a.dept_no
and de.to_date = '9999-01-01'
and s.to_date = '9999-01-01'
and s.salary > a.avg_salary
order by salary asc
;



-- 문제4.
-- 현재, 사원들의 사번, 이름, 자신의 매니저 이름, 부서 이름으로 출력해 보세요.
-- department + dept_emp + employees = 사원
-- dept_manager + employees = 매니저
-- dept_emp-dept_no-dept_manager
select e.emp_no, concat(e.first_name, ' ', e.last_name) as name , manager.manager_name , d.dept_name
from employees e, departments d, dept_emp de, ( 
select concat(e.first_name, ' ', e.last_name) as manager_name, de.dept_no
from dept_manager dm, employees e, dept_emp de
where dm.emp_no = de.emp_no
and dm.emp_no = e.emp_no
and de.to_date = '9999-01-01'
and dm.to_date = '9999-01-01'
) manager
where e.emp_no = de.emp_no
and d.dept_no = de.dept_no
and de.to_date = '9999-01-01'
and manager.dept_no = de.dept_no
order by emp_no
;
 
-- 문제5.
-- 현재, 평균연봉이 가장 높은 부서의 사원들의 사번, 이름, 직책, 연봉을 조회하고 연봉 순으로 출력하세요.

-- 수정 버전. 1.57초 걸림 where 절에 넣으니까 훨씬 줄어
select e.emp_no , d.dept_name, concat(e.first_name, ' ', e.last_name) as name, t.title, s.salary
from departments d, employees e, titles t, dept_emp de, salaries s
where e.emp_no = t.emp_no
and e.emp_no = de.emp_no
and t.emp_no = s.emp_no
and d.dept_no = de.dept_no
and s.to_date = '9999-01-01'
and t.to_date = '9999-01-01'
and de.to_date = '9999-01-01'
and de.dept_no = ( select de.dept_no
from dept_emp de, salaries s
where s.emp_no = de.emp_no
and s.to_date = '9999-01-01'
and de.to_date = '9999-01-01'
group by de.dept_no
order by avg(salary) desc
limit 0,1
)
order by salary desc, emp_no
;


-- 2.16초 오래걸림 굳이 테이블 크게 사용 함
select e.emp_no ,  d.dept_name, concat(e.first_name, ' ', e.last_name) as name, t.title, s.salary
from departments d, employees e, titles t, dept_emp de, salaries s, ( select de.dept_no, avg(salary) as avg_salary
from dept_emp de, salaries s
where s.emp_no = de.emp_no
and s.to_date = '9999-01-01'
and de.to_date = '9999-01-01'
group by de.dept_no
order by avg_salary desc
limit 0,1
) highest_team
where highest_team.dept_no = de.dept_no
and de.emp_no = e.emp_no
and s.emp_no = de.emp_no
and t.emp_no = e.emp_no
and d.dept_no = de.dept_no
and t.to_date = '9999-01-01'
and de.to_date = '9999-01-01'
and s.to_date = '9999-01-01'
order by salary desc, emp_no
;


-- 문제6. sales 88852
-- 평균 연봉이 가장 높은 부서는?
-- 부서이름 평균 연봉 
select d.dept_name, avg(salary) as avg_salary
from departments d, dept_emp de, salaries s
where de.emp_no = s.emp_no
and de.dept_no = d.dept_no
and s.to_date = '9999-01-01'
and de.to_date = '9999-01-01'
group by de.dept_no
order by avg_salary desc
limit 0,1
;


-- 문제7. senior staff 80706
-- 평균 연봉이 가장 높은 직책?
-- 직책 이름 평균 연봉
select t.title, avg(salary) as avg_salary
from titles t, salaries s
where t.emp_no = s.emp_no
and s.to_date = '9999-01-01'
and t.to_date = '9999-01-01'
group by t.title
order by avg_salary desc
limit 0,1
;


-- 문제8.
-- 현재 자신의 매니저보다 높은 연봉을 받고 있는 직원은?
-- 부서이름, 사원이름, 연봉, 매니저 이름, 메니저 연봉 순으로 출력합니다.

-- sol1) 서브쿼리로 
-- from 절에 넣어서
explain select d.dept_name as '부서이름', concat(e.first_name,' ',e.last_name) as '사원이름',
		s.salary as '연봉', manager.name as '매니저 이름', manager.salary as '매니저 연봉'
from employees e, dept_emp de, departments d, salaries s, (
	select ms.salary, md.dept_no, concat(me.first_name,' ',me.last_name) as name
	from employees me, salaries ms, dept_manager md
	where me.emp_no = ms.emp_no
	and me.emp_no = md.emp_no
	and md.to_date = '9999-01-01'
	and ms.to_date = '9999-01-01'
) manager
where e.emp_no = de.emp_no
and de.dept_no = d.dept_no
and e.emp_no = s.emp_no
and s.to_date = '9999-01-01'
and de.to_date = '9999-01-01'
and manager.dept_no = d.dept_no
and manager.salary < s.salary
;




select d.dept_name as '부서이름', concat(e.first_name,' ',e.last_name) as '사원이름', s.salary as '연봉', 
		concat(me.first_name,' ',me.last_name) as '매니저이름', ms.salary as '매니저 연봉'
from departments d, 
	dept_emp de, employees e, salaries s, 
	employees me, salaries ms, dept_manager mde
where e.emp_no = de.emp_no
and e.emp_no = s.emp_no
and s.to_date = '9999-01-01'
and de.to_date = '9999-01-01'
and me.emp_no = mde.emp_no
and me.emp_no = ms.emp_no
and ms.to_date = '9999-01-01'
and mde.to_date = '9999-01-01'
and de.dept_no = d.dept_no
and mde.dept_no = d.dept_no
and s.salary > ms.salary
;

