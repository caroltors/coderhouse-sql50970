-- AULA 20 - LINGUAGEM TCL

SELECT @@AUTOCOMMIT; -- verificar se autocommit esta habilitado
SET AUTOCOMMIT = 0; -- desativar autocommit

-- START TRANSACTION, SEM IMPEDITIVOS

START TRANSACTION;

UPDATE class SET
	description = 'TRACKPAD BT'
WHERE
	id_level = 10 
AND 
	id_class = 1;
    
SELECT * FROM class WHERE id_level = 10 AND id_class = 1; -- validar registro

-- ROLLBACK TRANSACTION
START TRANSACTION;

DELETE FROM
	user_type
WHERE
	id_user_type = 2;
    
SELECT * FROM user_type ORDER BY id_user_type LIMIT 10; -- validar registro

ROLLBACK; -- desafazer operação

-- COMMIT 
-- UPDATE
START TRANSACTION;
UPDATE class SET
	description= '2D Digital Animation'
WHERE
	id_level = 7 AND
	id_class = 145;

-- INSERT 
START TRANSACTION;
INSERT INTO class (id_level, id_class, description) VALUES (15, 99, 'Test Class');

-- CONFIRMAR ALTERAÇÃO
COMMIT;

SELECT * FROM class WHERE id_class = 145 AND id_level = 7; -- validar registros
SELECT * FROM class WHERE id_class = 99; -- validar registros

-- SAVEPOINT > LOTES
START TRANSACTION;
INSERT INTO CLASS (id_level, id_class, description) VALUES (1, 1000,'class 1000');
INSERT INTO CLASS (id_level, id_class, description) VALUES (2, 1000,'class 1000');
INSERT INTO CLASS (id_level, id_class, description) VALUES (3, 1000,'class 1000');
INSERT INTO CLASS (id_level, id_class, description) VALUES (4, 1000,'class 1000');
INSERT INTO CLASS (id_level, id_class, description) VALUES (5, 1000,'class 1000');
INSERT INTO CLASS (id_level, id_class, description) VALUES (6, 1000,'class 1000');
INSERT INTO CLASS (id_level, id_class, description) VALUES (7, 1000,'class 1000');
INSERT INTO CLASS (id_level, id_class, description) VALUES (8, 1000,'class 1000');
SAVEPOINT lote_1;
INSERT INTO CLASS (id_level, id_class, description) VALUES (1, 1002,'class 1000');
INSERT INTO CLASS (id_level, id_class, description) VALUES (2, 1002,'class 1000');
INSERT INTO CLASS (id_level, id_class, description) VALUES (3, 1002,'class 1000');
INSERT INTO CLASS (id_level, id_class, description) VALUES (4, 1002,'class 1000');
INSERT INTO CLASS (id_level, id_class, description) VALUES (5, 1002,'class 1000');
INSERT INTO CLASS (id_level, id_class, description) VALUES (6, 1002,'class 1000');
INSERT INTO CLASS (id_level, id_class, description) VALUES (7, 1002,'class 1000');
INSERT INTO CLASS (id_level, id_class, description) VALUES (8, 1002,'class 1000');
SAVEPOINT lote_2;

-- ROLLBACK TO SAVEPOINT > desfazer alterações de um lote
ROLLBACK TO lote_1;

SELECT * FROM class WHERE description = 'class 1000'; -- validar se foi feito rollback do lote

-- RELEASE SAVEPOINT > eliminar savepoint
RELEASE SAVEPOINT lote_1;

-- ==== DESAFIO GENERICO ===
-- 1. Abra uma nova aba script e elimine três pagamentos dos que inserimos no slide 49, iniciando uma transação.

SELECT * FROM pay; -- validar registros da tabela

START TRANSACTION; -- iniciar transação
DELETE FROM pay WHERE id_pay IN (1, 2, 3);

-- 2. Validar os registros eliminados em outra aba script.

SELECT * FROM pay; -- validar registros da tabela

-- 3. Em seguida, na primeira aba de script, reverta a eliminação de pagamentos.

ROLLBACK; 
SELECT * FROM pay; -- validar registros da tabela

-- 4. Na tabela de pagamentos, insira um lote de 15 pagamentos, iniciando previamente a transação e estabelecendo um savepoint 
-- após o registro #5 e outro após o registro #10.
START TRANSACTION; -- iniciar transação
INSERT INTO pay (id_pay, amount, currency, date_pay, pay_type, id_system_user, id_game) VALUES (10, 0, 'R$', NOW(), NULL, 1,  1);
INSERT INTO pay (id_pay, amount, currency, date_pay, pay_type, id_system_user, id_game) VALUES (11, 0, 'R$', NOW(), NULL, 1,  1);
INSERT INTO pay (id_pay, amount, currency, date_pay, pay_type, id_system_user, id_game) VALUES (12, 0, 'R$', NOW(), NULL, 1,  1);
INSERT INTO pay (id_pay, amount, currency, date_pay, pay_type, id_system_user, id_game) VALUES (13, 0, 'R$', NOW(), NULL, 1,  1);
INSERT INTO pay (id_pay, amount, currency, date_pay, pay_type, id_system_user, id_game) VALUES (14, 0, 'R$', NOW(), NULL, 1,  1);
INSERT INTO pay (id_pay, amount, currency, date_pay, pay_type, id_system_user, id_game) VALUES (15, 0, 'R$', NOW(), NULL, 1,  1);
SAVEPOINT l1;
INSERT INTO pay (id_pay, amount, currency, date_pay, pay_type, id_system_user, id_game) VALUES (16, 0, 'R$', NOW(), NULL, 1,  1);
INSERT INTO pay (id_pay, amount, currency, date_pay, pay_type, id_system_user, id_game) VALUES (17, 0, 'R$', NOW(), NULL, 1,  1);
INSERT INTO pay (id_pay, amount, currency, date_pay, pay_type, id_system_user, id_game) VALUES (18, 0, 'R$', NOW(), NULL, 1,  1);
INSERT INTO pay (id_pay, amount, currency, date_pay, pay_type, id_system_user, id_game) VALUES (19, 0, 'R$', NOW(), NULL, 1,  1);
INSERT INTO pay (id_pay, amount, currency, date_pay, pay_type, id_system_user, id_game) VALUES (20, 0, 'R$', NOW(), NULL, 1,  1);
SAVEPOINT l2;
INSERT INTO pay (id_pay, amount, currency, date_pay, pay_type, id_system_user, id_game) VALUES (21, 0, 'R$', NOW(), NULL, 1,  1);
INSERT INTO pay (id_pay, amount, currency, date_pay, pay_type, id_system_user, id_game) VALUES (22, 0, 'R$', NOW(), NULL, 1,  1);
INSERT INTO pay (id_pay, amount, currency, date_pay, pay_type, id_system_user, id_game) VALUES (23, 0, 'R$', NOW(), NULL, 1,  1);
INSERT INTO pay (id_pay, amount, currency, date_pay, pay_type, id_system_user, id_game) VALUES (24, 0, 'R$', NOW(), NULL, 1,  1);
INSERT INTO pay (id_pay, amount, currency, date_pay, pay_type, id_system_user, id_game) VALUES (25, 0, 'R$', NOW(), NULL, 1,  1);

-- 5. Valide os registros inseridos em outra aba script.

SELECT * FROM pay ORDER BY id_pay DESC; -- validar registros da tabela

-- 6. Elimine o segundo savepoint.

ROLLBACK TO l1;

-- 7. Confirme a transação e valide novamente os registros inseridos em outra aba script.

SELECT * FROM pay ORDER BY id_pay DESC; -- validar registros da tabela