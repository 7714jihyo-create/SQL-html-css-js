create database db_ex;
use db_ex;

CREATE TABLE 학생(
	학번 INT PRIMARY KEY,
    이름 varchar(30) NOT NULL,
    학과코드 varchar(50),
    선배 INT,
    성적 INT
);

CREATE TABLE 학과(
	학과코드 VARCHAR(30) PRIMARY KEY,
    학과명 VARCHAR(50) NOT NULL
);

CREATE TABLE 성적등급(
	등급 CHAR primary KEY,
    최저 INT NOT NULL,
    최고 INT NOT NULL
    );
DESC 학생;
DESC 학과;
DESC 성적등급;

-- 학생 데이터 
INSERT INTO 학생 VALUES (15, '한다맨', 'com', NULL, 83);
INSERT INTO 학생 VALUES (16, '이서영', 'han', NULL, 96);
INSERT INTO 학생 VALUES (17, '장효정', 'com', 15, 95);
INSERT INTO 학생 VALUES (19, '주연국', 'han', 16, 75);
INSERT INTO 학생 VALUES (37, '신동진', null, 17, 55);

-- 학과 데이터 
INSERT INTO 학과 VALUES ('com', '컴퓨터');
INSERT INTO 학과 VALUES ('han', '국어');
INSERT INTO 학과 VALUES ('eng', '영어');

-- 성적 데이터
INSERT INTO 성적등급 VALUES ('A',90,100);
INSERT INTO 성적등급 VALUES ('B',80,89);
INSERT INTO 성적등급 VALUES ('C',60,79);
INSERT INTO 성적등급 VALUES ('D',0,59);

select * from 학생;
select * from 학과;
select * from 성적등급;

-- EQUI JOIN: (=)
select 학번, 이름, 학생.학과코드, 학과명
from 학생, 학과
where 학생.학과코드=학과.학과코드;

-- natural join: 반드시 해당 테이블들에 같은 속성이 있어야 함
-- 조건 쓰지 않아도 자동으로 같은것끼리 연결
select 학번, 이름, 학생.학과코드, 학과명
from 학생 natural join 학과;

-- join~using
select 학번, 이름, 학생.학과코드, 학과명
from 학생 join 학과 using(학과코드);

select 학번, 이름, 성적, 등급
from 학생, 성적등급
where 학생.성적 between 성적등급.최저 and 성적등급.최고;

select 학번, 이름, 학생.학과코드, 학과명 from 학생 left outer join 학과
on 학생.학과코드 = 학과.학과코드;

-- select 학번, 이름, 학생.학과코드, 학과명
-- from 학생, 학과
-- where 학생.학과코드=학과.학과코드(+);

select 학번, 이름, 학생.학과코드, 학과명
from 학생 right outer join 학과
on 학생.학과코드 = 학과.학과코드;
-- 오른쪽테이블(학과) 전부 가져오고 왼쪽 테이블은 학과코드 같은것만 추출

SELECT 학번, 이름, 학생.학과코드, 학과명 
FROM 학생
LEFT JOIN 학과 ON 학생.학과코드 = 학과.학과코드
UNION
SELECT 학번, 이름, 학생.학과코드, 학과명 
FROM 학생
RIGHT JOIN 학과 ON 학생.학과코드 = 학과.학과코드;

-- self join: 같은 테이블에서 2개의 속성을 연결하여 equi join 하는 join 방법
SELECT a.학번, a.이름, b.이름 AS 선배
FROM 학생 a 
JOIN 학생 b ON a.선배 = b.학번;
-- 하나의 테이블로 조인, 학생 테이블을 가상으로 하나 복ㄱ사하여 사용
-- 학생테이블 a/b -> 후배테이블
-- 학생 a >> 후배 테이블
-- b >> 선배 테이블;



