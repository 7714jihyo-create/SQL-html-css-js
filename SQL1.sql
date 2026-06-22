create database my_shop; -- 데이터 베이스 생성 (create database 이름;)
use my_shop; -- 사용

-- 테이블 정의 : 필드 => 상품ID, 상품명, 가격, 재고 수량, 출시일
create table sample ( -- 관계형 데이터베이스의 표 생성
	pro_id int primary key, -- 기본키 
    p_name char(100), -- varchar: 가변 길이, 최대 100
    price int,
    quan int,
    re_date date
);
desc sample; -- 테이블 구조 확인
show databases; -- 데이터 베이스 보기
show tables; -- 테이블 보기

-- c(입력):insert
insert into sample (pro_id, p_name, price, quan, re_date)
value (1, '새우깡', 3000, 100, '2026-5-3');
insert into sample (pro_id, p_name, price, quan, re_date)
value (2,'양파링',2500,300,'2026-04-01');

-- r(읽기): select
select * from sample my_shop;
select pro_id, p_name from sample;

-- u(갱신,수정): update
update sample set price = 5000 where pro_id=1;
update sample set quan = 1000 where pro_id=2;

-- d(삭제): delete
delete from sample 