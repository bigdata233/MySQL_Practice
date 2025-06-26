#where절
select * from member where member_name = '아이유';
#인덱스 만들기
create index idx_member_name on member(member_name);
#뷰 만들기
create view member_view as select * from member;
select * from member_view;
#스토어드 프로시저
select * from member where member_name = '나훈아';
select * from product where product_name = '삼각김밥';
#스토어드 프리시져 만들기
delimiter //
create procedure myProc()
begin
	select * from member where member_name = '나훈아';
    select * from product where product_name = '삼각김밥';
end //
delimiter ;
#프로시저 호출하기
call myProc();