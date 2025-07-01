-- 기본 키 제약조건 (= 클러스터형 인덱스가 자동으로 생성된다.)

-- CREATE TABLE에서 설정하는 기본 키 제약조건
use naver_db;
drop table if exists buy, member;
create table member
( mem_id		char(8) not null primary key,
mem_name		varchar(10) not null,
height			tinyint unsigned null
);

desc member;

-- 기본 키를 지정하는 다른 방법
drop table if exists buy, member;
create table member
( mem_id		char(8) not null,
mem_name		varchar(10) not null,
height			tinyint unsigned null,
primary key (mem_id)
);

-- ALTER TABLE에서 설정하는 기본 키 제약조건
drop table if exists member;
create table member
( mem_id	char(8) not null,
mem_name	varchar(10) not null,
height		tinyint unsigned null
);
alter table member
	add constraint
    primary key (mem_id);
    
-- CREATE TABLE에서 설정하는 외래 키 제약조건
drop table if exists buy, member;
create table member
(mem_id	char(8) not null primary key,
mem_name varchar(10) not null,
height tinyint unsigned null);
create table buy
(num int auto_increment not null primary key,
mem_id char(8) not null,
prod_name char(6) not null,
foreign key(mem_id) references member(mem_id)
);

-- ALTER TABLE에서 설정하는 외래 키 제약조건
drop table if exists buy;
create table buy
( num int auto_increment not null primary key,
  mem_id char(8) not null,
  prod_name char(6) not null
  );
	alter table buy
    add constraint
    foreign key(mem_id) references member(mem_id);

-- 기준 테이블의 열이 변경될 경우
insert into member values('BLK', '블랙핑크', 163);
insert into buy values(null, 'BLK', '지갑');
insert into buy values(null, 'BLK', '맥북');

select M.mem_id, M.mem_name, B.prod_name
	from member M
    inner join buy B
    on B.mem_id = M.mem_id;

-- 'BLK'의 아이디를 'PINK'로 변경하면 오류가 발생한다.
update member set mem_id = 'PINK' where mem_id = 'BLK';
-- (기본 키 - 외래 키로 맺어진 후에는 기준 테이블의 열 이름이 변경되지 않습니다.)
-- (만약 BLK가 물건을 구매한 적이 없다면(구매 테이블에 데이터가 없다면) 회원 테이블의 BLK는 변경 가능합니다.)

delete from member where mem_id = 'BLK';
-- (같은 오류로 삭제 불가)

-- 오류 해결법
drop table if exists buy;
create table buy
( num	int auto_increment not null primary key,
  mem_id	char(8) not null,
  prod_name char(6) not null
);
alter table buy
	add constraint
	foreign key(mem_id) references member(mem_id)
    on update cascade
    on delete cascade;
    
insert into buy values(null, 'BLK', '지갑');
insert into buy values(null, 'BLK', '맥북');

update member set mem_id = 'PINK' where mem_id = 'BLK';
select M.mem_id, M.mem_name, B.prod_name
	from buy B
		inner join member M
        on B.mem_id = M.mem_id;
        
delete from member where mem_id='PINK';
select * from buy;

-- 기타 제약조건
-- 고유 키 제약조건 (중복은 허용하지 않지만, 비어 있는 값은 허용함, 여러개 지정 가능)
drop table if exists buy, member;
create table member
( mem_id char(8) not null primary key,
  mem_name varchar(10) not null,
  height tinyint unsigned null,
  email char(30) null unique
);

insert into member values('BLK', '블랙핑크', 163, 'pink@gmail.com');
insert into member values('TWC', '트와이스', 167, null);
insert into member values('APN', '에이핑크', 164, 'pink@gmail.com');
-- Duplicate entry (오류)
  
-- 체크 제약조건
drop table if exists member;
create table member
(mem_id char(8) not null primary key,
 mem_name varchar(10) not null,
 height tinyint unsigned null check(height>=100),
 phone1 char(3) null
);

insert into member values('BLK', '블랙핑크', 163, NULL);
insert into member values('TWC', '트와이스', 99, NULL);
-- check constraint is violated (오류)

alter table member
	add constraint
    check (phone1 in ('02', '031', '032', '054', '055', '061'));
    
insert into member values('TWC', '트와이스', 167, '02');
insert into member values('OMY', '오마이걸', 167, '010');
-- check constraint is violated (오류)

-- 기본값 정의
drop table if exists member;
create table member
( mem_id char(8) not null primary key,
  mem_name varchar(10) not null,
  height tinyint unsigned null default 160,
  phone1 char(3) null
);

-- ALTER TABLE 사용 시 열에 DEFAULT를 지정하기 위해서는 ALTER COLUMN 문을 사용합니다.
alter table member
	alter column phone1 set default '02';
    
insert into member values('RED', '레드벨벳', 161, '054');
insert into member values('SPC', '우주소녀', default, default);
select * from member;