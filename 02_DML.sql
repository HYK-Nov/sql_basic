/* 좌측의 SCHEMAS의 DATABASE는 더블클릭이나 우클릭으로도 호출할 수도 있지만
 USE DB명; 을 수행해 호출 할 수 있음. */

-- Workbench(윈도우)에서 수행 가능한 구문은 거의 모두 CLI환경에서 수행 가능
-- DATABASE 변경 구문;
USE bitcamp06; -- use bitcamp06

/* DATABASE 정보 조회 */
show DATABASES;

-- 테이블 생성
CREATE TABLE user_tbl(
	user_num int(5) PRIMARY KEY AUTO_INCREMENT, -- INSERT시 숫자 자동 배정
    user_name varchar(10) NOT NULL,
    user_birth_year int NOT NULL,
    user_address char(5) NOT NULL,
    user_height int, -- 자리수 제한 없음
    entry_date date -- 회원가입일user_tbl
);

/* 특정 테이블은 원래 조회할 때 SELECT * FROM 에디터베이스명.테이블명; 형식으로 조회해야 함.
그러나 use 구문 등을 이용해 데이터베이스를 지정한 경우는 데이터베이스를 생략할 수 있음. */
SELECT * FROM bitcamp06.user_tbl;
USE bitcamp06;
SELECT * FROM user_tbl;

INSERT INTO user_tbl VALUES(NULL, 'JAVA', 1987, '서울', 176, '2023-05-12');
INSERT INTO user_tbl VALUES(NULL, 'C', 1990, '경기', 169, '2023-04-23');
INSERT INTO user_tbl VALUES(NULL, 'Python', 2001, '부산', 182, '2023-03-07');
INSERT INTO user_tbl (user_name, user_birth_year, user_address, user_height, entry_date) VALUES('Swift', 1992, '광주', 140, '2023-02-11');

-- WHERE 조건절을 이용해서 조회
-- 90년대 이후 출생자만 조회
SELECT * FROM user_tbl WHERE user_birth_year > 1989;
SELECT * FROM user_tbl WHERE user_height < 175;
-- AND 혹은 OR을 이용해 조건을 두 개 이상 걸 수 있음
SELECT * FROM user_tbl WHERE user_num > 2 AND user_height < 178;

-- UPDATE 테이블명 SET 컬럼명1=대입값1, 컬럼명2=대입값2...;
-- 주의) WHERE를 걸지 않으면 해당 컬럼의 모든 값을 다 통일시켜버림
UPDATE user_tbl SET user_address = '제주';
-- WHERE 절 없는 UPDATE 구문 실행방지, 0 대입시 해제, 1 대입시 실행
set sql_safe_updates=1;

-- 테이블이 존재하지 않다면 삭제구문을 실행하지 않아 에러가 발생하지 않음
DROP TABLE IF EXISTS user_tbl;

-- 1번 유저 지역 변경
UPDATE user_tbl SET user_address = '강원' WHERE user_num = 1;
SELECT * FROM user_tbl;

-- 삭제는 특정 컬럼만 삭제할 일이 없으므로 SELECT와는 달리 * 등을 쓰지 않음
DELETE FROM user_tbl WHERE user_name = 'Python'; -- 이름이 Python인 사람 모두 삭제됨
DELETE FROM user_tbl WHERE user_num = 3; 
SELECT * FROM user_tbl;

-- 만약 WHERE 없이 삭제하면 TRUNCATE와 같은 결과 나옴
DELETE FROM user_tbl;

-- 다중 INSERT 구문
/* INSERT INTO 테이블명 (컬럼1, 컬럼2, 컬럼3...) VALUES (값1, 값2, 값3...), (값4, 값5, 값6...)...;
컬럼명은 모든 컬럼에 값을 집어넣을 시 생략 가능
*/
INSERT INTO user_tbl VALUES 
(NULL, 'TOM', 1994, '경남', 178, '2020-08-02'),
(NULL, 'JAMES', 1998, '전북', 170, '2020-08-03'),
(NULL, 'PAUL', 2000, '전남', 158, '2020-08-20');
SELECT * FROM user_tbl;

-- INSERT ~ SELECT 를 이용한 데이터 삽입을 위해 user_tbl과 동일한 테이블을 하나 더 만들어줌
CREATE TABLE user_tbl2(
	user_num int(5) PRIMARY KEY AUTO_INCREMENT, -- INSERT시 숫자 자동 배정
    user_name varchar(10) NOT NULL,
    user_birth_year int NOT NULL,
    user_address char(5) NOT NULL,
    user_height int, -- 자리수 제한 없음
    entry_date date -- 회원가입일user_tbl
);

-- user_tbl2에 user_tbl의 자료 중 생년 1995년 이후인 사람의 자료만 복사해서 삽입하기
INSERT INTO user_tbl2 SELECT * FROM user_tbl WHERE user_birth_year > 1995;
SELECT * FROM user_tbl2 WHERE user_birth_year > 1995;
SELECT * FROM user_tbl2;

-- 두 번째 테이블인 구매내역을 나타내는 buy_tbl을 생성
-- 어떤 유저가 무엇을 샀는지 저장하는 테이블
-- 반드시 user_tbl에 존재하는 유저만 추가할 수 있음
CREATE TABLE buy_tbl(
	buy_num INT AUTO_INCREMENT PRIMARY KEY,
    user_num INT(5) NOT NULL,
    prod_name VARCHAR(10) NOT NULL,
    prod_cate VARCHAR(10) NOT NULL,
    price INT NOT NULL,
    amount INT NOT NULL
);

-- 외래키 설정 없이 추가
INSERT INTO buy_tbl VALUES (NULL, 4, '아이패드', '전자기기', 100, 1);
INSERT INTO buy_tbl VALUES (NULL, 4, '애플펜슬', '전자기기', 15, 1);
INSERT INTO buy_tbl VALUES 
(NULL, 6, '트레이닝복', '의류', 10, 2),
(NULL, 5, '안마의자', '의료기기', 400, 1),
(NULL, 2, 'SQL책', '도서', 2, 1);

-- 있지도 않은 99번 유저의 구매내역 넣기
INSERT INTO buy_tbl VALUES(NULL, 99, '핵미사일', '전략무기', 100000, 5);
DELETE FROM buy_tbl WHERE buy_num = 6;

-- 외래키 설정을 통해서, 있지 않은 유저는 등록될 수 없도록 처리
-- buy_tbl이 user_tbl을 참조하는 관계
           -- 참조                                       -- 참조자의 컬럼           -- 참조당하는 테이블과 컬럼명
ALTER TABLE buy_tbl ADD CONSTRAINT FK_buy_tbl FOREIGN KEY (user_num) REFERENCES user_tbl(user_num);

-- 참조가 끝난 상태에서 있지도 않은 199번 유저의 구매내역 넣기
INSERT INTO buy_tbl VALUES(NULL, 199, '스포츠카', '승용차', 1000000, 1);

SELECT * FROM buy_tbl;
SELECT * FROM user_tbl;

-- 만약 user_tbl에 있는 요소를 삭제시, buy_tbl에 구매내역이 남은 user_num을 삭제한다면
-- 특별히 on_delete를 걸지 않은 경우는 참조 무결성 원칙에 위배되어 삭제되지 않음
DELETE FROM user_tbl WHERE user_num = 4;

-- 만약 추가적인 설정 없이 user_tbl의 4번 유저를 삭제하고 싶다면
-- 먼저 buy_tbl의 4번 유저가 남긴 구매내역을 모두 삭제해야 함
DELETE FROM buy_tbl WHERE user_num = 4;