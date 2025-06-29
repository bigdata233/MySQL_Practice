use market_db;
select * from member;
-- 위의 쿼리는 아래와 같다.
select * from market_db.member;
--
select mem_name from member;
select addr, debut_date, mem_name from member;
-- alias 부여하기(별칭에 공백이 있다면 큰따옴표로 묶어준다.)
select addr 주소, debut_date "데뷔 일자", mem_name from member;
-- 기본적인 where절
select * from member where mem_name = '블랙핑크';
select * from member where mem_number = 4;
-- 관계 연산자, 논리 연산자의 사용
select mem_id, mem_name
	from member
	where height <= 162;
select mem_name, height, mem_number
		from member
        where height >= 165 and mem_number > 6;
select mem_name, height, mem_number
		from member
        where height >= 165 or mem_number > 6;
-- BETWEEN ~ AND        
select mem_name, height
		from member
        where height >= 163 and height <= 165;
select mem_name, height
		from member
        where height between 163 and 165;
-- IN()
select mem_name, addr
		from member
        where addr = '경기' or addr = '전남' or addr = '경남'; 
select mem_name, addr
		from member
        where addr in('경기', '전남', '경남');
-- LIKE
select *
	from member
    where mem_name like '우%';
select *
	from member
    where mem_name like '__핑크';
-- sub query
select height from member where mem_name = '에이핑크';
select mem_name, height from member where height > 164;
select mem_name, height from member 
	where height > (select height from member where mem_name = '에이핑크');