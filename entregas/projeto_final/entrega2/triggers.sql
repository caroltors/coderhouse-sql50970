-- desafio entregavel: triggers
-- info: nao é necessario utilizar begin e end, mas é uma boa pratica utilizar a estrutura, o DELIMITER é necessario por conta deste trecho
SET FOREIGN_KEY_CHECKS=0; -- desabilitar checagem de fk

-- LISTAR TRIGGERS
SHOW TRIGGERS;

-- TRIGGERS AFTER

-- [controle de estoque] - 1 - sem begin / end
-- trigger para atualizar automaticamente a quantidade de produtos disponíveis na tabela product quando um novo pedido for realizado
CREATE TRIGGER tr_update_product_quantity
AFTER INSERT ON order_items
FOR EACH ROW
    UPDATE product
    SET amount = amount - NEW.amount
    WHERE id = NEW.id_product;

-- [delete vinculos de cliente] - 2
DELIMITER $$
CREATE TRIGGER tr_customer_delete_cleanup
AFTER DELETE ON customer
FOR EACH ROW
BEGIN
    DELETE FROM login_customer WHERE id_customer = OLD.id;
    DELETE FROM customer_address WHERE id_customer = OLD.id;
    DELETE FROM payment_customer WHERE id_customer = OLD.id;
END; $$ 

-- tabela de log para triggers de customer, product e order
CREATE TABLE `log` (
  id int NOT NULL AUTO_INCREMENT PRIMARY KEY, -- id do log
  action_type varchar(50) NOT NULL, -- tipo de ação, delete, update ou insert
  table_name varchar(50) NOT NULL, -- nome da tabela
  action_datetime timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  user varchar(45) NOT NULL
);

-- criar tres triggers (update, delete, insert) para cada uma das tabelas 

-- [customer] - UPDATE - 3
DELIMITER $$
CREATE TRIGGER tr_customer_update_log
AFTER UPDATE ON customer
FOR EACH ROW
BEGIN 
    INSERT INTO log (id, action_type, table_name, action_datetime, user)
    VALUES (NEW.id, 'update', 'customer', NOW(6), USER());
END;
$$ 

-- [customer] - DELETE - 4
DELIMITER $$
CREATE TRIGGER tr_customer_delete_log
AFTER DELETE ON customer
FOR EACH ROW
BEGIN
    INSERT INTO log (id, action_type, table_name, action_datetime, user)
    VALUES (OLD.id, 'delete', 'customer', NOW(6), USER());
END;
$$ 
-- [customer] - INSERT - 5
DELIMITER $$
CREATE TRIGGER tr_customer_insert_log
AFTER INSERT ON customer
FOR EACH ROW
BEGIN
    INSERT INTO log (id, action_type, table_name, action_datetime, user)
    VALUES (NEW.id, 'insert', 'customer', NOW(6), USER());
END;
$$ 
-- [product] - UPDATE - 6
DELIMITER $$
CREATE TRIGGER tr_product_update_log
AFTER UPDATE ON product
FOR EACH ROW
BEGIN
    INSERT INTO log_table (id, action_type, table_name, action_datetime, user)
    VALUES (NEW.id, 'update', 'product', NOW(6), USER());
END;
$$ 
-- [product] - DELETE - 7
DELIMITER $$
CREATE TRIGGER tr_product_delete_log
AFTER DELETE ON product
FOR EACH ROW
BEGIN
    INSERT INTO log_table (id, action_type, table_name, action_datetime, user)
    VALUES (OLD.id, 'delete', 'product', NOW(6), USER());
END;
$$ 
-- [product] - INSERT - 8
DELIMITER $$
CREATE TRIGGER tr_product_insert_log
AFTER INSERT ON product
FOR EACH ROW
BEGIN
    INSERT INTO log_table (id, action_type, table_name, action_datetime, user)
    VALUES (NEW.id, 'insert', 'product', NOW(6), USER());
END;
$$ 
-- [order] - UPDATE - 9
DELIMITER $$
CREATE TRIGGER tr_order_update_log
AFTER UPDATE ON `order`
FOR EACH ROW
BEGIN
    INSERT INTO log_table (id, action_type, table_name, action_datetime, user)
    VALUES (NEW.id, 'update', 'order', NOW(6), USER());
END;
$$ 
-- [order] - DELETE - 10
DELIMITER $$
CREATE TRIGGER tr_order_delete_log
AFTER DELETE ON `order`
FOR EACH ROW
BEGIN
    INSERT INTO log_table (id, action_type, table_name, action_datetime, user)
    VALUES (OLD.id, 'delete', 'order', NOW(6), USER());
END;
$$ 
-- [order] - INSERT - 11
DELIMITER $$
CREATE TRIGGER tr_order_insert_log
AFTER INSERT ON `order`
FOR EACH ROW
BEGIN
    INSERT INTO log_table (id, action_type, table_name, action_datetime, user)
    VALUES (NEW.id, 'insert', 'order', NOW(6), USER());
END;
$$ 

-- [TRIGGER BEFORE]

-- BEFORE UPDATE order: atualiza o campo updated_at quando houver alguma alteração na order - 12
CREATE TRIGGER tr_order_updated_at
BEFORE UPDATE ON `order`
FOR EACH ROW
    SET NEW.updated_at = CURRENT_TIMESTAMP(6);

-- BEFORE UPDATE customer: atualiza o campo updated_at quando houver alguma alteração nos dados de customer - 13
CREATE TRIGGER tr_customer_updated_at
BEFORE UPDATE ON customer
FOR EACH ROW
    SET NEW.updated_at = CURRENT_TIMESTAMP(6);
    