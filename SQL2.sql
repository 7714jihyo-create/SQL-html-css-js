-- <쇼핑몰 테이블>
/*쇼핑몰 테이블 실전 설계
고객 (customers)
- 고객 id, 이름, 이메일, 비밀번호, 주소, 가입 시각 
상품 (products)
- 상품 id, 상품명, 설명, 가격, 재고 수량 
주문 (orders)
- 주문 id, 주문 고객, 주문 상품, 주문 수량, 주문 시각, 주문 상태

- 주문이 등록되면 최초의 주문 상태는 주문상태가 된다
- 한 번의 주문 시에 한 종류의 상품만 주문할 수 있다. 한 종류의 상품을 여러 개 주문하는 것은 가능하다.*/
use my_shop;
desc sample;
select * from sample;

-- DDL
-- 고객 테이블
create table customers (
	customer_id	 int auto_increment primary key, 
    -- auto_increment: 자동 번호 부여  primary key: 기본키
    c_name varchar(50) not null, 
    -- varchar(50): 가변, 최대 50(메모리 낭비x)  / char(50): 고정 (메모리 낭비)
	email varchar(100) not null unique, 
    -- notnull: 공백안됨，unique: 중복 안됨(고유의 하나)
    password varchar(255) not null, -- 비번
    address varchar(200) not null, -- 주소
    join_date datetime default current_timestamp -- 가입 일시
    -- date: 날짜 datetime: 날짜/시간
    -- defualt: 기본값(입력하지 않아도 기본으로 들어가 있는 값)
    -- current_timestamp: 현재 날짜/시간
);
desc customers; -- desc: 구조 확인
drop table customers; -- drop: 삭제

-- 상품 테이블
create table products(
	product_id int auto_increment primary key,
    p_name varchar(100),
    descr text, -- 긴 문자열 (설명)
    price int not null,
    stock_quantity int not null default 0
);
desc products;

-- 주문테이블
create table orders(
	order_id int auto_increment primary key,
    customer_id int not null, -- 외래키
    product_id int not null, -- 외래키
    quantity int not null -- 주문 수량 
    constraint chk_order_quan check(quantity >= 1), -- 주문 수량이 1 개 이상이어야 한다.
    -- constraint: 제약조건/ chk_order_quan(조건 이름 명명 해야됨) 보통 check는 chk씀
    -- check(quantity >= 1) : 수량이 1개 이상 체크(check)
    order_date datetime default current_timestamp,
    o_status varchar(20) not null default '주문접수',
   
	constraint fk_order_customers foreign key (customer_id) -- 보통 fk는 외래키를 뜻함
     references customers(customer_id)  -- 참조 customers 테이블에서 customer_id로 참조함
     on update cascade, 
     -- cascade : 부모 테이블이 갱신(수정)/삭제되면 다른 자식 테이블도 같이 수정/삭제
    
    constraint fk_order_products foreign key(product_id)
	 references products(product_id)
     -- 주문 테이블의 product_id(외래키)- 상품테이블의 product_id 연결
     -- fk_orders_products : 제약조건마다 이름을 정함(우리가 만든 이름)
     on update cascade
    );

use my_shop;

desc products;
desc customers;
desc orders;

-- alter table : 이미 만든 테이블 구조 변경

-- 열 추가 : add column
alter table customers
add column point int not null default 0; -- 속성 추가
desc customers;
select * from customers;

-- 열(속성, 필드) 변경 : modify column
alter table customers
modify column address varchar(300) not null;

-- 열 삭제 : drop column
alter table customers
drop column point;


alter table orders
alter o_status set default '주문접수 완료';
desc orders;


-- CRUD <== DML
-- C : create(생성,입력) insert
-- R : read(읽기,조회) select
-- U : update(갱신) update
-- D : delete(삭제) delete



insert into customers
(name, email, password, address, join_date) values
 ('이순신', 'sunsin@naver.com', 'password123', '서울특별시 중구 세종대로', '2026-05-01 10:30:00'),
('세종대왕', 'sejong@naver.com', 'password456', '서울특별시 종로구 사직로', '2025-04-01'),
('장영실', 'young@naver.com', 'password789', '부산광역시 동래구 복천동', '2026-03-10');

select * from customers;

insert into customers
(name, email, password, address) values
("강감찬", "kang@naver.com", "password777", "인천 남동구 구월동");
desc products;

insert into products
(p_name, descr, price, stock_quantity) values
('갤럭시', '최신 AI 기능이 탑재된 고성능 스마트폰', 1000000, 55);

select * from products;
desc products;

INSERT INTO products (p_name, descr, price, stock_quantity) VALUES
('LG 그램', '초경량 디자인과 강력한 성능을 자랑하는 노트북', 500000, 35),
('아이폰', '직관적인 사용자 경험을 제공하는 스마트폰', 800000, 55),
('에어팟', '편리한 사용성의 무선 이어폰', 200000, 110),
('알뜰폰', NULL, 300000, 100);
-- DELETE: 지우개로 공책에 적힌 글씨를 한 줄씩 쓱싹쓱싹 지우는 것 (지운 흔적이 남고, 시간도 걸림)
-- TRUNCATE: 공책에서 글씨가 적힌 페이지 자체를 쫙 찢어서 버리는 것 (흔적도 없고 순식간에 새 장이 됨)
-- DROP: 테이블을 존재 자체를 삭제
truncate table products; -- 전부 삭제
desc orders;

insert into orders (customer_id,product_id,quantity) values
(1,1,1),
(2, 2, 1), 
(3, 3, 1), 
(1, 4, 2), 
(2, 2, 1);
desc orders;
select * from customers;
select * from products;
select * from orders;

update customers set customer_id =10 
where customer_id=4;

