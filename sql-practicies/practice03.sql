-- 테이블간 조인(JOIN) SQL 문제입니다.
--  
-- 문제 1.
-- 현재 급여가 많은 직원부터 직원의 사번, 이름, 그리고 연봉을 출력 하시오.
select s.emp_no as'사번', e.first_name as '이름', s.salary as '연봉'
from salaries s join employees e on s.emp_no = e.emp_no
order by s.salary desc
;

-- 문제2. 결과 42 
-- 전체 사원의 사번, 이름, 현재 직책을 이름 순서로 출력하세요.
select e.emp_no as '사번', concat(e.first_name,' ',e.last_name) as name, t.title
from employees e, titles t
where e.emp_no = t.emp_no
and t.to_date = '9999-01-01'
order by name
;


-- 문제3. 결과 41
-- 전체 사원의 사번, 이름, 현재 부서를 이름 순서로 출력하세요..
select e.emp_no as '사번', concat(e.first_name,' ',e.last_name) as name , d.dept_name
from employees e, departments d, dept_emp de
where e.emp_no = de.emp_no
and de.dept_no = d.dept_no
and de.to_date = '9999-01-01'
order by name
;


-- 문제4.
-- 전체 현재 사원의 사번, 이름, 연봉, 직책, 부서를 모두 이름 순서로 출력합니다.
select e.emp_no, concat(e.first_name,' ',e.last_name) as name, s.salary, t.title, d.dept_name
from employees e, salaries s, titles t, departments d, dept_emp de
where e.emp_no = s.emp_no 
and e.emp_no = de.emp_no
and e.emp_no = t.emp_no
and s.to_date = '9999-01-01'
and de.dept_no = d.dept_no
order by name;



-- 문제5.
-- 'Technique Leader'의 직책으로 과거에 근무한 적이 있는 모든 사원의 사번과 이름을 출력하세요.
-- (현재 'Technique Leader'의 직책으로 근무하는 사원은 고려하지 않습니다.)
select e.emp_no, concat(e.first_name,' ',e.last_name) as name
from employees e, titles t
where e.emp_no = t.emp_no
and t.title ='Technique Leader'
and t.to_date < now();

-- 문제6.
-- 직원 이름(last_name) 중에서 S(대문자)로 시작하는 직원들의 이름, 부서명, 직책을 조회하세요.
select concat(e.first_name,' ',e.last_name) as name,d.dept_name,  t.title
from employees e, titles t, departments d, dept_emp de
where e.emp_no = de.emp_no
and e.last_name like "S%"
and e.emp_no = t.emp_no
and de.dept_no = d.dept_no
order by name;


-- 문제7.
-- 현재, 직책이 Engineer인 사원 중에서 현재 급여가 40000 이상인 사원을 급여가 큰 순서대로 출력하세요.
--  projection: 사번 이름(first_name) 급여 타이틀
select concat(e.first_name,' ',e.last_name) as name, s.salary, t.title
from employees e, titles t, salaries s
where e.emp_no = t.emp_no
and e.emp_no = s.emp_no
and t.to_date = '9999-01-01'
and t.title like "%Engineer%"
and s.salary >= 40000
order by s.salary;

-- 문제8.
-- 현재 급여가 50000이 넘는 직책을 직책,  평균급여로 평균급여가 큰 순서대로 출력하시오
select t.title, avg(s.salary) as avg_salary
from employees e, titles t, salaries s
where e.emp_no = t.emp_no
and e.emp_no = s.emp_no
and t.to_date = '9999-01-01'
and s.salary >= 50000
group by t.title
order by t.title, avg_salary desc;


-- 문제9.
-- 현재, 부서별 평균 연봉을 연봉이 큰 부서 순서대로 출력하세요.
--  projection: 부서명 평균연봉
select d.dept_name, avg(s.salary) as avg_salary
from employees e, salaries s, departments d, dept_emp de
where e.emp_no = de.emp_no
and e.emp_no = s.emp_no
and de.dept_no = d.dept_no
and de.to_date = '9999-01-01'
group by de.dept_no
order by avg_salary desc;


-- 문제10.
-- 현재, 직책별 평균 연봉을 연봉이 큰 직책 순서대로 출력하세요.
-- projection: 직책명 평균연봉
select t.title, avg(s.salary) as avg_salary
from employees e, titles t, salaries s
where e.emp_no = t.emp_no
and e.emp_no = s.emp_no
and t.to_date = '9999-01-01'
group by t.title
order by avg_salary desc;
