-- demonstração de view
CREATE OR REPLACE VIEW gamer_view AS-- nome da view
	SELECT * FROM game; -- o que a view terá
    
-- obtendo diferentes informações de uma tabela com várias views
-- OBTER TODOS OS DADOS DE UMA TABELA
CREATE VIEW games AS 
	SELECT * FROM game;
-- executar view
SELECT * FROM games; 
-- VISUALIZAR SOMENTE NOMES E DESCRIÇÕES DOS JOGOS DE VIDEOGAME
CREATE OR REPLACE VIEW games AS
	SELECT name, description FROM game;
-- executar view
SELECT * FROM games; 
-- VISUALIZAR SOMENTE OS JOGOS DE VIDEOGAME COM NOME CALL OF DUT
CREATE OR REPLACE VIEW games AS
	SELECT name, description FROM game
    WHERE name like upper('Call Of Duty%');
-- executar view
SELECT * FROM games; 

-- view que liste os nomes e descrição dos diferentes jogos de videogame que nenhum usuário conseguiu completar.
CREATE OR REPLACE VIEW games AS
	SELECT DISTINCT name, description
	FROM game v 
	JOIN play p 
	ON v.id_game = p.id_game
	WHERE p.completed = false;
-- executar view
SELECT * FROM games;

-- DESAFIO GENERICO - Sobre o esquema gamers, crie as seguintes views:
-- que mostre first_name e last_name dos usuários que tenham e-mail ‘webnode.com’;
CREATE OR REPLACE VIEW users AS
	SELECT first_name, last_name 
    FROM system_user
	WHERE email LIKE '%webnode.com%';

SELECT * FROM users; -- executar view

-- que mostre todos os dados dos jogos que tenham sido finalizados;
CREATE OR REPLACE VIEW completed AS
	SELECT DISTINCT g.id_game, g.name, g.description, g.id_level, g.id_class FROM game g 
	JOIN play p 
	ON g.id_game = p.id_game
	WHERE p.completed = true;
    
SELECT * FROM completed; -- executar view

-- que mostre os diferentes jogos que tiveram uma votação maior que 9;
CREATE OR REPLACE VIEW voted AS
	SELECT DISTINCT g.name, v.value FROM game g 
	JOIN vote v 
	ON g.id_game = v.id_game
	WHERE value > 9;

SELECT * FROM voted; -- executar view

-- que mostre nome, sobrenome e e-mail dos usuários que jogam o jogo FIFA 22.
CREATE OR REPLACE VIEW fifa AS
	SELECT u.first_name, u.last_name, u.email FROM system_user u
	JOIN play p
	ON p.id_system_user = u.id_system_user
    JOIN game g
    ON g.id_game = p.id_game
	WHERE g.name LIKE '%fifa%';

-- para o exercicio acima para obter o mesmo resultado utilizando subqueries
SELECT DISTINCT first_name, last_name, email FROM system_user su 
JOIN play p 
ON (su.id_system_user = p.id_system_user)
WHERE p.id_game IN (SELECT id_game FROM game WHERE name LIKE'FIFA 22%');

SELECT * FROM fifa; -- executar view
