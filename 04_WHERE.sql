SELECT * FROM user_tbl;

SELECT * FROM user_tbl WHERE user_address = '서울' OR user_address = '경기';

-- IN문법은 IN다음에 오는 리스트 목록에 포함된 요소만 출력
SELECT * FROM user_tbl WHERE user_address IN ('서울', '경기');

-- 구매내역이 있는 유저만 출력
SELECT * FROM buy_tbl;
-- 서브쿼리를 활용한 조회구문
SELECT * FROM user_tbl WHERE user_num IN (SELECT user_num FROM buy_tbl);

-- LIKE 구문은 패턴 일치 여부를 통해 조회
-- %는 와일드카드 문자로, 어떤 문자가 몇 글자나 와도 좋다는 뜻
-- _는 와일드카드 문자로, _하나당 1글자씩을 처리
SELECT * FROM user_tbl WHERE user_name LIKE '%희';
SELECT * FROM user_tbl WHERE user_address LIKE '%남';
SELECT * FROM user_tbl WHERE user_name LIKE '_자바';

SELECT * FROM user_tbl WHERE user_height BETWEEN 165 AND 175;
SELECT * FROM user_tbl WHERE user_height > 165 AND user_height < 175;

INSERT INTO user_tbl VALUES 
(NULL, '박진영', 1990, '제주', NULL, '2020-10-01'),
(NULL, '김혜경', 1992, '강원', NULL, '2020-10-02'),
(NULL, '신지수', 1993, '서울', NULL, '2020-10-03');
SELECT * FROM user_tbl;

SELECT * FROM user_tbl WHERE user_height = NULL; -- 결과 안 나옴
SELECT * FROM user_tbl WHERE user_height IS NULL;