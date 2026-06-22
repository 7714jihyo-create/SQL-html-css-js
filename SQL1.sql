create database my_shop;
use my_shop;
-- 테이블정의(설계) : 필드=> 상품id, 상품이름, 가격, 재고수량, 출시일
create table sample (
   pro_id int primary key,
    p_name varchar(100),
    price int,
    quan int,
    re_date date
    );
desc sample;
show databases;
show tables;
drop table sample;
drop database my_shop;

-- CRUD(넣고/읽고/수정/삭제) : 기본작업

insert into sample (pro_id, p_name, price, quan, re_date)
value (1,'새우깡',3000,100, '2026-5-3');

-- r(읽기) : select
select * from sample;
insert into sample (pro_id, p_name, price, quan, re_date)
value (2, '양파링',2500,300, '2026-4-1');
select * from sample;

-- u(갱신,수정) : update

update sample set price = 5000 where pro_id=1;
select * from sample;

-- 양파링 수량 1000개 수정
update sample set quan = 1000 where pro_id=2;
select * from sample;

-- d(삭제) : delete
delete from sample where pro_id=2;
select * from sample;
