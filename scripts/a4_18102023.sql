-- AULA 18/10 -- 

-- EXERCITANDO OPERADORES
-- 1. Todos os comentários sobre jogos de 2019 em diante.
SELECT * FROM commentary WHERE comment_date >= '2019-01-01' order by comment_date asc; 
-- 2. Todos os comentários sobre jogos anteriores a 2011.
SELECT * FROM commentary WHERE comment_date < '2011-01-01' order by comment_date asc; 
-- 3. Os usuários e o texto dos comentários sobre jogos cujo código de jogo (id_game) seja 73.
SELECT id_system_user, commentary FROM commentary WHERE id_game = 73;
-- 4. Os usuários e o texto dos comentários sobre jogos cujo id de jogo não seja 73.
SELECT id_system_user, commentary FROM commentary WHERE id_game NOT LIKE '73';
-- 5. Os jogos de nível 1.
SELECT * FROM game WHERE id_level = 1; 
-- 6. Os jogos que sejam nível 14 ou superior.
SELECT * FROM game WHERE id_level >= 14;
-- 7. Os jogos de nome 'Riders Republic’ ou 'The Dark Pictures: House Of Ashes'.
SELECT * FROM game WHERE name IN ('Riders Republic', 'The Dark Pictures: House Of Ashes');
SELECT * FROM game WHERE name = 'Riders Republic' OR name = 'The Dark Pictures: House Of Ashes'; -- opcao adicional
-- 8. Os jogos cujo nome comece com 'Grande'.
SELECT * FROM game WHERE name like 'Grand%';
-- 9. Os jogos cujo nome contenha 'field'.
SELECT * FROM game WHERE name like '%field%';

-- ORDER BY -- 
SELECT * FROM game ORDER BY id_level desc; -- ordenacao por um campo
SELECT * FROM game ORDER BY id_level,id_class asc; -- ordenacao por dois campos

-- LIMIT 
SELECT * FROM play LIMIT 5; -- retornar 5 linhas
SELECT * FROM play LIMIT 10,1; -- de onde começara a trazer os dados, quantos dados vai trazer

-- ALIAS > Utilizacao de AS e apelido das tabelas
SELECT id_level AS Dificuldade, description AS Categoria FROM class c ORDER BY c.id_level, Categoria ASC;

-- FUNÇÕES DE AGREGAÇÃO E AGRUPAMENTO
-- contagem do campo id_system_user
SELECT COUNT (id_system_user) FROM system_user;  
-- retornar o primeiro nome registrado do campo
SELECT MIN (first_name) AS primeiro_nome FROM system_user; 
-- retornar o ultimo nome registrado do campo
SELECT MAX (first_name) AS ultimo_nome FROM system_user; 
-- total de jogos zerados
SELECT SUM (completed) AS qtde_zerados FROM play; 
-- media de jogos completados
SELECT AVG (complete) FROM play; 

-- GROUP BY e HAVING
-- DESAFIO GENERICO
-- retorna consulta ordenada do maior ao menor id_system_user
SELECT * FROM commentary ORDER BY id_system_user DESC;
-- retorna 3 primeiras linhas da consulta ordenada do maior ao menor id_system_user
SELECT * FROM commentary ORDER BY id_system_user LIMIT 3;
-- -- qtde de comentarios feitos pelo mesmo usuario agrupado por id_system_user
SELECT COUNT(id_system_user) AS comments, id_system_user FROM commentary GROUP BY id_system_user;
-- qtde de comentarios feitos pelo mesmo usuario agrupado por id_system_user que possuem mais de 2 comentarios
SELECT COUNT(id_system_user) AS comments, id_system_user FROM commentary GROUP BY id_system_user HAVING comments > 2;

-- retornar jogos completados agrupando por jogo que foram zerados
SELECT id_game,
	COUNT(completed) AS jogatinas
FROM play
WHERE completed = 1
GROUP BY id_game
ORDER BY COUNT(completed) DESC;

-- retornar contagem de jogos por usuario
SELECT id_system_user AS user, COUNT(*) AS games_by_user FROM play GROUP BY id_system_user;
-- retornar contagem de jogos por usuario que possuem contagem maior que 1
SELECT id_system_user AS user, COUNT(*) AS games_by_user FROM play GROUP BY id_system_user HAVING COUNT(*) > 1;

