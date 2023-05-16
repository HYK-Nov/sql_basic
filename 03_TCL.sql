-- 트랜잭션은 2개 이상 각종 쿼리문의 실행을 되돌리거나 영구히 반영할 때 사용
-- 연습 테이블 생성
CREATE TABLE bank_account(
	act_num INT(5) PRIMARY KEY AUTO_INCREMENT,
    act_owner VARCHAR(10) NOT NULL,
    balance INT(10) DEFAULT 0 NOT NULL
);

INSERT INTO bank_account VALUES (NULL, '나구매', 50000), (NULL, '가판매', 0);

SELECT * FROM bank_account;

-- 트랜잭션 시작(시작점, ROLLBACK; 수행시 이 지점 이후의 내용을 전부 취소)
-- ctrl + enter로 실행
START TRANSACTION;

SET sql_safe_updates = 0;

UPDATE bank_account SET balance = (balance - 30000) WHERE act_owner = '나구매';
UPDATE bank_account SET balance = (balance + 30000) WHERE act_owner = '가판매';
SELECT * FROM bank_account;

ROLLBACK;
SELECT * FROM bank_account;

START TRANSACTION;

UPDATE bank_account SET balance = (balance - 25000) WHERE act_owner = '나구매';
UPDATE bank_account SET balance = (balance + 25000) WHERE act_owner = '가판매';
SELECT * FROM bank_account;
COMMIT;
ROLLBACK; -- 커밋한 이후에는 롤백해도 돌아갈 지점이 사라짐

-- SAVEPOINT는 ROLLBACK시 해당 지점 전까지는 반영, 해당 지점 이후는 반영 안 하는 경우 사용
START TRANSACTION;
UPDATE bank_account SET balance = (balance - 3000) WHERE act_owner = '나구매';
UPDATE bank_account SET balance = (balance + 3000) WHERE act_owner = '가판매';
SAVEPOINT first_tx; -- first_tx라는 저장지점 생성
UPDATE bank_account SET balance = (balance - 5000) WHERE act_owner = '나구매';
UPDATE bank_account SET balance = (balance + 5000) WHERE act_owner = '가판매';
SELECT * FROM bank_account;
ROLLBACK TO first_tx;