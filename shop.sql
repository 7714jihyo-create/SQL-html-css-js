-- <쇼핑몰 테이블>
-- /*쇼핑몰 테이블 실전 설계
-- 고객 (customers)
-- - 고객 id, 이름, 이메일, 비밀번호, 주소, 가입 시각 
-- 상품 (products)
-- - 상품 id, 상품명, 설명, 가격, 재고 수량 
-- 주문 (orders)
-- - 주문 id, 주문 고객, 주문 상품, 주문 수량, 주문 시각, 주문 상태

-- - 주문이 등록되면 최초의 주문 상태는 주문상태가 된다
-- - 한 번의 주문 시에 한 종류의 상품만 주문할 수 있다. 한 종류의 상품을 여러 개 주문하는 것은 가능하다.*/
use my_shop;
-- 고객 테이블
create table customers(
	customer_id int auto_increment primary key, -- auto_increment: 자동 번호 부여
    c_name varchar(50) not null, -- varchar(): 가변 / char(): 고정
    email varchar(100) not null unique, -- not null: 공백X, unique: 중복X
    pass varchar(255) not null, 
    address varchar(200) not null, 
    join_date datetime default current_timestamp -- date:날짜 datetime:날짜+시간, default: 기본값, current_timestamp: 현재 날짜 시간
);
desc customers; -- desc: 테이블 구조

create table products(
	product_id int auto_increment primary key,
    p_name varchar(100) not null,
    descr text, -- text: 긴 문자열
    price int not null,
    stock_quan int not null default 0
    );
desc products;

-- 주문테이블
create table orders(
   order_id int auto_increment primary key,
    customer_id int not null,
    product_id int not null,
    
    quantity int not null -- 주문 수량
    constraint chk_order_quan check(quantity >= 1),
    -- constraint : 제약조건/ chk_order_quan(이름 명명)
    -- check(quantity >= 1) : 수량이 1개 이상 체크
    
    order_date datetime  default current_timestamp,
    o_status varchar(20) not null default '주문접수',
    
    constraint fk_orders_customers foreign key (customer_id)
      references customers(customer_id)
      on update cascade, -- cascade : 부모 테이블이 갱신/수정/삭제되면 다른 자식 테이블도 함께 갱신/수정/삭제됨
    
    constraint fk_orders_products foreign key (product_id)
      references products(product_id)
      -- 주문 테이블의 product_id(외래키) - 상품 테이블의 product_id 연결
      -- fk_orders_products: 제약 조건마다 이름 지정(사용자가 정한 이름)
      on update cascade
  );
  desc orders;
  
  use my_shop;
  desc customers;
  desc products;
  desc orders;
  
  -- alter table: 이미 만든 테이블 구조 변경
  -- 열 추가: add column
  alter table customers add column point int not null default 0; -- 속성 추가
  desc customers;
  select * from customers;
  
  -- 열 (속성, 필드) 변경: modify column
  alter table customers modify column address varchar(300) not null;
  
  -- 열 삭제: drop column
  alter table customers drop column point;
  desc customers;
  
  alter table orders alter o_status set default '주문 접수 완료';
  
insert into customers 
 (c_name, email, pass, address) values
 ('이순신', 'sunsin@naver.com', 'password123', '서울특별시 중구 세종대로', '2026-05-01 10:30:00'),
('세종대왕', 'sejong@naver.com', 'password456', '서울특별시 종로구 사직로', '2025-04-01'),
('장영실', 'young@naver.com', 'password789', '부산광역시 동래구 복천동', '2026-03-10'),
('강감찬','kang@naver.com','password777','인천 남동구 구월동');

select * from customers;
desc customres;

insert into products(p_name,descr, price, stock_quan) values
('갤럭시', '최신 AI 기능이 탑재된 고성능 스마트폰', 1000000, 55),
('LG 그램', '초경량 디자인과 강력한 성능을 자랑하는 노트북', 500000, 35),
('아이폰', '직관적인 사용자 경험을 제공하는 스마트폰', 800000, 55),
('에어팟', '편리한 사용성의 무선 이어폰', 200000, 110),
('알뜰폰', NULL, 300000, 100);
select * from products;

SET FOREIGN_KEY_CHECKS = 1;
TRUNCATE TABLE products;

desc orders;
insert into orders(customer_id, product_id, quantity) value
(1,1,1),
(2, 2, 1), 
(3, 3, 1), 
(1, 4, 2), 
(2, 2, 1);
select * from orders;
select * from customers;
select * from products;

update customers set customer_id=10 where customer_id=4;
update customers set pass='password100' where customer_id=10;
-- delete from customers where customer_id=10; 아이디가 10인 고객 삭제

insert into customers (c_name,email, pass, address) value ('홍길동','aaa@naver.com','pass111','인천 미추홀구 용현동');
desc customers;

insert into orders (customer_id, product_id, quantity) values (12, 1, 1);
select * from products;

-- 기본키로만 조건을 작성( 일반 필드로도 조건 작성-> 안전모드 해제)
 SET SQL_SAFE_UPDATES = 0; -- 안전 모드 해제 (0 = OFF)
 update customers set pass='password333'
