use my_shop;
-- 산술 연산
SELECT p_name, price, stock_quantity, price*stock_quantity as 재고금액
from products;

-- 상품 가격 택배비 3000원을 추가하여 실제구매 금액 
SELECT p_name, price, price+3000 as "실제 구매 금액"
from products;

-- 상품가격을 10으로 나누어 10개월 무이자할부시 월 납부액을 구함
-- 상품명, 가격, 월 납부액

SELECT p_name, price, price/10 as `월 납부액` -- 백틱(`)
FROM products;
-- 문자열 함수
-- concat : 문자 연결
SELECT name, email FROM customers;

SELECT concat(name, '(' ,email, ')' ) as `이름과 메일`
FROM customers;

SELECT email, upper(email) AS 대문자메일
FROM customers;

SELECT name, char_length(name) AS `글자 수`,length(name) as `바이트 수`
FROM customers;

-- utf-8 : 한글 1자가 3바이트
SELECT p_name, ifnull(descr,'상품설명없음') as 설명
from products;
-- ifnull(설명이 null이면 , '상품설명없음' 반환)

SELECT email,
substring_index(email,'@',1) AS 아이디
FROM customers;
-- 1: 왼쪽  -1: 오른쪽
