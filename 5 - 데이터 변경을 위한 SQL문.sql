-- 데이터 입력 INSERT
use market_db;
create table hongong1 (toy_id int, toy_name char(4), age int);
insert into hongong1 values (1, '우디', 25);
insert into hongong1 (toy_id, toy_name) values (2, '버즈');
insert into hongong1 (toy_name, age, toy_id) values ('제시', 20, 3);
-- 자동으로 증가하는 AUTO_INCREMENT
create table hongong2 (
	toy_id int auto_increment primary key,
    toy_name char(4),
    age int);

insert into hongong2 values (null, '보핍', 25);
insert into hongong2 values (null, '슬링키', 22);
insert into hongong2 values (null, '렉스', 21);
select * from hongong2;
-- 자동 증가하는 부분은 NULL 값으로 채워 놓으면 된다.

-- 자동 증가가 어느정도까지 진행됐는지 확인하는 방법
select last_insert_id();

-- auto_increment로 입력되는 다음 값을 100부터 시작되도록 변경하고 싶을 경우
alter table hongong2 auto_increment=100;
insert into hongong2 values (null, '재남', 35);
select * from hongong2;

-- 시스템 변수 @@auto_increment_increment 변경
create table hongong3 (
	toy_id int auto_increment primary key,
    toy_name char(4),
    age int);
alter table hongong3 auto_increment = 1000;
set @@auto_increment_increment = 3;

-- 시스템 변수 보기 (개수는 500개 이상)
show global variables;

insert into hongong3 values (null, '토마스', 20);
insert into hongong3 values (null, '제임스', 23);
insert into hongong3 values (null, '고든', 25);
select * from hongong3;

-- 다른 테이블의 데이터를 한 번에 입력하는 insert into ~ select (열 개수는 동일해야함)
select count(*) from world.city;
-- desc명령으로 테이블 구조 출력
desc world.city;
select * from world.city limit 5;
create table city_popul (city_name char(35), population int);
-- insert into ~ select 실행
insert into city_popul
	select name, population from world.city;
    
-- 데이터 수정 : UPDATE
USE market_db;
update city_popul
	set city_name = '서울'
    where city_name = 'Seoul';
select * from city_popul where city_name = '서울';

update city_popul
	set city_name = '뉴욕', population = 0
    where city_name = 'New York';
select * from city_popul where city_name = '뉴욕';

-- 다음의 SQL은 문제가 있으니 실행 X! (where절이 없기 때문에 도시 이름의 모든 열을 서울로 바꿔버림)
update city_popul
	set city_name = '서울';    

update city_popul
	set population = population / 10000;
select * from city_popul limit 5;

-- 데이터 삭제 : DELETE
delete from city_popul
	where city_name like 'NEW%';
    
delete from city_popul
	where city_name like 'New%'
    limit 5;
    
-- 대용량 테이블의 삭제
create table big_table1 (select * from world.city, sakila.country);
create table big_table2 (select * from world.city, sakila.country);
create table big_table3 (select * from world.city, sakila.country);
select count(*) from big_table1;
-- DROP은 테이블 자체를 없애버린다. (TRUNCATE와 DELETE는 빈 테이블은 남긴다.)
-- TRUNCATE는 DELETE와 달리 WHERE 문을 사용할 수 없다. 조건 없이 전체 행을 삭제할 때만 사용한다.
delete from big_table1; -- 3.390 sec  -- 가장 비효율 비추천
drop table big_table2; -- 0.047 sec  -- 테이블 필요없을 때 쓰기
truncate table big_table3; -- 0.063 sec -- 빈 테이블이라도 필요하면 쓰기