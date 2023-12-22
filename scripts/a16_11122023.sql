/* stored procedures, sintaxes:

======= BASICA =======
DELIMITER $$
 CREATE PROCEDURE `nome_do_sp` 
	BEGIN 
		SELECT id, name FROM minha_tabela; 
	END $$

======= ENTRADA PARAMETROS =======
DELIMITER $$
CREATE PROCEDURE `nome_do_sp` (IN parametro1 CHAR(40))
	BEGIN
		SELECT * FROM produtos WHERE nome LIKE parametro1;
	END $$

======= SAIDA DE PARAMETROS =======
DELIMITER  $$
CREATE PROCEDURE `nome_do_sp` (OUT total INTEGER)
	BEGIN
		SELECT COUNT(*) INTO total FROM produtos 
		WHERE habilitado = TRUE;
	END $$
*/

-- IMPLEMENTAÇÃO

DELIMITER  $$
CREATE PROCEDURE sp_get_games ()
	BEGIN
		SELECT * FROM gamer.game;
	END $$
    
CALL sp_get_games();

-- SP receberá um parâmetro que referenciará um campo da tabela e indicará a ordem da consulta a ser mostrada. 
DELIMITER $$
CREATE PROCEDURE `sp_get_games_order` (IN field CHAR(20))
BEGIN
    IF field <> '' THEN -- Comparamos se o parâmetro de entrada field inclui ou não um valor.
        SET @game_order = CONCAT('ORDER BY ', field); -- Se o incluir, definimos uma variável @game_order com a cláusula ORDER BY
    ELSE
        SET @game_order = ''; -- Se não, definimos a mesma variável, mas vazia
    END IF;
    -- Declaremos uma nova variável @clausula em que concatenamos a sentença SQL junto ao ordenamento estabelecido na variável @game_order.
    SET @clausula = CONCAT('SELECT * FROM game ', @game_order); 
    -- Em seguida invocamos a cláusula PREPARE para converter a cadeia SQL em um objeto interpretável pela engine da DB.
    PREPARE runSQL FROM @clausula;
    EXECUTE runSQL;
    DEALLOCATE PREPARE runSQL;
END $$
DELIMITER ;

CALL sp_get_games_order ("name");

-- desafio generico crie um Stored Procedure que insira dados em uma tabela

DELIMITER $$
CREATE PROCEDURE `sp_insert` (IN ins_data CHAR(50))
BEGIN
    IF ins_data IS NULL OR ins_data = '' THEN
        -- Se o parâmetro char() recebido for nulo ou vazio, retornar erro
        SELECT 'erro: não foi possível criar o produto indicado' AS mensagem_erro;
    ELSE
        -- Inserir o parâmetro como um novo registro na tabela
        -- SEM O PREPARE, EXECUTE E DELLOCATE: INSERT INTO produtos (nome) VALUES (ins_data);
        PREPARE stmt FROM 'INSERT INTO produtos (nome) VALUES (?)';
        SET @ins_data = ins_data; -- Atribuir valor do parâmetro a uma variável
        EXECUTE stmt USING @ins_data;
        DEALLOCATE PREPARE stmt;

        -- Executar um SELECT sobre a tabela ordenada de forma decrescente para ver o registro inserido em primeiro lugar
        -- SEM O PREPARE, EXECUTE E DELLOCATE: SELECT nome FROM produtos ORDER BY id DESC;
        PREPARE stmt FROM 'SELECT nome FROM produtos ORDER BY id DESC';
        EXECUTE stmt;
        DEALLOCATE PREPARE stmt;
        
    END IF;
END $$

CALL sp_insert ("Notebook Lenovo");