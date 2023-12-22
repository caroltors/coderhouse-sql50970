-- aula 13 inserção por importação
-- criando produtos dentro de gamer

CREATE TABLE produtos (
	id int NOT NULL AUTO_INCREMENT, 
	nome varchar(40) NOT NULL, 
	existencia int NOT NULL DEFAULT '0', 
	preco float NOT NULL DEFAULT '0', 
	preco_compra float NOT NULL DEFAULT '0', 
	PRIMARY KEY (id)
);

SELECT * FROM produtos;