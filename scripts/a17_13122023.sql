-- triggers
/*
Estrutura geral de um trigger
create trigger `trigger_nome` -- nome
(before | after) -- momento
[insert | update | delete] -- ação
on nome_da_tabela -- tabela
[for each row | for each column] -- escolha do registro
[corpo do trigger]
*/
-- funcoes data e hora
SELECT NOW();
SELECT CURRENT_DATE();
SELECT CURDATE();
SELECT CURRENT_TIME();
SELECT CURTIME();
SELECT CURRENT_TIMESTAMP();

-- funcoes de usuario
SELECT SESSION_USER();
SELECT SYSTEM_USER();
SELECT USER();

-- funcoes de plataforma
SELECT DATABASE();
SELECT VERSION();

-- detectaremos a inserção de novos registros criando um LOG dos novos jogos inseridos no sistema que registrem o id_game, name e description 
-- criar tabela
CREATE TABLE new_games(
	id_game INT PRIMARY KEY,
	name varchar(100),
	description varchar(300)
);

-- trigger para insercao simultanea de multiplos registros ira registrar campos id_game, name e description na tabela new games
CREATE TRIGGER tr_add_new_game
AFTER INSERT ON game
FOR EACH ROW
	INSERT INTO new_games (id_game, name, description) VALUES (NEW.id_game, NEW.name, NEW.description);

-- insert em game para validar trigger
INSERT INTO game (id_game, name, description, id_level, id_class) VALUES
	(150, 'Mortal Kombat', 'PlayStation', 2, 143);

-- validacao
SELECT * FROM new_games;

-- DESAFIO GENERICO
/*Com a tabela comment do modelo gamers, deverá criar dois Triggers
A tabela de auditoria pode ser espelhada da tabela escolhida ou uma tabela do tipo LOG.
*/
SELECT * FROM comment;

-- 1. deve detectar a modificação de um registro da tabela em questão logo antes de ocorrer, armazenando em outra tabela first_date e last_date.
-- criar tabela log
CREATE TABLE comment_log (
	id_game INT PRIMARY KEY,
    first_date DATE,
    last_date  DATE, 
    modified TIMESTAMP,
    user VARCHAR(100)
);

-- criar trigger
CREATE TRIGGER tr_modified
BEFORE UPDATE ON comment
	FOR EACH ROW
	INSERT INTO comment_log (id_game, first_date, last_date, modified, user) VALUES 
		(OLD.id_game, OLD.first_date, OLD.last_date, NOW(), USER());

-- executar modificacao em comment
UPDATE comment SET first_date = NOW() WHERE id_game = 1 AND id_system_user = 771;

-- validar tabela de log
SELECT * FROM comment_log;

-- 2. deve detectar a eliminação de um registro posterior a essa operação, registrando também a data e hora e o usuário que o eliminou.
-- criar tabela
CREATE TABLE comment_audit (
	id_game INT,
    id_system_user INT,
    first_date DATE,
    last_date  DATE, 
    deleted TIMESTAMP,
    user VARCHAR(100)
);

-- criando trigger
CREATE TRIGGER tr_delete
AFTER DELETE ON comment
	FOR EACH ROW
	INSERT INTO comment_audit (id_game, id_system_user,  first_date, last_date, deleted, user) VALUES 
		(OLD.id_game, OLD.id_system_user, OLD.first_date, OLD.last_date, NOW(), USER());
        
-- deletar registro de comment
SET FOREIGN_KEY_CHECKS=0; -- desabilitar checagem de fk
DELETE FROM comment WHERE id_game = 1;

-- validar tabela de auditoria
SELECT * FROM comment_audit;