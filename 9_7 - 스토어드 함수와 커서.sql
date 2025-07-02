-- SQL로 스토어드 함수 생성 권한 허용
set global log_bin_trust_function_creators = 1;

-- 스토어드 함수의 사용
use market_db;
drop function if exists sumFunc;
delimiter $$
create function sumFunc(number1 int, number2 int)
	returns int
begin
	return number1 + number2;
end $$
delimiter ;

select sumFunc(100, 200) '합계';

drop function if exists calcYearFunc;
delimiter $$
create function calcYearFunc(dYear int)
	returns int
begin
	declare runYear int; -- 활동기간(연도)
    set runYear = year(curdate()) - dyear;
    return runYear;
end $$
delimiter ;
select calcYearFunc(2010) as '활동 햇수';

-- 다음과 같이 함수의 반환 값을 select ~ into ~ 로 저장했다가 사용할 수도 있습니다.
select calcYearFunc(2007) into @debut2007;
select calcYearFunc(2013) into @debut2013;
select @debut2007-@debut2013 as '2007과 2013 차이';

select mem_id, mem_name, calcYearFunc(year(debut_date)) as '활동 햇수' from member;

show create function calcYearFunc;
drop function calcYearFunc;

-- 커서의 통합 코드
use market_db;
drop procedure if exists cursor_proc;
delimiter $$
create procedure cursor_proc()
begin
	declare memNumber int;
    declare cnt int default 0;
    declare totNumber int default 0;
    declare endOfRow boolean default false;
    
    declare memberCuror cursor for select mem_number from member;
    
    declare continue handler for not found set endOfRow = TRUE;
    
    open memberCuror;
    
    cursor_loop: loop
		fetch memberCuror into memNumber;
        
        if endOfRow then
			leave cursor_loop;
		end if;
        
        set cnt = cnt + 1;
        set totNumber = totNumber + memNumber;
	end loop cursor_loop;
    
    select (totNumber/cnt) as '회원의 평균 인원 수';
    
    close memberCuror;
end $$
delimiter ;

call cursor_proc();