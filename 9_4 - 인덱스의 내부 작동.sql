-- 클러스터형 인덱스 구성하기
use market_db;
drop table cluser;
create table cluster -- 클러스터형 인덱스를 테스트하기 위한 테이블
( mem_id char(8),
  mem_name varchar(10)
);
insert into cluster values('TWC', '트와이스');
insert into cluster values('BLK', '블랙핑크');
insert into cluster values('WMN', '여자친구');
insert into cluster values('OMY', '오마이걸');
insert into cluster values('GRL', '소녀시대');
insert into cluster values('ITZ', '잇지');
insert into cluster values('RED', '블랙벨벳');
insert into cluster values('APN', '에이핑크');
insert into cluster values('SPC', '우주소녀');
insert into cluster values('MMU', '마마무');

select * from cluster;

alter table cluster
	add constraint
	primary key (mem_id);
select * from cluster;
-- 클러스터형 인덱스 구조는 리프 페이지가 데이터 페이지 역할을 같이 한다.

-- 보조 인덱스 구성하기
use market_db;
create table second -- 보조 인덱스를 테스트하기 위한 테이블
(mem_id char(8),
 mem_name varchar(10)
);
insert into second values('TWC', '트와이스');
insert into second values('BLK', '블랙핑크');
insert into second values('WMN', '여자친구');
insert into second values('OMY', '오마이걸');
insert into second values('GRL', '소녀시대');
insert into second values('ITZ', '잇지');
insert into second values('RED', '레드벨벳');
insert into second values('APN', '에이핑크');
insert into second values('SPC', '우주소녀');
insert into second values('MMU', '마마무');
alter table second
	add constraint
	unique(mem_id);
select * from second;