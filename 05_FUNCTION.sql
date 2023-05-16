SELECT * FROM user_tbl;

INSERT INTO user_tbl VALUES 
(NULL, 'alex', 1986, 'NY', 173, '2020-11-01'),
(NULL, 'Smith', 1992, 'Texas', 181, '2020-11-05'),
(NULL, 'Emma', 1995, 'Tampa', 168, '2020-12-13'),
(NULL, 'JANE', 1996, 'LA', 157, '2020-12-15');

SELECT 
	user_name, 
	UPPER(user_name) AS 대문자유저명,
	LOWER(user_name) AS 소문자유저명,
	LENGTH(user_name) AS 문자길이,
	SUBSTR(user_name, 1, 2) AS 첫글자두번째글자,
	CONCAT(user_name, ' 회원이 존재합니다.') AS 회원목록
FROM user_tbl;

-- 이름이 4글자 이상인 유저 출력
-- LENGTH는 byte길이이므로 한글은 한 글자에 3바이트로 간주.
-- 따라서 CHAR_LENGTH()를 이용하면 그냥 글자숫자로 처리
SELECT user_name, CHAR_LENGTH(user_name) FROM user_tbl WHERE CHAR_LENGTH(user_name) >= 4;
SELECT user_name, CHAR_LENGTH(user_name) FROM user_tbl WHERE user_name LIKE '____%';

-- 소수점 아래 저장하는 컬럼
ALTER TABLE user_tbl ADD (user_weight DECIMAL(3, 2));
-- 전체 5자리중 2자리는 소수점으로 배정
ALTER TABLE user_tbl MODIFY user_weight DECIMAL(5, 2);

SELECT * FROM user_tbl;

UPDATE user_tbl SET user_weight = 53.33 WHERE user_num = 9;
SET SQL_SAFE_UPDATES = 0;

SELECT user_name, user_weight, 
	ROUND(user_weight, 1) AS 반올림, 
    TRUNCATE(user_weight, 1) AS 소수점아래_1자리,
	MOD(user_height, 150) AS 키_150으로나눈나머지,
    CEIL(user_weight) AS 키올림,
    FLOOR(user_weight) AS 키내림,
    SIGN(user_weight) AS 양수음수_0여부,
    SQRT(user_height) AS 키_제곱근
FROM user_tbl;

SELECT * FROM user_tbl;

SELECT 
	user_name, entry_date, 
	DATE_ADD(entry_date, INTERVAL 15 DAY) AS _3개월후, 
    LAST_DAY(entry_date) AS 해당월마지막날짜,
    TIMESTAMPDIFF(MONTH, entry_date, now()) AS 오늘과개월수차이
FROM user_tbl;

-- 현재 시간
SELECT now();

-- 0으로 나누기
SELECT 3 / 0;

-- user_tbl의 회원들 중 키 기준으로 165 미만은 평균미만, 165는 평균, 165 이상은 평균이상 출력
SELECT 
	user_name, user_height,
	CASE 
		WHEN user_height < 164 THEN '평균미만'
        WHEN user_height = 164 THEN '평균'
        WHEN user_height > 164 THEN '평균초과'
	END AS 키분류,
    user_weight
FROM user_tbl;

SELECT user_name, user_weight, user_height,
	FLOOR(user_weight/POWER(user_height/100, 2)) AS BMI_RESULT,
	CASE 
		WHEN user_weight/POWER(user_height/100, 2) < 18 THEN '저체중'
        WHEN user_weight/POWER(user_height/100, 2) >= 25 THEN '고체중'
        ELSE '일반체중'
	END AS BMI_CASE
FROM user_tbl;