update customers set password ='password100' 
where customer_id=10;

-- delete from customers
-- where customer_id=10; 


-- 기본키로만 조건을 작성(일반 필드로도 조건을 작성)
SET SQL_SAFE_UPDATES = 0; -- 안전 모드 해제 (0 = OFF)
update customers set password="password333"
where name="장영실";


-- 인덱스 생성 (좀더 빨리 찾기 위해)
create index i_price on products(price);
select * from products where price >=500000;

-- view(뷰) : 데이터를 따로 저장 안함, 필요한 것만 꺼내와서 사용자한테 보여줌

create view v_masking as
	select
	 customer_id,
     name,
     email,
     join_date
	from customers;
select * from v_masking;

create view v_seoul as
	select customer_id, name, address 
    from customers 
    where address like "%서울%"; -- 서울 포함 주소
    -- like 와 같다, %:모든문자 대체(공백도 대체)
select * from v_seoul;

select * from products;
-- p_name, descr, price 조건 : 설명중(descr)중 AI


 -- 한 테이블에서 뷰 생성
create view v_descr as
	select p_name,descr,price from products
    where descr like "%AI%";
select * from v_descr;



create view v_order_details as
	select 
		o.order_id,
        c.name as 고객이름,
        p.p_name as 상품명,
        o.order_date as 주문일시,
        o.o_status as 주문상태
    from orders o 
    join customers c on o.customer_id = c.customer_id
	join products p on o.product_id = p.product_id;
    
select * from v_order_details;
    
    -- orders => a customers => b
    -- order_id, customer_id, c_name, quantity
    -- => 주문번호, 고객번호, 고객명, 수량

create view v_ord as
		select 
        a.order_id as 주문번호,
        b.customer_id as 고객번호,
        b.name as 고객명,
        a.quantity as 수량
		from customers b
        join orders a on a.customer_id = b.customer_id;
        
select * from v_ord;

drop view v_masking;

select name, address from customers;
select * from products where price >=700000;
-- customers => join_date가 2026-1-1 이후 조회
select * from customers where join_date >= '2026-1-1';
-- (price)가격이 50만원 이상이면서 (stock_quantity)재고수량이 50 이상
select * from products where price >= 500000 and stock_quantity >= 50;
-- where 조건, (between~and 짝)
select * from products where price not between 500000 and 1000000;
-- in : 포함여부
select * from products where p_name not in ("갤럭시","아이폰18","에어팟");

select * from customers
where name like "강%";

select * from customers
where name like "%윤%";
-- _(밑줄) : 글자
select * from customers
where address not like "서울특별시%";

select * from customers;
select * from products;
select * from orders;

-- products 삼품명이 아로 시작하면서 3글자

select * from products 
where p_name like "아__";

-- products 삼품명이 아로 시작하는 모든 데이터 조회

select * from products 
where p_name like "아%";

-- products -> price가 500000 미만이거나 800000 초과 데이터 조회

select * from products
where 500000 > price or 800000 < price;
-- between 이용
-- 예) between 300000 and 500000(300000~500000)
select * from products 
where price not between 300000 and 500000;

-- 상품명이 ('갤럭시', '아이폰', '에어팟') 일치하면 조회

select * from products
where p_name in ('갤럭시', '아이폰', '에어팟');

-- 정렬 order by asc(오름차순(a->z, 가->하), 기본으로 생략 가능), desc(내림차순)

-- customers -> join_date(가입 일시) 최근 순

select * from customers order by join_date desc;

select * from products order by price asc;
-- 다중 열 정렬(stock_quantity)(재고수량)는 큰거부터 => 가격은 작은거부터

select * from products 
order by stock_quantity desc,
price asc;

-- 가격이 가장 비싼 상품 나열
select * from products
order by price desc limit 2; -- limit : 개수 제한 
-- 재고수량(stock_quantity)이 작은 상품 3개
select * from products
order by stock_quantity asc limit 3;

select * from products
order by product_id asc limit 2,2; -- limit 2,2 : 2개 건너뜀, 2개 보여줌

-- DISTINCT - 중복 제거, 속성명(열이름) 앞
select DISTINCT customer_id from orders;

SELECT DISTINCT product_id FROM orders;

SELECT * FROM products
WHERE descr is NULL;    -- null : 알 수 없음
-- null값을 검사하기 위해서는 is null을 써야함
SELECT * FROM products
WHERE descr IS NOT NULL; 

SELECT product_id, p_name,descr 
IS NULL FROM products;
-- descr is null : 참이면 1 거짓이면 0

-- descr(설명)을 오름차순으로 정렬

SELECT * FROM products ORDER BY descr ASC ;
-- null 값은 크기순으로 가장 작은 값

SELECT * FROM products 
WHERE descr IS NOT NULL
ORDER BY descr ASC;

-- 주소가 인천인 고객에 대해 고객테이블에서 이름과 주소 검색
SELECT name,address FROM customers where name 
	in (select name from customers where address like "%인천%");

-- 상품명,가격(상품테이블) -> 조건 상품코드 일치(IN)
-- 주문테이블에서 상품코드 3인것의 상품코드 안에 상품테이블에서 상품코드를 출력  
SELECT p_name, price FROM products
WHERE product_id IN
(SELECT product_id FROM orders WHERE product_id = 3);

SELECT p_name,price, stock_quantity
FROM products
WHERE p_name NOT IN ('갤럭시','아이패드');
-- 상품테이블의 상품코드를 주문테이블의 상품코드와 일치
SELECT * FROM products
WHERE product_id
IN (SELECT product_id FROM orders);

-- SELECT ~ FROM => 
-- where/order by(asc,desc),
-- between and,
-- in / not in,
-- 다중검색
-- DISTINCT : 중복제거
-- LIMIT 개수
