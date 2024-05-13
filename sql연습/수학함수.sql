-- 수학함수

-- abs 
select abs(1), abs(-1) from dual;

-- ceil
select ceil(2.3), ceil(2.764) from dual;

-- floor
select floor(3.14) from dual;

-- mod 
select mod(10,3) , 10%3 from dual;

-- round(x) : x에 가장 근접한 정수
-- round(x,d) : x값 중에 소수점 d자리에 가장 근접한 실수 
select round(1.498), round(1.511), round(1.498,1) from dual; 

-- power(x,y) pow(x,y) x^y
select power(2,10), pow(2,10) from dual;

-- sign(x); 양수:1 음수:-1 0:1
select sign(20), sign(-199), sign(0) from dual;

-- greatest(x,y,...) least(x,y,...)
select greatest(10,29,40,50), least(10,30,20,40) from dual;
select greatest('a','A','b','c'), least('a','A','b','c') from dual;