use market_db;
create table table1 (
	col1 int primary key, -- 기본 키로 지정
    col2 int,
    col3 int
);

show index from table1;

create table table2 (
	col1 int primary key,
    col2 int unique, -- 고유 키로 지정
    col3 int unique -- 고유 키로 지정
);
show index from table2;

-- 자동으로 정렬되는 클러스터형 인덱스
use market_db;
drop table if exists buy, member;
create table member
( mem_id char(8),
  mem_name varchar(10),
  mem_number int,
  addr char(2)
);

insert into member values('TWC', '트와이스', 9, '서울');
insert into member values('BLK', '블랙핑크', 4, '경남');
insert into member values('WMN', '여자친구', 6, '경기');
insert into member values('OMY', '오마이걸', 7, '서울');
select * from member;

alter table member
	add constraint
	primary key(mem_id);
select * from member;

alter table member drop primary key; -- 기본 키 제거
alter table member
	add constraint
	primary key(mem_name); -- 클러스터형 인덱스 생성
select * from member;

insert into member values('GRL', '소녀시대', 8, '서울');
select * from member;

-- 정렬되지 않는 보조 인덱스(UNIQUE)
drop table if exists member;
create table member(
	mem_id char(8),
    mem_name varchar(10),
    mem_number int,
    addr char(2)
);

insert into member values('TWC', '트와이스', 9, '서울');
insert into member values('BLK', '블랙핑크', 4, '경남');
insert into member values('WMN', '여자친구', 6, '경기');
insert into member values('OMY', '오마이걸', 7, '서울');
select * from member;

alter table member
	add constraint
    unique (mem_name);
select * from member;

alter table member
	add constraint
    unique (mem_id);
select * from member;

insert into member values('GRL', '소녀시대', 8, '서울');
select * from member;