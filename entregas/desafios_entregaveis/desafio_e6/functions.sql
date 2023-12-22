-- DESAFIO ENTREGAVEL 6: FUNCOES

-- OBTER ULTIMO LOGIN DE UM CLIENTE PASSANDO O ID DO CLIENTE
DELIMITER $$
CREATE FUNCTION getLastLogin(customerId INT) RETURNS TIMESTAMP DETERMINISTIC
BEGIN
    DECLARE lastLogin TIMESTAMP;
    
    SELECT lc.last_login INTO lastLogin
    FROM login_customer lc
    WHERE lc.id_customer = customerId
    ORDER BY lc.last_login DESC
    LIMIT 1;
    
    RETURN lastLogin;
END
$$

SELECT getLastLogin(1) AS LastLogin; 

-- OBTER STATUS DO PEDIDO PASSANDO O NUMERO DE PEDIDO
DELIMITER $$
CREATE FUNCTION getOrderStatus(orderId INT) RETURNS VARCHAR(255) DETERMINISTIC
BEGIN
    DECLARE statusDesc VARCHAR(255);
    
    SELECT os.desc INTO statusDesc
    FROM `order` o
    JOIN order_status os ON o.id_status = os.id
    WHERE o.id = orderId;
    
    RETURN statusDesc;
END
$$

SELECT getOrderStatus(1) AS OrderStatus; 

-- OBTER VALOR TOTAL DO PEDIDO PASSANDO O NUMERO DE PEDIDO
DELIMITER $$
CREATE FUNCTION calculateOrderTotal(orderId INT) RETURNS FLOAT DETERMINISTIC
BEGIN
    DECLARE totalValue FLOAT;

    SELECT SUM(oi.amount * p.value)
    INTO totalValue
    FROM order_items oi
    JOIN product p ON oi.id_product = p.id
    WHERE oi.id_order = orderId;

    RETURN totalValue;
END
$$

SELECT calculateOrderTotal(1) AS OrderTotal; 