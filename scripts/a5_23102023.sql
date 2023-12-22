-- uso do operador like
-- % começam com FIFA 
SELECT name FROM game WHERE name LIKE 'FIFA%';
-- % terminam com 22
SELECT name FROM game WHERE name LIKE '%22';
-- % possuem horizon
SELECT name FROM game WHERE name LIKE '%horizon%';
-- caracter curinga, utilizar _ 
SELECT * FROM game WHERE name LIKE '___l%';
-- regex, deverá ser estudado seu uso

-- DESAFIO GENERICO
-- Aqueles usuários cujo nome comece com a letra ‘J’.
SELECT first_name FROM system_user WHERE first_name LIKE 'J%';
-- Aqueles usuários cujo sobrenome contenha a letra ‘W’.
SELECT last_name FROM system_user WHERE last_name LIKE '%W%';
-- Aqueles usuários cujo nome contenha a letra ‘i’ na segunda posição.
SELECT first_name FROM system_user WHERE first_name LIKE '_I%';
-- Aqueles usuários cujo nome termine com a letra ‘k’.
SELECT first_name FROM system_user WHERE first_name LIKE '%K';
-- Aqueles usuários cujo nome não inclua as letras ‘ch’.
SELECT first_name FROM system_user WHERE first_name NOT LIKE '%ch%';
-- Aqueles usuários cujo nome inclua as letras ‘ch’.
SELECT first_name FROM system_user WHERE first_name LIKE '%ch%';

-- SUBCONSULTAS
-- tabelas diferentes
-- usa o resultado da segunda consulta para realizar a consulta principal
SELECT id_system_user, last_name
FROM system_user
WHERE id_user_type = (SELECT max(id_user_type) FROM user_type) -- busca essa informação em uma tabela diferente
ORDER BY last_name ASC;

-- maior id_user_type
SELECT max(id_user_type) FROM user_type;
-- SELECT id_user_type FROM user_type ORDER BY id_user_type DESC;

-- mesma tabela
SELECT
	value, id_system_user
FROM 
	vote 
WHERE 
	value = (SELECT FLOOR(AVG(value)) FROM vote); -- subconsulta equivale a 4 e usa o flor pra converter para inteiro

-- subconsulta independente
SELECT FLOOR(AVG(value)) FROM vote;

-- tabelas diferentes
SELECT SUM(value) -- soma dados da coluna value
FROM vote
WHERE id_game = (SELECT min(id_game) FROM game); -- pega o menor id_game da tabela game

-- mesma tabela
SELECT id_system_user 
FROM vote
WHERE value > (SELECT avg(value) FROM vote);

-- subconsulta com ordenação
SELECT id_system_user, last_name
FROM system_user
WHERE id_user_type = (SELECT max(id_user_type) FROM user_type)
ORDER BY last_name ASC;

-- subconsulta com agrupamento
-- agrupamento por id_game da soma dos votos
SELECT id_game, SUM(value) AS votos -- nao seria possivel rodar o select com a função sem o group by
FROM vote  
WHERE id_game IN (SELECT id_game 
FROM game WHERE id_level = 1) -- subconsulta retorna todos id_game que possuem id_level = 1
GROUP BY id_game;

-- having em subconsultas
SELECT id_game, name
FROM game
WHERE id_level = 1 AND
	id_game IN
		(SELECT id_game
		FROM vote
		GROUP BY id_game
		HAVING count(*) > 1);
        
-- desafio generico
-- jogos jogados por jogador;
-- condicionais no nome dos usuários;
-- integração de HAVING;
-- funções de agregação e GROUP BY;


