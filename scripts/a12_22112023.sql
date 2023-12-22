-- AULA 12 - DML 2
-- INSERT, UPDATE e DELETE em Subconsultas

-- INSERT
-- criacao de novas tabelas
CREATE TABLE new_class (
	id_level int NOT NULL,
	id_class int NOT NULL,
	description varchar(200) NOT NULL,
	PRIMARY KEY (id_class, id_level)
);
CREATE TABLE new_level_game (
	id_level int NOT NULL,
	description varchar(200) NOT NULL,
	PRIMARY KEY (id_level)
);

-- insert de valores
INSERT INTO new_class (id_level, id_class, description) VALUES 
(17, 10, 'Adventure Other'),
(15, 1, 'Spy Other'),
(17, 20, 'British Comedy'),
(17, 30, 'Adventure'),
(14, 1, ''),
(18, 1, '');

-- validar dados inseridos
SELECT * FROM new_class;

-- verificar tabela antes do insert com subconsulta
SELECT * FROM new_level_game;

-- insert com subconsulta
INSERT INTO new_level_game (id_level, description) 
	(SELECT DISTINCT id_level, 'New level'
		FROM new_class
		WHERE id_level NOT IN (
			SELECT id_level
			FROM level_game)
	);
    
-- verificar tabela apos insert com subconsulta
SELECT * FROM new_level_game;

-- retorno do select para confirmacao
SELECT DISTINCT id_level, 'New level'
		FROM new_class
		WHERE id_level NOT IN (
			SELECT id_level
			FROM level_game);

-- SELECT INTO
-- este select ira retornar todos jogos nao completados
SELECT * FROM PLAY WHERE completed = '0'; 

-- create table com subconsulta ira criar uma nova tabela com as informações obtidas no select
CREATE TABLE PLAY_INCOMPLETED
(SELECT * FROM PLAY WHERE completed = '0');

-- confirmar dados da tabela
SELECT * FROM  play_incompleted;

-- exemplo de criacao de tabela especificando campos
CREATE TABLE PLAY_INCOMPLETED_W
(SELECT id_game, id_system_user FROM PLAY
WHERE completed = '0');

-- validacao
SELECT * FROM  play_incompleted_w;

-- UPDATE
-- atualizar para nível 20 todos os registros da tabela NEW_CLASS em que seu identificador de id_level encontrar dentro da tabela NEW_LEVEL_GAME

-- validacao de new_class
SELECT * FROM new_class;

-- validacao do select da subconsulta
SELECT id_level FROM new_level_game;

-- update com subconsulta
UPDATE new_class SET id_level = 20 WHERE id_level IN (SELECT id_level FROM new_level_game);

-- validacao do update
SELECT * FROM new_class;

-- DELETE

-- validar registro atual
SELECT * FROM new_class;

-- validar retorno subconsulta
SELECT id_level FROM NEW_LEVEL_GAME;

-- eliminar as novas categorias que não poderão estar relacionadas com nenhum registro da tabela NEW_LEVEL_GAME.
DELETE FROM NEW_CLASS WHERE id_level NOT IN (SELECT id_level FROM NEW_LEVEL_GAME);

-- validar registro alterado
SELECT * FROM new_class;

-- DESAFIO GENERICO
-- criar a tabela de ADVERGAME: mesmos campos da tabela game
CREATE TABLE ADVERGAME (
	id_game int NOT NULL PRIMARY KEY,
	name varchar(100) NOT NULL,
	description varchar(300),
	id_level int NOT NULL,
	id_class int NOT NULL
    );

-- adicionar os dados de 5 jogos na tabela 
INSERT INTO advergame (SELECT * FROM game LIMIT 5);

-- validar dados inseridos
SELECT * FROM advergame;

-- criar tabela ADVERCLASS id_level id_class 
CREATE TABLE ADVERCLASS (
	id_level int NOT NULL,
	id_class int NOT NULL,
	CONSTRAINT PRIMARY KEY (id_level, id_class)
	);

-- inserir os dados de id_level e id_class dos jogos que foram criados em ADVERGAME
INSERT INTO adverclass (SELECT id_level, id_class FROM advergame);

-- validacao dados
SELECT * FROM adverclass