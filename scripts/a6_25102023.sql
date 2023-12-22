/*sintaxe DDL CREATE
CREATE TABLE [nome da tabela]( -- definimos o nome distintivo da tabela a ser criada. Por exemplo.: friend.
[definições de colunas]), -- definimos as colunas ou campos e suas propriedades ou tipo de dados.
 ([parâmetros da tabela]); -- definimos outras particularidades da tabela, por exemplo, os índices.*/

/* definicao de campos: nome do campo e/ou colunas; tipo de dado; aceita ou nao valores nulos
CREATE TABLE pay ( -- definicao nome da tabela
id_pay INT NOT NULL AUTO_INCREMENT, -- nome do campo; tipo de dado; not null; autoincrement
amount REAL NOT NULL, -- nome do campo; tipo de dados, not null;
currency VARCHAR(20) NOT NULL, -- nome do campo; tipo de dados, not null;
date_pay DATE NOT NULL, -- nome do campo; tipo de dados, not null;
pay_type VARCHAR(50), -- nome do campo; tipo de dados, null;
id_system_user INT NOT NULL, -- nome do campo; tipo de dados, not null;
id_game INT NOT NULL), -- nome do campo; tipo de dados, not null;
([parâmetros da tabela]));*/

-- criando nova tabela no schema ddl
CREATE TABLE friend(
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	first_name VARCHAR(30),
	last_name VARCHAR(30),
	email VARCHAR(30)
);

/*ddl alter, sintaxe
 ALTER TABLE [nome da tabela] - nome da tabela a ser alterado. 
ADD - a ação que realizaremos na tabela
[definições de colunas]; -- Definimos a(s) nova(s) coluna(s).
*/

-- Adicionando novo campo 'age'
ALTER TABLE friend
ADD age INT;

-- alterando tampo do campo email
ALTER TABLE friend
MODIFY email VARCHAR(50) NOT NULL;


-- clonar tabela/backup
CREATE TABLE friend_backup
LIKE friend; 
-- -- selecionar schema a ser utilizado
USE DDL;
-- deletar table
DROP TABLE friend; 

-- TRUNCATE
USE DDL; -- USE "SCHEMA"
TRUNCATE TABLE friend; -- TRUNCATE TABLE "NOME"

-- funções escalares integradas
-- CONCAT para unificar os campos 
SELECT concat(first_name, ' ', last_name) -- concatenando nome e sobrenome com espaço entre eles
AS complete_name
FROM system_user;

-- USASE para converter em maiusculo LCASE para converter em minusculo
SELECT UCASE(description) FROM class; -- trazendo a descrição em maiusculo
SELECT LCASE(description) FROM class; -- trazendo a descrição em minusculo

-- REVERSE para reverter a ordem dos caracteres de uma cadeia de texto.
SELECT REVERSE(description) FROM class;

-- utilizando funções de cadeia conjuntas
SELECT TRIM(UCASE(CONCAT(first_name, ' ', last_name, ' '))) AS nome_completo, -- remove espaços; maiusculo; concatena
	CHAR_LENGTH(TRIM(CONCAT(first_name, ' ', last_name, ' '))) AS qtd_carac -- conta os caracteres
 FROM system_user;

-- FUNÇÕES INTEGRADAS NUMERICAS
-- Divisão
SELECT (21 / 3) AS resultado;
-- Multiplicação
SELECT (7 * 3) AS resultado;
-- Soma
SELECT (18 + 3) AS resultado;
-- Subtração
SELECT (30 - 9) AS resultado;

/*DESAFIO GENERICO
Abrir uma aba de consulta (query tab) e executar as seguintes funções:*/

CREATE SCHEMA funcoes; -- criando novo schema
CREATE TABLE dados1( -- criacao de tabela e colunas
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	first_name VARCHAR(30) NOT NULL,
	last_name VARCHAR(30) NOT NULL,
	dt_nasc DATE NOT NULL,
    altura INT NOT NULL,
    peso INT NOT NULL
); 

-- inserindo dados
INSERT INTO dados (first_name, last_name, dt_nasc, altura, peso) VALUES ('Caroline', 'Torres', '1996-03-02', 163, 60);
INSERT INTO dados (first_name, last_name, dt_nasc, altura, peso) VALUES ('Bruna', 'Guardia', '1993-11-24', 151, 58);
SELECT * FROM dados;

-- insira seu nome completo (respeitando os espaços);
-- converta seu nome completo para minúsculas, depois para maiúsculas;
SELECT UCASE(CONCAT(first_name, ' ', last_name)) AS nome FROM dados;  
SELECT LCASE(CONCAT(first_name, ' ', last_name)) FROM dados; 
-- divida seu ano de nascimento por seu dia e mês (p. ex.: 1975 / 2103);
SELECT (1996 / 0203) AS resultado;
-- converta o resultado anterior em um inteiro absoluto;
SELECT ROUND(1996 / 0203) AS resultado;
-- calcule os dias que passaram desde o seu nascimento até hoje;
SELECT DATEDIFF('2023-10-25', dt_nasc) AS diferenca FROM dados;
-- verifique que dia da semana era quando você nasceu.
SELECT DAYNAME(dt_nasc) AS dia FROM dados WHERE id=1;