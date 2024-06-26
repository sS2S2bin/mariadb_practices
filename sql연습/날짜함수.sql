
-- 날짜 함수
-- curdate(), current_date
select curdate(), current_date from dual;

-- curtime(), current_time
select curtime(), current_time from dual;

-- now() vs sysdate()
select now(), sysdate() from dual;
select now(), sleep(2), now() from dual; -- 차이 x 쿼리가 실행된 타임이 나오기 때문
select now(), sleep(2), sysdate() from dual; -- 차이 o 그 함수가 호출 된 타임 


-- date_format
-- default format : %
select date_format(now(),'%Y년 %m월 %d일 %h시 %i분 %s초') from dual;
select date_format(now(), '%d %b \ %y %h: %i%s') from dual;


-- period_diff
-- 예제) 근무개월
-- 		포맷팅 : YYMM
select first_name, 
		hire_date,
        period_diff(date_format(curdate(),'%y%m'), date_format(hire_date, '%y%m')) as Month
	from employees;
    
    
--  date_add(=adddate), date_sub(=subdate)
-- 날짜를 date 타입의 컬럼이나 값에 type(year,month, day)의 표현식으로 더하거나 뺄 수 있다.
-- 예제) 각 사원의 근속 연수가 5년이 되는 날에 휴가를 보내준다면 각 사원의 5년 근속 휴가 날짜는?
select first_name,
		hire_date, 
        date_add(hire_date, interval 5 year)
	from employees;
