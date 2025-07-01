use market_db;
select mem_id, mem_name, addr from member;

-- 뷰의 기본 생성
use market_db;
create view v_member
as
	select mem_id, mem_name, addr from member;
    
select * from v_member;
select mem_name, addr from v_member
	where addr in ('서울', '경기');

use market_db;
select B.mem_id, M.mem_name, B.prod_name, M.addr, concat(M.phone1, M.phone2) '연락처'
	from buy B
    inner join member M
    on B.mem_id = M.mem_id;

create view v_memberbuy
as
select B.mem_id, M.mem_name, B.prod_name, M.addr, concat(M.phone1, M.phone2) '연락처'
	from buy B
    inner join member M
    on B.mem_id = M.mem_id;	
    
select * from v_memberbuy where mem_name = '블랙핑크';

-- 뷰의 실제 작동
-- 뷰의 실제 생성, 수정, 삭제

use market_db;
create view v_viewtest1
as
	select B.mem_id 'Member ID', M.mem_name as 'Member Name',
			B.prod_name "Product name", concat(M.phone1, M.phone2) as "Office Phone"
	from buy B
    inner join member M
    on B.mem_id = M.mem_id;
    
select distinct `Member ID`, `Member Name` from v_viewtest1; -- 백틱을 사용한다!
-- 뷰를 생성할 때 뷰의 열 이름을 테이블과 다르게 지정할 수 있으며, 띄어쓰기나 한글도 가능합니다.

alter view v_viewtest1
as
	select B.mem_id '회원 아이디', M.mem_name as '회원 이름',
			B.prod_name "제품 이름", concat(M.phone1, M.phone2) as "연락처"
	from buy B
		inner join member M
        on B.mem_id = M.mem_id;

select distinct `회원 아이디`, `회원 이름` from v_viewtest1;

drop view v_viewtest1;

-- 뷰의 정보 확인

use market_db;
create or replace view v_viewtest2
as
	select mem_id, mem_name, addr from member;
    
desc v_viewtest2; -- PRIMARY KEY 등의 정보 알 수 없음
desc member;
show create view v_viewtest2; -- 뷰의 소스 코드를 확인할 수 있다.

-- 뷰를 통한 데이터의 수정/삭제
update v_member set addr = '부산' where mem_id = 'BLK';
insert into v_member(mem_id, mem_name, addr) values('BTS', '방탄소년단', '경기');
-- doesn't have a default option(오류)
-- 뷰를 통해서 데이터를 입력하려면, 뷰에서 보이지 않는 테이블의 열에 NOT NULL이 없어야 합니다.(mem_number이 not null임)

create view v_height167
as
	select * from member where height >= 167;    
select * from v_height167;

delete from v_height167 where height < 167;

-- 뷰를 통한 데이터 입력
insert into v_height167 values('TRA', '티아라', 6, '서울', null, null, 159, '2005-01-01');
-- 159인데도 값이 입력된 것을 보임
select * from v_height167;
-- 티아라 값은 보이지 않음

alter view v_height167
as
	select * from member where height >= 167
		with check option; -- 뷰에 설정된 조건만 입력되도록 함
        
insert into v_height167 values('TOB', '텔레토비', 4, '영국', NULL, NULL, 140, '1995-01-01');
-- check option failed(오류)

-- 하나의 테이블로 만든 뷰를 '단순 뷰', 두 개 이상의 테이블로 만든 뷰를 '복합 뷰', '복합 뷰'는 읽기 전용 (입력/수정/삭제 불가)
create view v_complex
as
	select B.mem_id, M.mem_name, B.prod_name, M.addr
		from buy B
        inner join member M
        on M.mem_id = B.mem_id;
	
-- 뷰가 참조하는 테이블의 삭제
drop table if exists buy, member;
select * from v_height167;
-- references invalid table(s) (오류)

check table v_height167; -- 뷰의 상태 확인하기