-- 데이터 형식
-- 정수형

use market_db;
create table hongong4 (
	tinyint_col tinyint,
    smallint_col smallint,
    int_col int,
    bigint_col bigint);

insert into hongong4 values (127, 32767, 2147483647, 9000000000000000000);
-- 각 숫자에 1을 더하고 마지막 값에는 0을 더 붙임
insert into hongong4 values (128, 32768, 2147483648, 90000000000000000000);
-- out of range

-- 정수형에 UNSIGNED를 붙이면 범위가 0부터 지정된다.
-- eg ) tinyint -128 ~ 217, tinyint unsigned 0 ~ 255

-- 문자형
-- VARCHAR은 가변길이 문자형이므로, VARCHAR(10)에 '가나다' 3글자를 저장할 경우 3자리만 사용합니다.
-- 반면, 빠른 속도면에서는 CHAR로 설정하는 것이 좋습니다. CHAR는 글자의 개수가 고정된 경우, VARCHAR은 글자의 개수가 변동될 경우에 사용합니다.
-- 전화번호 국번의 경우 정수형으로 지정할 경우 제일 앞 0이 사라짐. 그래서 CHAR로 써야합니다.
-- 데이터 숫자 형태라도 연산이나 크기에 의미가 없다면 문자형으로 지정하는 것이 좋습니다.

-- 대량의 데이터 형식

-- char는 255자까지, varchar는 16383자까지 가능
create table big_table(
	data1 char(256),
    data2 varchar(16383) );
-- too big for column

-- blob은 binary long object의 약자로 글자가 아닌 이미지, 동영상 등의 데이터라고 생각하시면 됩니다. (이진데이터)
create database netflix_db;
use netflix_db;
create table movie (
	movie_id int,
    movie_title varchar(30),
    movie_director varchar(20),
    movie_star varchar(20),
    movie_script longtext, -- 최대 4gb
    movie_film longblob -- 최대 4gb
);

-- 실수형 (소수점이 있는 숫자를 저장할 때 사용)

-- 변수의 사용
use market_db;
set @myvar1 = 5;
set @myvar2 = 4.25;

select @myvar1;
select @myvar1 + @myvar2;

set @txt = '가수 이름 ==> ' ;
set @height = 166 ;
select @txt, mem_name from member where height > @height;

set @count=3
select mem_name, height from member order by height limit @count;
-- error in sql syntax (limit에는 변수를 사용할 수 없음)

-- prepare ~ execute문으로 오류 해결
set @count=3;
prepare mySQL from 'select mem_name, height from member order by height limit ?';
execute mySQL using @count;

-- 데이터 형 변환
-- 함수를 이용한 '명시적 변환'

select avg(price) as '평균 가격' from buy;
select cast(avg(price) as signed) '평균 가격' from buy; -- singed = 부호가 있는 정수
select convert(avg(price), signed) '평균 가격' from buy;

select cast('2022$12$12' as date);
select cast('2022/12/12' as date);
select cast('2022%12%12' as date);
select cast('2022@12@12' as date);

select num, concat(cast(price as char), 'X', cast(amount as char), '=')
	'가격X수량', price*amount '구매액'
    from buy;
    
-- 암시적인 변환
select '100' + '200';
select concat('100','200');

select concat(100, '200');
select 100 + '200'; -- 숫자와 문자를 연산할 때, concat()을 사용하면 숫자가 문자로 변하고, 더하기만 사용하면 문자가 숫자로 변한 후에 연산됩니다.