-- select 연습

-- 예제1: departments 테이블의 모든 데이터를 출력
select * from departments;

-- 프로젝션(projection)
-- 예제 2: employees 테이블에서 직원 일므, 성별, 입사일 출력
select first_name, gender, hire_date
from employees limit 0,100 ;


-- 예제 3 employees 테이블에서 직원의 이름, 성별, 입사일을 출력
select first_name as 이름, gender '성별', hire_date '입사일'
from employees;

select concat(first_name, ' ', last_name) as 이름, gender '성별', hire_date '입사일'
from employees;

-- distinct
-- 예제 4 title 테이블에서 모든 직급의 이름 출력
select distinct (title)
from titles;


-- 비교연산자
-- 예제 1 1991년 이전 입사한 직원 이름 성별 입사일
select concat(first_name, ' ', last_name) as 이름, gender '성별', hire_date '입사일'
from employees
where hire_date < '1991-00-00';

-- 논리연산자
-- 예제 2 1989 년 이전 입사 여직원 이름, 입사일 
select concat(first_name, ' ', last_name) as 이름, gender '성별', hire_date '입사일'
from employees
where hire_date < '1989-01-01' and gender='F';

-- in 연산자
-- 예제 3: dept_emp 테이블에서 부서번호가 d005이거나 d009 에 속환 사원의 사번 
select emo_no, dept_no
from dept_emp
where dept_no in('d005','d009') ;


-- like 검색
-- employees 테이블에서 89년에 입사한 직원 이름 입사일 출력, 

select first_name, hire_data
from employees
where hire_date like '1989-%';
-- where hire_date between '1989-01-01' and'1989-12-31';
-- where '1989-01-01'<=hire_date and hire_date<='1989-12-31';

-- 2001년 월갑 가장 높은 순 사번
select emp_no, salary
from salaries
where from_date like '2001%'
or to_date like '2001%'
order by salary desc;


-- 예제 3 남자직원 이름 성별 입사일 입사일(선임)순으로 출력

select first_name, gender, hire_date
from employees
where gender = 'm'
order by hire_date asc;

-- 예제 4 직원의 사번, 월급 사번 asc, 월급 asc

select emp_no, salary
from salaries
order by emp_no asc, salary desc;
