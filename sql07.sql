SELECT * from sample;
set sql_safe_updates = 0; -- 수정/삭제 할 수 있도록 비활성화
START TRANSACTION; -- 취소가 가능하도록 안전구역 설정
DELETE FROM sample; -- 모든 데이터 삭제
SELECT * FROM sample; -- 
ROLLBACK; -- 실행 취소

DELETE FROM sample; -- 모든 데이터 삭제
SELECT * FROM sample;
COMMIT; -- 확정