where c_name='장영실';
select * from customers;
SET SQL_SAFE_UPDATES = 1; 

create index i_price on products(price);
select * from products where price >=500000

-- view: 데이터 따로 저장 X, 필요한 것만 꺼내와서 사용자에 보여줌
-- [1] 첫 번째 뷰: 마스킹용 고객 정보
CREATE VIEW v_masking AS
SELECT customer_id, c_name, email, join_date
FROM customers;

SELECT * FROM v_masking;


-- [2] 두 번째 뷰: 서울 거주 고객 정보
CREATE VIEW v_seoul AS
SELECT customer_id, c_name, address 
FROM customers 
WHERE address LIKE '%서울%';

SELECT * FROM v_seoul;


-- [3] 세 번째 뷰: AI 관련 상품 정보
SELECT * FROM products;

CREATE VIEW v_desc AS
SELECT p_name, descr, price
FROM products 
WHERE descr LIKE '%ai%';

SELECT * FROM v_desc;

CREATE VIEW v_order_details AS
SELECT 
    o.order_id,             
    c.c_name AS 고객이름,
    p.p_name AS 상품명,
    o.order_date AS 주문일시,
    o.o_status AS 주문상태
FROM orders o 
JOIN customers c ON o.customer_id = c.customer_id
JOIN products p ON o.product_id = p.product_id; -- 💡 proudcts 오타 수정함

-- 뷰 조회하기
SELECT * FROM v_order_details;

CREATE VIEW v_orders_customers As
SELECT
	a.order_id,
    b.customer_id,
    b.c_name AS 고객이름,
    a.quantity AS 상품명
FROM orders a
JOIN customers b on a.customer_id=b.customer_id;
SELECT * FROM v_orders_customers;

drop view v_masking;

SELECT c_name, address from customers;
SELECT * FROM products
WHERE price>= 700000;

SELECT * FROM customers
WHERE join_date >= '2026-1-1';

SELECT * FROM products
WHERE price>=500000 and stock_quan >=50;

SELECT * FROM products
WHERE price not between 500000 and 1000000;

SELECT * FROM products
WHERE p_name not in ('갤럭시','아이폰','아이폰18');

SELECT * FROM customers
WHERE c_name like '%윤%';

SELECT * FROM customers
WHERE c_name LIKE '이__';

SELECT * FROM customers
WHERE c_name LIKE '____';

SELECT * FROM customers
WHERE address not LIKE '서울특별시%';

use my_shop;
SELECT * FROM customers;
SELECT * FROM products
where p_name in ('갤럭시','아이폰','에어팟');
SELECT * FROM orders;

-- 정렬(order by) : asc(오름차순) desc(내림차순)
-- customers -> join_date(가입일시) 최신순 나열
select * from customers
order by join_date desc;

-- 가격 오름차순 정렬
SELECT * FROM products
order by price asc;

select * from products
order by stock_quan desc, price asc;

select * from products
order by price desc;

select * from products order by price desc limit 2;

select * from products order by stock_quan asc limit 3;

select * from products order by product_id asc limit 2,2; -- limit 2,2 : 2개 건너 뜀, 2개 보여줌

-- Distinct : 중복제거
select distinct customer_id from orders;
select DISTINCT product_id from orders;
select * FROM products;
select * from products where descr is null;

SELECT product_id, p_name, descr is null from products ORDER BY descr desc;
-- descr is null: (null)참이면 1 거짓이면 0

-- descr 오름차순 정렬
select * from products order by descr desc;

SELECT c_name, address 
FROM customers 
WHERE address LIKE '인천%';

-- 상품명, 가격 (상품테이블) -> 조건 상품코드 일치(in)
SELECT p_name, price
FROM products
where product_id IN (SELECT product_id FROM orders WHERE product_id=3);

SELECT p_name, price, stock_quan
FROM products
WHERE p_name not IN ('갤럭시','아이패드');

SELECT * FROM products
WHERE product_id
IN (SELECT product_id FROM orders);

-- SELECT ~ FROM => WHERE/ORDER BY, BETWEEN AND, IN/NOT IN, LIKE '%' '__', 다중검색

-- 산술연산
SELECT c_name, price, stock_quan,
price*stock_quan as 재고금액
FROM products;

SELECT p_name, price,
price+3000 as 실금액
FROM products;

SELECT p_name,price,price/10
as `월 납부액` -- 백틱 (`)
from products;

SELECT c_name, email from customers;
SELECT concat(c_name,'(',email,')') as `이름과 메일`
FROM customers;

SELECT email, upper(email) as 대문자메일
from customers;

SELECT c_name, char_length(c_name) as 굴자수,
length(c_name) as 바이트수
from customers;

SELECT p_name, ifnull(descr, '상품설명없음') as 설명
from products;
-- ifnull: null이면 상품설명없음 반환

SELECT email,
substring_index(email,'@',1) as 아이디
FROM customers;
-- 골벵이 기준 1: 왼쪽 -1:오른쪽
