-- SQL 프로그래밍

-- if문의 기본 형식
drop procedure if exists ifProc1;
delimiter $$
create procedure ifProc1()
begin
	if 100=100 then
    select '100은 100과 같습니다.';
    end if;
end $$
delimiter ;
call ifProc1();

-- 다른 프로그래밍 언어에서는 같다는 의미로 ==을 사용하지만, SQL은 =을 사용합니다.
-- 그리고 SELECT 뒤에 문자가 나오면 그냥 화면에 출력해줍니다. 다른 언어의 print()와 비슷한 기능을 합니다.

-- if ~ else문
drop procedure if exists ifProc2;
delimiter $$
create procedure ifProc2()
begin
	declare myNum INT;
    set myNum = 200;
    if myNum = 100 then
		select '100입니다.';
	else
		select '100이 아닙니다.';
	end if;
end $$
delimiter ;
call ifProc2();

-- if 문의 활용
drop procedure if exists ifProc3;
delimiter $$
create procedure ifProc3()
begin
	declare debutdate date; -- 데뷔일자
    declare curDate date; -- 오늘
    declare days int; -- 활동한 일수
   
    select debut_date into debutdate
    from market_db.member
    where mem_id = 'APN';
    set curDate = CURRENT_DATE(); -- 현재 날짜
    set days = DATEDIFF(curDATE, debutDate); -- 날짜의 차이, 일 단위
    
    if (days/365) >= 5 then -- 5년이 지났다면
		select concat('데뷔한 지', days, '일이나 지났습니다. 핑순이들 축하합니다!');
	else
		select '데뷔한 지' + days + '일밖에 안되었네요. 핑순이들 화이팅~';
	end if;
end $$
delimiter ;
call ifProc3();

-- 날짜 관련 함수
select current_date(), current_timestamp(), datediff('2021-12-31', '2000-1-1');

-- CASE 문 (CASE 문의 기본 형식)
drop procedure if exists caseProc;
delimiter $$
create procedure caseProc()
begin
	declare point int;
    declare credit char(1);
    set point = 88;
    
    case
		when point >= 90 then
			set credit = 'A';
		when point >= 80 then
			set credit = 'B';
		when point >= 70 then
			set credit = 'C';
		when point >= 60 then
			set credit = 'D';
		else
			set credit = 'F';
	end case;
    select concat('취득점수==>', point), concat('학점==>', credit);
end $$
delimiter ;
call caseProc();

-- CASE 문의 활용
select mem_id, sum(price*amount) "총구매액"
	from buy
    group by mem_id;

select mem_id, sum(price*amount) "총구매액"
	from buy
    group by mem_id
    order by sum(price*amount) desc;
    
select B.mem_id, M.mem_name, sum(price*amount) "총구매액"
	from buy B
		inner join member M
        on B.mem_id = M.mem_id
	group by B.mem_id
    order by sum(price*amount) desc;
    
select M.mem_id, M.mem_name, sum(price*amount) "총구매액"
	from buy B
		right outer join member M
		on B.mem_id = M.mem_id
	group by M.mem_id
    order by sum(price*amount) desc;

select M.mem_id, M.mem_name, sum(price*amount) "총구매액",
	case
		when (sum(price*amount) >= 1500) then '최우수고객'
        when (sum(price*amount) >= 1000) then '우수고객'
        when (sum(price*amount) >= 1) then '일반고객'
        else '유령고객'
	end '회원등급'
    from buy B
		right outer join member M
        on B.mem_id = M.mem_id
	group by M.mem_id
    order by sum(price*amount) desc;

-- while 문(while 문의 기본 형식)
drop procedure if exists whileProc;
delimiter $$
create procedure whileProc()
begin
	declare i int; -- 1에서 100까지 증가할 변수
    declare hap int; -- 더한 값을 누적할 변수
	set i = 1;
    set hap = 0;
    
    while (i<=100) do
		set hap = hap + i; -- hap의 원래 값에 i를 더해서 다시 hap에 넣으라는 의미
        set i = i + 1; -- i의 원래 값에 1을 더해서 다시 i에 넣으라는 의미
	end while;
	select '1부터 100까지의 합 ==>', hap;
end $$
delimiter ;
call whileProc();

-- while 문의 응용(iterate 문과 leave 문을 중심으로)
drop procedure if exists whileProc2;
delimiter $$
create procedure whileProc2()
begin
	declare i int; -- 1에서 100까지 증가할 변수
    declare hap int; -- 더한 값을 누적할 변수
    set i =1;
    set hap = 0;
    
    myWhile:
    while (i<=100) do
		if (i%4 = 0) then
			set i = i + 1;
            iterate myWhile; -- 지정한 label 문으로 가서 계속 진행
		end if;
        set hap = hap + i;
        if (hap > 1000) then
			leave myWhile; -- 지정한 label 문을 떠남. 즉 while 종료
		end if;
        set i = i + 1;
	end while;
    
	select '1부터 100까지의 합(4의 배수 제외), 1000 넘으면 종료 ==>', hap;
end $$
delimiter ;
call whileProc2();

-- 동적 SQL
-- PREPARE와 EXECUTE

use market_db;
prepare myQuery from 'select * from member where mem_id = "BLK"';
execute myQuery;
deallocate prepare myQuery; -- 실행 후에는 DEALLOCATE PRPARE로 해제해주는 것이 바람직

-- 동적 SQL 활용
drop table if exists gate_table;
create table gate_table (id int auto_increment primary key, entry_time datetime);
set @curDate = current_timestamp(); -- 현재 날짜와 시간
prepare myQuery from 'insert into gate_table values(null, ?)';
execute myQuery using @curDate;
deallocate prepare myQuery;
select * from gate_table;
-- 일반 SQL에서는 @변수명으로 지정하는데 별도의 선언은 없어도 됩니다. 스토어드 프로시저에서는 변수는 DECLARE로 선언한 후에 사용해야 합니다.