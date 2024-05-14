    
-- cast
select date_format(cast('2013-01-09' as date), '%y년 %m월 %d일') from dual;
select '12345'+'10', cast('12345'as int) + 10 from dual;
select cast(cast(1-2 as unsigned) as signed) from dual;


-- type
-- 문자 varchar(4000), char 고정 길이 일때 사용
