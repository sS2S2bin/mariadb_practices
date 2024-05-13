-- 문자함수

-- upper
select upper('seoul'), ucase('SeouL') from dual;

-- lower
select lower('SOEUDL') , lcase('SEod') from dual;


-- substring(문자열, Index, length)
select substring('helloworld',3,2);

-- ㅇㅖ제 1989에 입사한 직원 이름, 입사일
select first_name, hire_date
from employees
where substring(hire_date, 1,4)='1989';

-- lpad(오른쪽 정렬) rpad(왼쪽 정렬)
select lpad('1234',10,'-'), lpad('1234',3,'-') from dual;

-- trim, ltrim, rtim
select concat("----",ltrim('  hello.  '),"---")
,concat("----",trim(leading 'x' from 'xxxxxhelloxxxxx'),"---")
,concat("----",trim(trailing 'x' from 'xxxxxhelloxxxxx'),"---")
,concat("----",trim(both 'x' from 'xxxxxhelloxxxxx'),"---")  from dual;


