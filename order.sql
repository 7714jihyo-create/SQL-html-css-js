CREATE TABLE order_stat (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(50),
    category VARCHAR(50), -- 카테고리
    product_name VARCHAR(100),
    price INT,
    quantity INT,
    order_date DATE
);

INSERT INTO order_stat (customer_name, category, product_name, price, quantity, order_date) VALUES
('이순신', '전자기기', '프리미엄 기계식 키보드', 150000, 1, '2025-05-10'),
('세종대왕', '도서', 'SQL 마스터링', 35000, 2, '2025-05-10'),
('신사임당', '가구', '인체공학 사무용 의자', 250000, 1, '2025-05-11'),
('이순신', '전자기기', '고성능 게이밍 마우스', 80000, 1, '2025-05-12'),
('세종대왕', '전자기기', '4K 모니터', 450000, 1, '2025-05-12'),
('장영실', '도서', '파이썬 데이터 분석', 40000, 3, '2025-05-13'),
('이순신', '문구', '고급 만년필 세트', 200000, 1, '2025-05-14'),
('세종대왕', '가구', '높이조절 스탠딩 데스크', 320000, 1, '2025-05-15'),
('신사임당', '전자기기', '노이즈캔슬링 블루투스 이어폰', 180000, 1, '2025-05-15'),
('장영실', '전자기기', '보조배터리 20000mAh', 50000, 2, '2025-05-16'),
('홍길동', NULL, 'USB-C 허브', 65000, 1, '2025-05-17'); 
-- 카테고리가 NULL인 데이터 추가

select * from order_stat;

select count(customer_name) from order_stat;
-- count(표현식) : 개수 (null 제외)
select count(category) from order_stat;
-- count(*): 전체 개수
-- sum() avg()
SELECT sum(price*quantity) as 총매출액,
round(AVG(price* quantity),1) as 평균매출액
from order_stat;
-- truncate table: 테이블 구조는 그대로 내용만 삭제
-- TRUNCATE(avg(price*quantity),1):소수 이하 버림
-- 집계함수(count, sum, avg, max, min ~~~)
select
min(order_date) as 최초주문일,
max(order_date) as 최근주문일
from order_stat;

select
count(customer_name) as 총주문건수,
count(DISTINCT customer_name) as 순수고객수 
from order_stat;

-- group by: 그룹으로 묶기
-- 카테고리별 주문 건수
SELECT
category,
count(*) as `카테고리별 주문건수`
from order_stat
GROUP BY category;

-- 고객별 주문 횟수
SELECT customer_name,
count(*) as `주문횟수`,
sum(quantity) as `총 주문 수량`,
sum(quantity*price) as `총 구매 금액`
from order_stat
GROUP BY customer_name
ORDER BY `총 구매 금액` desc;	

select
customer_name,
count(*) as 주문횟수
from order_stat
GROUP BY customer_name
having count(*)>=3;
-- 순서: from>where>group by>having>select>order by
SELECT
	category,
	count(*) as 구분별주문횟수
from order_stat -- 1
WHERE price>=100000 -- 2
group by category -- 3
having count(*)>=2;-- 4

select
	customer_name,
	product_name,
    price,
	sum(quantity*price) as `총 구매 금액`
	FROM order_stat
where order_date<='2025-05-14'
group by customer_name
having count(*) >=2
ORDER BY `총 구매 금액` desc
limit 1;

select
category,
sum(price*quantity) as total_sales
from order_stat
where
sum(price*quantity)>=50000
GROUP BY category
