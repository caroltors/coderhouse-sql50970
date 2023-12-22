-- testando função criada
SELECT calcular_litros_de_tinta(22, 5, 3) AS total_tinta; 
-- essa função era NOSQL



-- DESAFIO GENERICO
-- função chamada get_game() na DB GAMERS para obter o nome do jogo, passando o parâmetro id_game 
-- validar campo name
SHOW COLUMNS FROM GAME;
-- name varchar(100)

-- obter nopme da tabela, colunas e tipo de dados 
SELECT 
    table_name,
    column_name,
    data_type
FROM 
    information_schema.columns
WHERE 
    table_schema = 'gamer';
    
-- exemplo em aula no sql IMC
DELIMITER $$ 
CREATE FUNCTION calcular_imc (peso FLOAT, altura FLOAT)
RETURNS VARCHAR(50)
NO SQL
BEGIN
	DECLARE resultado varchar(50);
	DECLARE imc FLOAT;
    DECLARE limite_magreza FLOAT;
    DECLARE limite_obesidade FLOAT;
    SET limite_magreza = 18.5;
    SET limite_obesidade = 24.9;
    SET imc = peso / POWER(altura, 2);
    SET resultado = CASE
		WHEN imc < limite_magreza THEN 'coma o mundo'
        WHEN imc > limite_obesidade THEN 'coma direitinho'
        WHEN imc > limite_magreza AND imc < limite_obesidade THEN 'show, carpe diem'
        END;
	RETURN resultado;
END;
$$    

-- validar funcao
SELECT calcular_imc(56, 1.63) AS imc;

-- criar função
DELIMITER $$ -- para poder criar sem ir até função
CREATE FUNCTION get_game (id_jogo INT)
RETURNS VARCHAR(100) -- igual ao tipo de campo quie sera retornado
DETERMINISTIC 
BEGIN
	DECLARE nome_jogo VARCHAR(100);
    SET nome_jogo = (SELECT name FROM GAME WHERE id_game = id_jogo);
    RETURN nome_jogo;
END;
$$

-- validar função
SELECT get_game(62) AS nome_jogo;