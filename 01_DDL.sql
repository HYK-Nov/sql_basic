/* 실행은 ctrl + enter
데이터베이스 생성 명령
데이터베이스 내부에 테이블들이 적재되기 때문에 먼저 데이터베이스를 생성해야 함.
DEFAULT CHARACTER SET UTF8; 을 붙여주면 한글설정 됨 
내가 지정하는 이름 등을 제외한 쿼리문은 대문자로 작성하는게 일반적 */
CREATE DATABASE bitcamp06 DEFAULT CHARACTER SET UTF8;

/* 데이터베이스 조회는 좌측 하단 중간쯤 Schemas를 클릭 -> 새로고침 한 다음, bitcamp6이 생성된게 확인되면
우클릭 -> set as default schemas 선택, 볼드처리되고 지금부터 적는 쿼리문은 해당 DB에 들어간다는 의미 */
/* 해당 DB에 접근할 수 있는 사용자 계정 생성 / USER - id 역할, IDENTIFIED BY - pw 역할 */
CREATE USER 'adminid' IDENTIFIED BY '2023502';

/* 사용자에게 권한 부여: GRANT 주고 싶은 기능1, 기능2, ... 
만약 모든 권한을 주고 싶다면 ALL PRIVELEGES(모든권한) TO 부여받을계정명*/
GRANT ALL PRIVILEGES ON bitcamp06.* TO 'adminid';

/* 테이블 생성 명령 
PRIMARY KEY: 컬럼의 주요 키를 뜻하고, 중복 데이터 방지도 겸함
모든 테이블의 컬럼 중 하나는 반드시 PK속성이 부여되어 있어야 함.
NOT NULL: 해당 컬럼을 비워둘 수 없다는 의미
UNIQUE: 중복 데이터가 입력되는 것을 방지 */
CREATE TABLE users(
	u_number int(3) PRIMARY KEY,
    u_id VARCHAR(20) UNIQUE NOT NULL,
    u_name VARCHAR(30) NOT NULL,
    email VARCHAR(80)
);

/* 데이터 적재
INSERT INTO 테이블명(컬럼1, 컬럼2...) VALUES(값1, 값2...);
*/
INSERT INTO users(u_number, u_id, u_name, email) VALUES (1, 'abc1234', '가나다', NULL);
INSERT INTO users VALUES (2, 'abc3456', '마바사', 'abc@ab.com');

/* 데이터 조회
SELECT * FROM 테이블명; 을 적으면 해당 테이블에 적재된 데이터를 조회할 수 있음
SELECT 컬럼1, 컬럼2 FROM 테이블명; 을 이용해서 특정 컬럼에 적재된 데이터만 조회 가능*/
SELECT * FROM users;

INSERT INTO users VALUES (3, 'qwerty', '에에엥', NULL);

SELECT email, u_number, u_id FROM users;

CREATE USER 'adminid2' IDENTIFIED BY '2023502';
GRANT SELECT ON bitcamp06.* TO 'adminid2';

-- users 테이블에 주소 컬럼 추가
-- ALTER TABLE 테이블명 ADD (추가컬럼명 자료타입(크기));
ALTER TABLE users ADD (u_address VARCHAR(30));

-- 컬럼 삭제
ALTER TABLE users DROP COLUMN email;

-- u_address 컬럼에 UNIQUE 제약조건 별칭 부여해서 걸기
ALTER TABLE users ADD CONSTRAINT u_address_unique UNIQUE (u_address);

INSERT INTO users VALUES (7, 'ppp', '피피피', '강남구');
INSERT INTO users VALUES (8, 'ttt', '티티티', '강남구');

SELECT * FROM users;

-- UNIQUE 해제
ALTER TABLE users DROP CONSTRAINT u_address_unique;

-- users 테이블명을 members로 변경
RENAME TABLE users TO members;
SELECT * FROM members;

-- TRUNCATE TABLE은 내부 데이터만 소각. 빈 테이블은 남아있음
TRUNCATE TABLE members;
SELECT * FROM members;

-- DROP TABLE은 내부 데이터 및 테이블 구조 자체를 없앰
DROP TABLE members;
SELECT * FROM members;