-- 1. 다음 요구사항에 맞춰 고객 테이블과 주문 테이블을 생성하는 DDL 문을 작성하시오.   
--	  1) 고객 테이블: 
--           고객번호(VARCHAR(16), 기본키, NOT NULL), 
--           이름(VARCHAR(50), NOT NULL), 
--           비밀번호(VARCHAR(256), NOT NULL)
--    2) 주문 테이블: 
--            주문번호(VARCHAR(16), 기본키, NOT NULL), 
--            고객번호(VARCHAR(16), 외래키, NOT NULL), 
--            주문일(VARCHAR(8), NOT NULL),
--            주문가격(INT, NOT NULL),
--            배송도시(VARCHAR(100))
--    3) 주문 테이블의 고객번호는 고객 테이블의 고객번호를 참조하는 외래키(FK)로 설정할 것.

-- 2. 고객 테이블에 3건의 회원 데이터, 주문 테이블에 3건의 주문 데이터를 삽입하는 INSERT 문을 작성하시오.   1) 고객 데이터: 
--           ('C0001', '홍길동', 'pass1234'),,
--           ('C0002', '이순신', 'pass5678'), 
--           ('C0003', '강감찬', 'pass9012')   2) 주문 데이터: 
--           ('O1001', 'C0001', '20260801', 15000, '서울'), 
--           ('O1002', 'C0001', '20260803', 45000, '부산')
--           ('O1003', 'C0002', '20260805', 30000, '대전')

-- 3. 고객 테이블과 주문 테이블을 내부 조인(INNER JOIN)하여 '홍길동' 고객의 고객번호, 이름, 주문번호, 주문일, 주문가격을 조회하는 SQL 문을 작성하시오.


-- 4. 주문 테이블을 서브쿼리로 활용하여 단 한 번도 상품을 주문하지 않은 미주문 고객의 고객번호와 이름을 조회하는 SQL 문을 작성하시오.

-- 5. 고객별(GROUP) 총주문금액(SUM)을 집계하되, 총주문금액이 30,000원 이상인 고객의 고객번호,  총주문금액을 조회하는 SQL 문을 작성하시오.(JOIN, GROUP BY 및 HAVING 절 활용)


-- 1. test 데이터베이스 생성
CREATE DATABASE test;

-- 2. test 데이터베이스 선택 및 사용
USE test;
CREATE TABLE 고객 (
     고객번호 VARCHAR(16) NOT NULL,
     이름 VARCHAR(50) NOT NULL,
     비밀번호 VARCHAR(256) NOT NULL,
     CONSTRAINT PK_고객 PRIMARY KEY (고객번호)
);

create table 주문 (
	주문번호 VARCHAR(16) PRIMARY key NOT NULL, 
	고객번호 VARCHAR(16) NOT NULL,
    주문일 VARCHAR(8) NOT NULL,
	주문가격 INT NOT NULL,
	배송도시 VARCHAR(100),
    CONSTRAINT FK_주문_고객 FOREIGN KEY (고객번호) REFERENCES 고객(고객번호)
    );

insert into 고객(고객번호, 이름, 비밀번호) values
('C0001', '홍길동', 'pass1234'),
('C0002', '이순신', 'pass5678'), 
('C0003', '강감찬', 'pass9012');

insert into 주문(주문번호, 고객번호, 주문일, 주문가격, 배송도시) values
('O1001', 'C0001', '20260801', 15000, '서울'), 
('O1002', 'C0001', '20260803', 45000, '부산'),
('O1003', 'C0002', '20260805', 30000, '대전');
select * from 주문;

SELECT 
    c.고객번호, 
    c.이름, 
    o.주문번호, 
    o.주문일, 
    o.주문가격
FROM 고객 c
INNER JOIN 주문 o ON c.고객번호 = o.고객번호
WHERE c.이름 = '홍길동';

-- 방법 1: NOT IN 활용
SELECT 고객번호, 이름
FROM 고객
WHERE 고객번호 NOT IN (
    SELECT DISTINCT 고객번호 
    FROM 주문
);

SELECT 
    c.고객번호, 
    SUM(o.주문가격) AS 총주문금액
FROM 고객 c
INNER JOIN 주문 o ON c.고객번호 = o.고객번호
GROUP BY c.고객번호
HAVING SUM(o.주문가격) >= 30000
order by 총주문금액 asc;

