alter table 주문 rename column 배송도시 to 배송도시코드;
alter table 주문 modify 배송도시코드 varchar(256);
desc 주문;

create index idx_order_date on 주문(주문일);
alter table 주문 drop index idx_order_date;
-- drop index idx_order_date on 주문

create view vw_order as
select 고객번호,
	count(*) as 주문건수,
    sum(주문가격) as 총주문금액
from 주문
group by 고객번호;
select * from vw_order;

SELECT 
    고객번호,
    주문건수,
    총주문금액
FROM vw_order
WHERE 총주문금액 >= 50000;

