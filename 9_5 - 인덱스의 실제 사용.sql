-- 인덱스 생성 실습
use market_db;
select * from member;

show index from member;
show table status like 'member';

create index idx_member_addr
	on member (addr);

show index from member;
show table status like 'member'; -- index_length가 0으로 나옴

analyze table member; -- index_length 갱신하기 위해 필수
show table status like 'member'; -- index_length가 16384로 나옴 (보조 인덱스가 1건이면 최소 1페이지가 필요하기 때문에)

create unique index idx_member_mem_number
	on member (mem_number); -- duplicate entry '4' (오류)
create unique index idx_member_mem_name
	on member (mem_name);
    
show index from member;

insert into member values('MOO', '마마무', 2, '태국', '001', '12341234', 155, '2020.10.10');
-- 고유 보조 인덱스 mem_name에 '마마무' 중복으로 duplicate entry 오류

-- 인덱스 활용 실습
analyze table member;
show index from member;

select * from member; -- Full table scan
select mem_id, mem_name, addr from member; -- Full table scan
select mem_id, mem_name, addr from member where mem_name = '에이핑크'; -- Single Row(Constant)

create index idx_member_mem_number
	on member (mem_number);
analyze table member; -- 인덱스 적용

select mem_name, mem_number
	from member
	where mem_number >= 7; -- Index Range Scan

-- 인덱스를 사용하지 않을 때
select mem_name, mem_number
	from member
	where mem_number >=1; -- Full table scan (인덱스가 있어도 MySQL이 판단해서 사용하지 않을 수 있다.)
    
select mem_name, mem_number
	from member
    where mem_number * 2 >= 14; -- Full table scan
-- where 절에 연산을 하면 인덱스를 사용하지 않습니다.    
select mem_name, mem_number
	from member
    where mem_number >= 14/2; -- Index Range scan

-- 인덱스 제거 실습
show index from member;
-- 클러스터형 인덱스와 보조 인덱스가 섞여 있을 때는 보조 인덱스를 먼저 제거하는 것이 좋습니다.
-- 클러스터형 인덱스를 먼저 제거해도 되지만, 데이터를 쓸데없이 재구성해서 시간이 더 오래 걸립니다.

drop index idx_member_mem_name on member;
drop index idx_member_addr on member;
drop index idx_member_mem_number on member


alter table member
	drop primary key;
-- Primary key에 설정된 인덱스는 drop index 문으로 제거되지 않고 alter talbe 문으로만 제거할 수 있습니다.
-- (오류) buy가 mem_id열을 참조하고 있기 때문에 외래 키 관계를 제거해야함.

select table_name, constraint_name
	from information_schema.referential_constraints
    where constraint_schema = 'market_db';
-- 외래키를 조회하는 구문 (외워야함)

alter table buy
	drop foreign key buy_ibfk_1;
alter table member
	drop primary key;
-- 기본 키를 제거하려면 먼저 관련된 외래 키를 제거해야 합니다.