-- ORDER BY 절(기본 = 오름차순)
select mem_id, mem_name, debut_date
	from member
    order by debut_date;
select mem_id, mem_name, debut_date
	from member
    order by debut_date desc;
select mem_id, mem_name, debut_date
	from member
    order by height desc
    where height >= 164; -- 오류발생(순서가 틀림)
select mem_id, mem_name, debut_date, height
	from member
    where height >= 164
    order by height desc;
select mem_id, mem_name, debut_date, height
	from member
    where height >= 164
    order by height desc, debut_date asc;
-- 출력의 개수를 제한 : LIMIT
select * from member limit 3;
select mem_name, debut_date
	from member
    order by debut_date
    limit 3;
select mem_name, height
	from member
    order by height desc
    limit 3,2;
-- 중복된 결과를 제거 : DISTINCT
select addr from member;
select addr from member order by addr;
select distinct addr from member;
-- GROUP BY 절
select mem_id, amount from buy order by mem_id;
-- 집계함수와 GROUP BY 절을 같이 활용하자
select mem_id, sum(amount) from buy group by mem_id;
select mem_id "회원 아이디", sum(amount) "총 구매 개수"
	from buy group by mem_id;
select mem_id "회원 아이디", sum(price*amount) "총 구매 금액"
	from buy group by mem_id;
select avg(amount) "평균 구매 개수" from buy;
select mem_id, avg(amount) "평균 구매 개수"
	from buy
    group by mem_id;
select count(*) from member;
select count(phone1) "연락처 있는 회원" from member;
-- count(*)는 모든 행의 개수를 세고, count(열_이름)은 열 이름의 값이 NULL인 것을 제외한 행의 개수를 셉니다.

-- Having 절
select mem_id "회원 아이디", sum(price*amount) "총 구매 금액"
	from buy
    group by mem_id;
-- 틀린 구문
select mem_id "회원 아이디", sum(price*amount) "총 구매 금액"
	from buy
    where sum(price*amount) > 1000
    group by mem_id;
-- group by 뒤에 having 오는 구조
select mem_id "회원 아이디", sum(price*amount) "총 구매 금액"
	from buy
    group by mem_id
    having sum(price*amount) > 1000;
select mem_id "회원 아이디", sum(price*amount) "총 구매 금액"
	from buy
    group by mem_id
    having sum(price*amount) > 1000
    order by sum(price*amount) desc;