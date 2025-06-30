-- SQL로 테이블 만들기
-- 데이터베이스 생성하기

drop database if exists naver_db;
create database naver_db;

-- 테이블 생성하기
-- member 테이블 만들기
use naver_db;
drop table if exists member;
create table member -- 회원 테이블
(mem_id	char(8), -- 회원 아이디(PK)
mem_name	varchar(10), -- 이름
mem_number	tinyint, -- 인원수
addr	char(2), -- 주소(경기, 서울, 경남 식으로 2글자만 입력)
phone1	char(3), -- 연락처의 국번(02, 031, 055 등)
phone2	char(8), -- 연락처의 나머지 전화번호(하이픈 제외)
height tinyint unsigned, -- 평균 키
debut_date	date -- 데뷔 일자
);

drop table if exists member; -- 기존에 있으면 삭제
create table member -- 회원 테이블
(mem_id	char(8) not null, -- 회원 아이디(PK)
mem_name	varchar(10) not null, -- 이름
mem_number	tinyint not null, -- 인원수
addr	char(2) not null, -- 주소(경기, 서울, 경남 식으로 2글자만 입력)
phone1	char(3) null, -- 연락처의 국번(02, 031, 055 등)
phone2	char(8) null, -- 연락처의 나머지 전화번호(하이픈 제외)
height tinyint unsigned null, -- 평균 키
debut_date	date null -- 데뷔 일자
);

drop table if exists member; -- 기존에 있으면 삭제
create table member -- 회원 테이블
(mem_id	char(8) not null primary key, -- 회원 아이디(PK)
mem_name	varchar(10) not null, -- 이름
mem_number	tinyint not null, -- 인원수
addr	char(2) not null, -- 주소(경기, 서울, 경남 식으로 2글자만 입력)
phone1	char(3) null, -- 연락처의 국번(02, 031, 055 등)
phone2	char(8) null, -- 연락처의 나머지 전화번호(하이픈 제외)
height tinyint unsigned null, -- 평균 키
debut_date	date null -- 데뷔 일자
);

-- buy 테이블 만들기
drop table if exists buy; -- 기존에 있으면 삭제
create table buy -- 구매 테이블
( num		int auto_increment not null primary key, -- 순번(PK)
 mem_id		char(8) not null, -- 아이디(FK)
 prod_name	char(6) not null, -- 제품 이름
 group_name char(4) null, -- 분류
 price		int unsigned not null, -- 가격
 amount		smallint unsigned not null -- 수량
 );
 
drop table if exists buy; -- 기존에 있으면 삭제
create table buy -- 구매 테이블
( num		int auto_increment not null primary key, -- 순번(PK)
 mem_id		char(8) not null, -- 아이디(FK)
 prod_name	char(6) not null, -- 제품 이름
 group_name char(4) null, -- 분류
 price		int unsigned not null, -- 가격
 amount		smallint unsigned not null, -- 수량
 foreign key(mem_id) references member(mem_id)
 );
 
 -- 데이터 입력하기
 insert into member values('TWC', '트와이스', 9, '서울', '02', '11111111', 167, '2015-10-19');
 insert into member values('BLK', '블랙핑크', 4, '경남', '055', '22222222', 163, '2016-8-8');
 insert into member values('WMN', '여자친구', 6, '경기', '031', '33333333', 166, '2015-1-15');
-- DATE로 지정된 열에는 연.월.일 또는 연-월-일 형식으로 값을 입력합니다.

insert into buy values(null, 'BLK', '지갑', null, 30, 2);
insert into buy values(null, 'BLK', '맥북프로', '디지털', 1000, 1);
insert into buy values(null, 'APN', '아이폰', '디지털', 200, 1);
-- 오류 ('APN'은 회원 테이블에 없기 때문임 --> buy 외래키)