-- OBJETOS DE UM BANCO DE DADOS
CREATE DATABASE STORE; -- criar schema
USE STORE; -- usar schema criado
-- criar tabela e elementos
CREATE TABLE products( 
	product_id INT,
	product_name VARCHAR(50),
    product_value FLOAT,
	PRIMARY KEY (product_id)
);
-- inserir dados nos campos
INSERT INTO products (product_id, product_name, product_value) VALUES
	(1, 'Refrigerante', '4.5'),
	(2, 'Água', '2'),
	(3, 'Vinho', '15'),
	(4, 'Suco', '5'),
	(5, 'Cerveja', '9');
-- criar nova tabela que sera relacionada
CREATE TABLE clients(
	client_id INT,
    client_name VARCHAR(50),
    product_id INT,
    PRIMARY KEY (client_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);
-- inserir dados
INSERT INTO clients (client_id, client_name, product_id) VALUES
	(476, 'Roberta', 3),
	(477, 'Stael', 4),
	(478, 'Arnaldo', 5),
	(479, 'Isabela', 2);
-- deletar dados
DELETE FROM store.products WHERE product_id = 3;
-- deletar produto sem relacionamento
DELETE FROM store.products WHERE product_id = 1;
-- deletar cna tabela pai
DELETE FROM store.clients WHERE product_id = 2;

-- VIEWS
-- duvida > funcoes em uma view?
USE GAMER;

CREATE VIEW gamer_view AS
	SELECT
		g.name AS jogo,
		c.commentary AS comentario
	FROM commentary c
	INNER JOIN game g
	ON c.id_game = g.id_game
	ORDER BY g.name;
    
-- executar view
SELECT * FROM gamer_view;

-- FUNÇOES
-- tabela gamer, criando funcao
CREATE FUNCTION count_games(id_game2 INT) -- necessario passar o parametro e definir formato
RETURNS INT -- definir como a informação sera retornada, ex.: INT
DETERMINISTIC -- normalmente é deterministica, uma função RANDOM por ex. é não deterministica
RETURN (
	SELECT COUNT(*) FROM play WHERE id_game = id_game2 -- definir o resultado
);
-- retornar contagem de acordo com o ID
SELECT count_games(1); 

-- TRIGGERS
DELIMITER $$
CREATE TRIGGER user_type_default
BEFORE INSERT -- antes de inserir um novo valor
ON user_type FOR EACH ROW  -- na tabela para cada linha
BEGIN
	IF NEW.description IS NULL THEN -- se a descrição for nula entao 
		SET NEW.description = 'padrao'; -- sete a descrição como padrão
	END IF;
END $$

-- insert sem descrição
INSERT INTO user_type (id_user_type) VALUES (501);
-- validar se inseriu
SELECT * FROM user_type WHERE id_user_type = '501';

-- STORED PROCEDURES
DELIMITER $$ -- iniciando ambiente de configuração
-- consulta dentro da tabela games que irá juntar o id ao nome
CREATE PROCEDURE play_games (id_game2 INT) 
BEGIN
	SELECT 
		name AS 'Nome do Jogo',
		id_system_user AS 'ID do Usuário',
		completed AS 'Zerado'
	FROM play AS p
	INNER JOIN game AS g
	ON p.id_game = g.id_game
	WHERE p.id_game = id_game2;
END;
-- consulta da procedure
CALL play_games(50)