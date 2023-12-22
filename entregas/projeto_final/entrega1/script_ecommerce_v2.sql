/* PROJETO FINAL: ECOMMERCE 
O banco de dados e-commerce, tem o objetivo de armazenar os dados envolvidos neste fluxo. 
Como, as informações dos clientes e sua jornada na plataforma, os dados relacionados aos produtos e todas as informações de pedidos, 
pagamentos e entrega associados a este. 
*/
-- CRIAR BANCO BANCO DE DADOS
CREATE SCHEMA ecommerce;

-- CRIAÇÃO DAS TABELAS: PRODUCT (tb_dim - product_category) 
-- Tabela que contém as informações dos produtos. 
CREATE TABLE `product` (
  `id` int NOT NULL, -- id do produto PK
  `id_category` int NOT NULL, -- id de product category FK
  `name` varchar(45) NOT NULL, -- nome do produto
  `desc` varchar(255) DEFAULT NULL, -- descricao produto
  `dimensions` varchar(45) DEFAULT NULL, -- altura x largura x comprimento em cm
  `weight` int DEFAULT NULL, -- peso produto
  `amount` int NOT NULL, -- qtde produto em estoque
  `value` decimal(10,0) NOT NULL, -- valor produto
  PRIMARY KEY (`id`) -- definir id do produto como PK
);

-- CRIAÇÃO DAS TABELAS: PRODUCT_CATEGORY (tb_fato)
-- Tabela que contém a categoria dos itens/produtos. 
CREATE TABLE `product_category` (
  `id` int NOT NULL, -- id categoria
  `name` varchar(45) NOT NULL, -- nome categoria
  `desc` varchar(255) DEFAULT NULL, -- descricao categoria
  PRIMARY KEY (`id`)
);

-- CRIAÇÃO DAS TABELAS: CUSTOMER (tb_fato)
-- Tabela que contém os clientes do e-commerce. 
CREATE TABLE `customer` (
  `id` int NOT NULL, -- id cliente
  `cpf` varchar(11) NOT NULL, -- padrao de caracteres de cpf
  `name` varchar(255) NOT NULL, -- nome cliente
  `last_name` varchar(255) NOT NULL, -- sobrenome
  `phone` varchar(20) NOT NULL, -- telefone
  `mail` varchar(45) NOT NULL, -- email
  `created_at` timestamp(6) NOT NULL, -- data cadastro criado
  `updated_at` timestamp(6) DEFAULT NULL, -- data cadastro modificado
  PRIMARY KEY (`id`) -- definir id cliente como pk
);

-- NOVA TABELA 
-- CRIAÇÃO DAS TABELAS: LOGIN_CUSTOMER (tb_dim - customer)
-- Tabela que contém os dados de login dos clientes.
CREATE TABLE `login_customer` (
  `id_customer` int NOT NULL, -- id cliente FK PK
  `username` varchar(25) NOT NULL, -- usuario de login
  `password` varchar(45) NOT NULL, -- senha de login
  `last_login` timestamp(6) DEFAULT NULL -- ultimo login
);

-- CRIAÇÃO DAS TABELAS: CUSTOMER_ADDRESS (tb_dim - customer)
-- Tabela que contém o endereço do cliente.
CREATE TABLE `customer_address` (
  `id` int NOT NULL, -- id endereço
  `id_customer` int NOT NULL, -- id cliente FK
  `postal_code` int NOT NULL, -- cep
  `country` varchar(255) NOT NULL, -- pais
  `state` varchar(255) NOT NULL, -- estado
  `city` varchar(255) NOT NULL, -- cidade
  `address` varchar(255) NOT NULL, -- endereço
  PRIMARY KEY (`id`) -- definir id endereço como pk
);

-- NOVA TABELA
-- CRIAÇÃO DAS TABELAS: PAYMENT_CUSTOMER (tb_dim - customer) 
-- Tabela que contém as informações de pagamento do cliente
CREATE TABLE `payment_customer` (
  `id` int NOT NULL, -- id pagamento
  `id_customer` int NOT NULL, -- id cliente FK
  `pay_type` int DEFAULT NULL, -- tipo de pagamento
  `card_number` int DEFAULT NULL, -- numero cartao
  `exp_date` int DEFAULT NULL, -- data expira
  PRIMARY KEY (`id`) -- definir id pagamento como pk
);

