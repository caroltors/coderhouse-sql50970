-- DESAFIO ENTREGAVEL 5: CRIAR 5 VIEWS

/*1 - Detalhes dos pedidos:
obter detalhes completos sobre um pedido, incluindo informações sobre o cliente, 
itens do pedido, status do pedido e detalhes de pagamento.*/

CREATE VIEW vw_orderdetails AS
SELECT
    o.id AS order_id,
    o.created_at AS order_date,
    CONCAT(c.name, ' ', c.last_name) AS customer_name, 
    c.mail AS customer_email,
    oi.id_product,
    p.name AS product_name,
    oi.amount,
    FORMAT(oi.amount * p.value, 2) AS total_value, --
    pc.pay_type,
	os.name AS order_status
FROM
    ecommerce.order o
JOIN customer c ON o.id_customer = c.id
JOIN order_status os ON o.id_status = os.id
JOIN order_items oi ON o.id = oi.id_order
JOIN product p ON oi.id_product = p.id
JOIN payment_customer pc ON o.id_pay = pc.id
ORDER BY order_date DESC;

SELECT * FROM vw_orderdetails;

/*2 - Clientes inativos 3m:
clientes que não realizaram compras nos últimos três meses,.*/

CREATE VIEW vw_inactivecustomers AS
SELECT
    c.id AS customer_id,
    CONCAT(c.name, ' ', c.last_name) AS customer_name,
    c.mail AS customer_email,
    c.phone AS customer_phone,
    c.created_at AS registration_date,
    MAX(o.created_at) AS last_purchase_date
FROM
    customer c
LEFT JOIN ecommerce.order o ON c.id = o.id_customer
GROUP BY
    c.id, customer_name, customer_email, customer_phone, registration_date
HAVING
    DATEDIFF(NOW(), MAX(o.created_at)) > 90 OR MAX(o.created_at) IS NULL
ORDER BY last_purchase_date;

/*3 - Informações de produtos:
fornece informações sobre os produtos, incluindo o nome do produto, categoria, valor, peso, total de pedidos e quantidade total vendida.*/
CREATE VIEW vw_productinfo AS
SELECT
    p.id AS product_id,
    p.name AS product_name,
    pc.name AS category,
    p.value AS product_value,
    p.weight AS product_weight,
    COUNT(oi.id) AS total_orders,
    SUM(oi.amount) AS total_sold
FROM
    product p
JOIN product_category pc ON p.id_category = pc.id
LEFT JOIN order_items oi ON p.id = oi.id_product
GROUP BY
    p.id, product_name, category, product_value, product_weight
ORDER BY
    total_sold DESC;
    
/*4 .Vendas Mensais
análise mensal de vendas, incluindo o número total de pedidos, itens vendidos e vendas totais por categoria e mes.*/
CREATE VIEW vw_monthlysales_category AS
SELECT
    DATE_FORMAT(o.created_at, '%Y-%m') AS month,
    pc.name AS category_name,
    COUNT(o.id) AS total_orders,
    SUM(oi.amount) AS total_items_sold,
    FORMAT(SUM(oi.amount * p.value), 2) AS total_sales
FROM
    `order` o
JOIN order_items oi ON o.id = oi.id_order
JOIN product p ON oi.id_product = p.id
JOIN product_category pc ON p.id_category = pc.id
GROUP BY
    month, category_name
ORDER BY
    month DESC;
    
/*5. Clientes Frequentes:
 identifica os 10 clientes mais frequentes com base no número total de pedidos.
 */
 
CREATE VIEW vw_topcustomers AS
SELECT
    c.id AS customer_id,
    CONCAT(c.name, ' ', c.last_name) AS customer_name,
    ca.city,
    MAX(o.created_at) AS last_purchase_date,
    COUNT(o.id) AS total_orders
FROM
    customer c
LEFT JOIN `order` o ON c.id = o.id_customer
LEFT JOIN customer_address ca ON ca.id_customer = c.id
GROUP BY
    customer_id, customer_name, ca.city
ORDER BY
    total_orders DESC
LIMIT 10;

/*6. Produtos Mais vendidos:
 identifica os 10 produtos mais vendidos com base na quantidade total vendida.
 */
CREATE VIEW vw_bestsellingproducts AS
SELECT
    p.id AS product_id,
    p.name AS product_name,
    pc.name AS category_name,
    SUM(oi.amount) AS total_sold
FROM
    product p
JOIN product_category pc ON p.id_category = pc.id
JOIN order_items oi ON p.id = oi.id_product
GROUP BY
    product_id, product_name, category_name
ORDER BY
    total_sold DESC
LIMIT 10;

