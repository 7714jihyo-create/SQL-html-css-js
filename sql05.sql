CREATE DATABASE db_ex;
USE db_ex;


-- 학생 테이블
CREATE TABLE 학생(
	학번 INT PRIMARY KEY,
    이름 VARCHAR(30) NOT NULL,
    학과코드 VARCHAR(50),
    선배 INT,
	성적 INT
);

-- 학과 테이블
CREATE TABLE 학과(
	학과코드 VARCHAR(30) PRIMARY KEY,
    학과명 VARCHAR(50) NOT NULL
);

-- 성적 테이블
CREATE TABLE 성적등급(
	등급 CHAR(1) PRIMARY KEY,
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

SELECT * FROM 학생;
SELECT * FROM 학과;
SELECT * FROM 성적등급;


-- EQUI 조인

-- 1) WHERE
SELECT 학번, 이름, 학생.학과코드, 학과명 FROM 학생, 학과 WHERE 학생.학과코드 = 학과.학과코드;
-- 2) NATURAL JOIN : 반드시 해당 테이블들에 같은 값이 있어야 함
-- 	  조건을 쓰지 않아도 자동으로 같은 것끼리 연결됨
SELECT 학번, 이름, 학생.학과코드, 학과명 FROM 학생 NATURAL JOIN 학과;

-- 3) JOIN~USING : 
SELECT 학번, 이름, 학생.학과코드, 학과명 FROM 학생 JOIN 학과 USING(학과코드);

-- NON-EQUI
select 학번, 이름, 성적, 등급 from 학생, 성적등급
where 학생.성적 between 성적등급.최저 and 성적등급.최고;

-- LEFT/RIGHT OUTER JOIN
SELECT 학번, 이름, 학생.학과코드, 학과명 FROM 학생 LEFT OUTER JOIN 학과 
ON 학생.학과코드 = 학과.학과코드;
-- 왼쪽 테이블(학생) 전부 가져옴, 
-- 오른쪽 테이블(학과)는 학과코드가 같은 것만 추출

-- SELECT 학번, 이름, 학생.학과코드, 학과명 FROM 학생, 학과 
-- WHERE 학생.학과코드 = 학과.학과코드(+); 다 안 갖고온 쪽에 (+)넣는다

-- RIGHT OUTER JOIN
SELECT 학번, 이름, 학생.학과코드, 학과명 FROM 학생 RIGHT OUTER JOIN 학과
ON 학과.학과코드 = 학생.학과코드;
-- 오른쪽테이블(학과) 전부 가져오고 왼쪽테이블은 학과코드 같은 것만 추출

-- SELECT 학번, 이름, 학생.학과코드, 학과명 FROM 학생, 학과 
-- WHERE 학생.학과코드(+) = 학과.학과코드; 다 안 갖고온 쪽에 (+)넣는다

SELECT 학번, 이름, 학생.학과코드, 학과명 FROM 학생 LEFT OUTER JOIN 학과 
ON 학생.학과코드 = 학과.학과코드
UNION
SELECT 학번, 이름, 학생.학과코드, 학과명 FROM 학생 RIGHT OUTER JOIN 학과
ON 학과.학과코드 = 학생.학과코드;

-- SELF JOIN
SELECT a.학번, a.이름, b.이름 as 선배
FROM 학생 a JOIN 학생 b
ON a.선배=b.학번;
-- 하나의 테이블로 조인
-- 학생 테이블을 가상으로 하나 복사하여 사용하는 것처럼 사용
-- 학생테이블 a / b
-- 학생 a -> 후배 테이블
-- 학생 b -> 선배 테이블