-- NOVA TABELA
-- CRIAÇÃO DAS TABELAS: CARRIER (tb_fato)
-- Tabela que contém as informações das transportadoras. 
CREATE TABLE `carrier` (
  `id` int NOT NULL, -- id transportadora
  `name` int NOT NULL, -- nome da transportadora
  `value` decimal(10,0) DEFAULT NULL, -- valor por km
  PRIMARY KEY (`id`) -- definir id carrier como pk
);

-- ALTERANDO TIPO DE DADO DO CAMPO NAME
ALTER TABLE `ecommerce`.`carrier` 
CHANGE COLUMN `name` `name` VARCHAR(255) NOT NULL ;

-- CRIAÇÃO DAS TABELAS: SHIPPING (tb_dim - order, carrier) 
-- Tabela que contém as informações de entrega dos pedidos.
CREATE TABLE `shipping` (
  `id` int NOT NULL, -- id entrega
  `id_order` int NOT NULL, -- id pedido FK
  `id_carrier` int NOT NULL, -- id transportadora FK
  `value` decimal(10,0) NOT NULL, -- valor da entrega
  `status` varchar(45) NOT NULL, -- status da entrega
  `date` datetime DEFAULT NULL, -- data da entrega
  PRIMARY KEY (`id`) -- definir id shipping como pk
);

-- CRIAÇÃO DAS TABELAS: ORDER (tb_dim - customer, payment_customer, items, order_status) 
-- Tabela que contém os pedidos dos clientes.
CREATE TABLE `order` (
  `id` int NOT NULL, -- id do pedido PK
  `id_customer` int NOT NULL, -- id do cliente FK
  `id_pay` int NOT NULL, -- id de pagamento do pedido FK
  `id_items` int NOT NULL, -- id de itens do pedido FK
  `id_status` int NOT NULL, -- id status do pedido FK
  `created_at` timestamp(6) NOT NULL,
  `updated_at` timestamp(6) DEFAULT NULL,
  PRIMARY KEY (`id`) -- definir id do pedido como PK
);

-- CRIAÇÃO DAS TABELAS: ORDER_STATUS (tb_fato) 
-- Tabela que contém o status de pedidos.
CREATE TABLE `order_status` (
  `id` int NOT NULL, -- id do pedido PK
  `name` varchar(45), -- nome do status
  `desc` varchar(255), -- descrição do status
PRIMARY KEY (`id`) -- definir id do status como PK
);

-- ALTERAR PARA NOT NULL O CAMPO NAME DE ORDER_STATUS
ALTER TABLE `ecommerce`.`order_status` 
CHANGE COLUMN `name` `name` VARCHAR(45) NOT NULL ;

-- CRIAÇÃO DAS TABELAS: ORDER_ITEMS (tb_dim - product) 
-- Tabela que contém os itens de um pedido.
CREATE TABLE `order_items` (
  `id` int NOT NULL, -- id dos itens do pedido PK
  `id_product` int NOT NULL,  -- id do produto FK
  `amount` int NOT NULL, -- qtde por produto
  PRIMARY KEY (`id`) -- definir id dos itens como PK
);

-- CRIAÇÃO DAS TABELAS: ORDER_HISTORY (tb_dim - orders) 
-- Tabela que contém o histórico de pedidos dos clientes. 
CREATE TABLE `order_history` (
  `id` int NOT NULL,  -- id do historico
  `id_order` int NOT NULL, -- id do pedido FK
  PRIMARY KEY (`id`) -- definir id do historico como PK
);

-- RELACIONAMENTO DE TABELAS COM FK

-- TABELA PRODUCT
ALTER TABLE `ecommerce`.`product` 
ADD INDEX `id_category_idx` (`id_category` ASC) VISIBLE;
;
ALTER TABLE `ecommerce`.`product` 
ADD CONSTRAINT `id_category`
  FOREIGN KEY (`id_category`)
  REFERENCES `ecommerce`.`product_category` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

