-- 문제 1.
-- 최고임금(salary)과  최저임금을 “최고임금, “최저임금”프로젝션 타이틀로 함께 출력해 보세요.
-- 두 임금의 차이는 얼마인가요? 함께 “최고임금 – 최저임금”이란 타이틀로 출력해 보세요.
select max(salary) as "최고임금", min(salary) as "최저임금", max(salary)-min(salary) as "최고임금-최저임금"
from salaries;
 
-- 문제2.
-- 마지막으로 신입사원이 들어온 날은 언제 입니까? 다음 형식으로 출력해주세요.
-- 예) 2000년 01월 28일
 select date_format(max(hire_date),'%Y년 %m월 %d일')
 from employees;
 
 -- 문제3.
-- 가장 오래 근속한 직원의 입사일은 언제인가요? 다음 형식으로 출력해주세요.
-- 예) 1985년 01월 01일
 select emp_no, date_format(min(from_date),'%Y년 %m월 %d일'), max(to_date - from_date)
 from titles
 ;
 
SELECT emp_no, MIN(from_date) AS 입사일, MAX(to_date), max(to_date - from_date)
FROM salaries
GROUP BY emp_no
ORDER BY 입사일
LIMIT 1;

 
-- 문제4.
-- 현재 이 회사의 평균 연봉은 얼마입니까? 현재 > where 절 붙음
 select avg(salary)
 from salaries
 where to_date like '9999%';
 
 
-- 문제5.
-- 현재 이 회사의 최고/최저 연봉은 얼마입니까?
 select max(salary), min(salary)
 from salaries
 where to_date like '9999%';

 
-- 문제6.
-- 최고 어린 사원의 나이와 최 연장자의 나이는?
 select max(birth_date), min(birth_date), 
date_format(cast(now()as date)-max(birth_date), '%y' ) as '최연소', 
date_format(cast(now()as date)-min(birth_date), '%y') as '최연장'
from employees;

