CREATE USER 'test_user'@'localhost' IDENTIFIED BY 'sql12345'; 
-- 접속중인 곳에 새로운 아이디와 비번 부여
GRANT SELECT -- GRANT : 권한 부여 SELECT : 조회 권한
ON my_shop.* -- my_shop 데이터베이스 -> 모든 테이블에 SELECT 권한 부여
TO 'test_user'@'localhost';
WITH GRANT OPTION;

-- 권한 새로고침
FLUSH PRIVILEGES;  -- PRIVILEGES = 권한

REVOKE SELECT
ON my_shop.*
FROM 'test_user'@'localhost';
-- 다른 건환도 회수

FLUSH PRIVILEGES;

SHOW GRANTS FOR 'test_user'@'localhost';

GRANT ALL PRIVILEGES		-- 모든 권한 부여 할때는 ALL PRIVILEGES 씀
ON my_shop.*
TO 'test_user'@'localhost';

REVOKE ALL PRIVILEGES
ON my_shop.*
FROM 'test_user'@'localhost';

GRANT SELECT
ON my_shop.*
to 'test_user'@'localhost'
WITH GRANT OPTION;

drop user 'test_user'@'localhost';