-- TABELA LOGIN_CUSTOMER
ALTER TABLE `ecommerce`.`login_customer` 
ADD INDEX `id_customer_idx` (`id_customer` ASC) VISIBLE;
;
ALTER TABLE `ecommerce`.`login_customer` 
ADD CONSTRAINT `id_customer`
  FOREIGN KEY (`id_customer`)
  REFERENCES `ecommerce`.`customer` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
ALTER TABLE `ecommerce`.`login_customer` 
ADD PRIMARY KEY (`id_customer`);
;

-- TABELA CUSTOMER_ADDRESS
ALTER TABLE `ecommerce`.`customer_address` 
ADD INDEX `id_customer2_idx` (`id_customer` ASC) VISIBLE;
;
ALTER TABLE `ecommerce`.`customer_address` 
ADD CONSTRAINT `id_customer2`
  FOREIGN KEY (`id_customer`)
  REFERENCES `ecommerce`.`customer` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

-- TABELA PAYMENT_CUSTOMER 
ALTER TABLE `ecommerce`.`payment_customer` 
ADD INDEX `id_customer3_idx` (`id_customer` ASC) VISIBLE;
;
ALTER TABLE `ecommerce`.`payment_customer` 
ADD CONSTRAINT `id_customer3`
  FOREIGN KEY (`id_customer`)
  REFERENCES `ecommerce`.`customer` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

-- TABELA SHIPPING
ALTER TABLE `ecommerce`.`shipping` 
ADD INDEX `id_order_idx` (`id_order` ASC) VISIBLE,
ADD INDEX `id_carrier_idx` (`id_carrier` ASC) VISIBLE;
;
ALTER TABLE `ecommerce`.`shipping` 
ADD CONSTRAINT `id_order`
  FOREIGN KEY (`id_order`)
  REFERENCES `ecommerce`.`order` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT `id_carrier`
  FOREIGN KEY (`id_carrier`)
  REFERENCES `ecommerce`.`carrier` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

-- TABELA SHIPPING ADICIONAR ID DE ENDEREÇO E DEFINIR FK
ALTER TABLE `ecommerce`.`shipping` 
ADD COLUMN `id_address` INT NOT NULL AFTER `id_carrier`,
ADD INDEX `id_address_idx` (`id_address` ASC) VISIBLE;
;
ALTER TABLE `ecommerce`.`shipping` 
ADD CONSTRAINT `id_address`
  FOREIGN KEY (`id_address`)
  REFERENCES `ecommerce`.`customer_address` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

  
  -- TABELA ORDER
  ALTER TABLE `ecommerce`.`order` 
ADD INDEX `id_customer4_idx` (`id_customer` ASC) VISIBLE,
ADD INDEX `id_pay_idx` (`id_pay` ASC) VISIBLE,
ADD INDEX `id_items_idx` (`id_items` ASC) VISIBLE,
ADD INDEX `id_status_idx` (`id_status` ASC) VISIBLE;
;
ALTER TABLE `ecommerce`.`order` 
ADD CONSTRAINT `id_customer4`
  FOREIGN KEY (`id_customer`)
  REFERENCES `ecommerce`.`customer` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT `id_pay`
  FOREIGN KEY (`id_pay`)
  REFERENCES `ecommerce`.`payment_customer` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT `id_items`
  FOREIGN KEY (`id_items`)
  REFERENCES `ecommerce`.`order_items` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT `id_status`
  FOREIGN KEY (`id_status`)
  REFERENCES `ecommerce`.`order_status` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

-- TABELA ORDER_ITEMS
ALTER TABLE `ecommerce`.`order_items` 
ADD INDEX `id_product_idx` (`id_product` ASC) VISIBLE;
;
ALTER TABLE `ecommerce`.`order_items` 
ADD CONSTRAINT `id_product`
  FOREIGN KEY (`id_product`)
  REFERENCES `ecommerce`.`product` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
  
-- TABELA ORDER_HISTORY
ALTER TABLE `ecommerce`.`order_history` 
ADD INDEX `id_order2_idx` (`id_order` ASC) VISIBLE;
;
ALTER TABLE `ecommerce`.`order_history` 
ADD CONSTRAINT `id_order2`
  FOREIGN KEY (`id_order`)
  REFERENCES `ecommerce`.`order` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

