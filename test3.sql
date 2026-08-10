use test;
create user 'user1'@'localhost' identified by 'sql123';

grant select, insert on 주문 to 'user1'@'localhost';
revoke insert on 주문 from 'user1'@'localhost';
show grants for 'user1'@'localhost';

set autocommit=0;

start transaction;
update 주문 set 주문가격=20000
where 주문번호='o1001';
select * from 주문;
savepoint P1;

set SQL_SAFE_UPDATES=0;
DELETE FROM 주문 WHERE 주문번호='o1003';
SELECT * FROM 주문;

ROLLBACK TO P1;
SELECT * FROM 주문;

COMMIT;

DROP USER 'user1'@'localhost';
SHOW GRANTS;