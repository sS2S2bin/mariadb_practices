--
-- inner join
-- 

-- 예제1) 현재, 근무하고 있는 직원의 이름과 직책을 모두 출력하세요 
select employees.first_name, titles.title
from employees, titles 
where employees.emp_no = titles.emp_no -- join 조건(n-1)
and titles.to_date like '9999%' -- row 선택 조건
;

-- 예제2) 현재, 근무하고 있는 직원의 이름과 직책을 모두 출력하되, 여성 엔지니어(Engineer)만 출력하시요
select a.first_name, b.title
from employees a, titles b
where a.emp_no = b.emp_no -- join 조건(n-1)
and b.to_date like '9999%' -- row 선택 조건
and a.gender = 'f'
and b.title = 'Engineer'
;

--
-- ANSI/ISO SQL1999 Join 표준문법
--


-- 실습문제
-- 현재 직원별 근무 부서 출력해보세요
-- 사번, 직원(first_name), 부서명 순으로 출력하세요
select e.emp_no, e.first_name, d.dept_name
from employees e, dept_emp de, departments d
where e.emp_no = de.emp_no
and de.dept_no = d.dept_no
and de.to_date like '9999%'
;


-- 실습문제 2
-- 현재 지급되고있는 급여를 출력
-- 사번 이름 급여 
select e.emp_no, e.first_name, s.salary
from employees e, salaries s
where e.emp_no = s.emp_no
and s.to_date like '9999%'
;

-- 1) natural join
-- 조인대상이 되는 두 테이블에 이름이 같은 공통 칼럼이 있으면
-- 조인 조건을 명시하지 않고 암묵적으로 조인이 된다.
select a.first_name , b.title
from employees a natural join titles b
where b.to_date like'9999%'
;

-- join ~ using
-- natural join 문제점
select count(*)
from salaries a natural join titles b
where a.to_date = '9999-01-01'
and b.to_date = '9999-01-01'
;


-- join ~ using
select count(*)
from salaries a join titles b using(emp_no)
where a.to_date = '9999-01-01'
and b.to_date = '9999-01-01'
;

-- join ~ on
-- 예제 현재 직책별 평균 연봉을 큰순서대로 출력 하세요
select t.title, avg(s.salary)
from salaries s join titles t  on t.emp_no = s.emp_no
where s.to_date = '9999-01-01' and t.to_date = '9999-01-01'
group by t.title
order by avg(s.salary);


-- 실습문제3
-- 현재, 직책별 평균연봉과 직원수를 구하되 직원수가 100명 이상인 직책만 출력
-- projection : 직책 평균연봉 직원수
select t.title, avg(s.salary), count(*) as cnt_title
from salaries s join titles t on t.emp_no = s.emp_no
where s.to_date = '9999-01-01' and t.to_date = '9999-01-01'
group by t.title
having cnt_title >= 100
;


-- 실습문제 4
-- 현재 부서별로 직책 engineer 인 직원들에 대해서만 평균 연봉
-- projection : 부서이름 평균급여

select a.dept_name, avg(d.salary) 
from departments a, dept_emp b, titles c, salaries d
where a.dept_no = b.dept_no
and b.emp_no = c.emp_no
and c.emp_no = d.emp_no
and b.to_date - '9999-01-01'
and c.to_date - '9999-01-01'
and d.to_date - '9999-01-01'
and c.title = 'Engineer'
group by a.dept_name
order by avg(d.salary) desc;
;
