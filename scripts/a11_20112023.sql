-- AULA DML 1
-- INSERT

-- exemplo pratico
INSERT INTO class (id_level,id_class,description) VALUES (1,999,'Spain comedy');
-- validar inserção
SELECT * FROM class WHERE id_class = 999;

-- criando a tabela pay para aplicar testes
CREATE TABLE pay (
id_pay 			INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
amount 			REAL NOT NULL,
currency 		VARCHAR(20) NOT NULL,
date_pay 		DATE NOT NULL,
pay_type 		VARCHAR(50),
id_system_user INT NOT NULL,
id_game 		INT NOT NULL);

-- verificar tabela criada
SELECT * FROM pay;

-- lidando com autoincrement
INSERT INTO pay VALUES (NULL, 250, 'U$S', '2021-07-22', 'Paypal', 850, 77);
-- validacao
SELECT * FROM pay;

-- insercao de dados parciais
INSERT INTO pay (id_pay, amount, currency, date_pay, id_system_user, id_game) VALUES ( NULL, 300, 'U$S', '2021-07-22', 501, 13);
INSERT INTO pay (id_pay, currency, date_pay, pay_type, id_system_user, id_game) VALUES ( NULL, 'U$S', '2021-07-22', '', 127, 91);

-- validar dados inseridos
SELECT * FROM pay;

-- inserir varios dados
INSERT INTO pay VALUES 
(NULL, 250, 'U$S', '2021-07-22', 'Paypal', 850, 77),
(NULL, 3700, 'Pesos Arg', '2021-07-22', 'Visa', 38, 31),
(NULL, 180, 'Libras', '2021-07-22', 'Transfer', 175, 16);

-- UPDATE
UPDATE pay SET currency = 'U$S' WHERE id_pay = 4;

-- validar update
SELECT * FROM pay WHERE id_pay = 4;

-- desabilitar modo seguro devido erro apresentado no update
SET SQL_SAFE_UPDATES = 0;

-- update da data de todos registros da tabela
UPDATE pay SET date_pay = CURRENT_DATE;
-- validando update
SELECT * FROM pay;

-- DELETE
DELETE FROM class WHERE id_level = 1 and id_class = 999;
-- validar delete
SELECT * FROM class WHERE id_class = 999;

-- DESAFIO GENERICO
INSERT INTO destinatario VALUES
(1, 'Rua Um, 25', 'Maria'),
(2, 'Rua Dois, 12', 'José'); 

INSERT INTO item VALUES
(1, '7', '300', '300', 'Pacote marrom'),
(2, '2', '120', '90', 'Pacote preto');

INSERT INTO cliente VALUES
(1, '12345678912', 'Cliente', 'Um', '11541287412', 'clienteum@mail', '02144562', 'SP', 'São Paulo', 'Avenida Um, 52'),
(2, '12345678913', 'Cliente', 'Dois', '11541287413', 'clientedois@mail', '02324562', 'SP', 'São Paulo', 'Avenida Dois, 28');

INSERT INTO entrega VALUES
(1, 'Fedex', '2', '99.99', 'Enviado'),
(2, 'Sedex', '15', '549.99', 'Entregue');

INSERT INTO encomenda VALUES
(1, 1, 1, 1, 1, CURRENT_DATE),
(2, 2, 2, 2, 2, CURRENT_DATE);

-- inserir valores inexistentes
INSERT INTO encomenda VALUES
(3, 3, 3, 3, 3, CURRENT_DATE);
/* é apresentado erro 15:32:16	Error Code: 1452. Cannot add or update a child row: a foreign key constraint fails 
(`delivery_service`.`encomenda`, CONSTRAINT `id_cliente` FOREIGN KEY (`id_cliente`) REFERENCES `cliente` (`id_cliente`))*/

INSERT INTO pag VALUES
(1, 1, 1, 1, 'Cartão de Crédito','Avenida Um, 25', 'Confirmado'),
(2, 2, 2, 2, 'Cartão de Crédito', 'Avenida Dois, 12', 'Confirmado');


