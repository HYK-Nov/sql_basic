-- GROUP BY는 기준컬럼을 하나 제시할 수 있고
-- 기준컬럼에서 동일한 값을 가지는 것끼리 같은 집단으로 보고 집계하는 쿼리문
-- SELECT 집계컬럼명 FROM 테이블명 GROUP BY 기준컬럼명;
SELECT user_address AS 지역명, AVG(user_height) AS 평균키 FROM user_tbl GROUP BY user_address;

SELECT * FROM user_tbl;

SELECT 
	user_birth_year AS 생년, 
    COUNT(user_num) AS 인원수,
	AVG(user_weight) AS 평균체중 
FROM user_tbl GROUP BY user_birth_year;

SELECT * FROM user_tbl;
SELECT MAX(user_height) AS 가장_큰_키_수치, MIN(user_birth_year) AS 가장_빠른_생년 FROM user_tbl;

SELECT 
	user_address AS 거주지, 
    AVG(user_birth_year) AS 평균생년, 
    COUNT(*) AS 거주자수 
FROM user_tbl GROUP BY user_address HAVING COUNT(*) > 1;

SELECT 
	user_birth_year AS 생년,
    AVG(user_height) AS 평균키
FROM user_tbl GROUP BY user_birth_year HAVING 평균키 >= 160;