-- SP1: indicar o campo de ordenamento através de um parâmetro e um segundo parâmetro para definir se a ordem é crescente ou decrescente.
DELIMITER $$
CREATE PROCEDURE `sp_get_product_order` (IN col CHAR(20), IN ord INT)
BEGIN
        -- Verificar se o parâmetro 'col' é nulo ou vazio
        IF col IS NULL OR col = '' THEN
            SELECT 'erro: coluna não existe ou não foi especificada' AS mensagem_erro;
        ELSE
            -- Verificar se o parâmetro 'ord' é nulo ou vazio
            IF ord IS NULL OR ord = '' THEN
                SELECT 'erro: ordenação não definida' AS mensagem_erro;
            ELSE
                -- Definir a cláusula ORDER BY com base no parâmetro 'col'
                SET @product_order_sql = CONCAT('ORDER BY ', col);

                -- Verificar o valor do parâmetro 'ord'
                IF ord = 1 THEN
                    SET @product_order_sql = CONCAT(@product_order_sql, ' DESC'); -- Se 'ord' for 1, ordenar por DESC
                ELSEIF ord = 2 THEN
                    SET @product_order_sql = CONCAT(@product_order_sql, ' ASC'); -- Se 'ord' for 2, ordenar por ASC
                ELSE
                    SELECT 'erro: valor inválido para o parâmetro ord' AS mensagem_erro;
                END IF;

                -- Montar a consulta final
                SET @clausula = CONCAT('SELECT * FROM product ', @product_order_sql);

                -- Preparar e executar a consulta
                PREPARE runSQL FROM @clausula;
                EXECUTE runSQL;
                DEALLOCATE PREPARE runSQL;
            END IF;
    END IF;
END $$
DELIMITER ;

-- se rodar sem nenhum parametro ou sem um dos dois retorna erro do sql 
CALL sp_get_product_order ();

-- se rodar sem o primeiro parametro retorna que a coluna nao existe ou nao foi especificada
CALL sp_get_product_order (NULL, 1);

-- se rodar sem o segundo parametro retorna que a ordenacao nao foi definida
CALL sp_get_product_order ("id", NULL);

-- se rodar sem o segundo parametro retorna que a ordenacao nao foi definida
CALL sp_get_product_order ("id", NULL);

-- SP2: registrar novo pedido e exibir o pedido inserido
DELIMITER $$

CREATE PROCEDURE `sp_place_order` (
    IN p_id_product INT,
    IN p_quantity INT,
    IN p_id_customer INT
)
BEGIN
		DECLARE v_order_id INT;
        DECLARE v_total_price DECIMAL(10, 2);
    -- Verificar se algum dos parâmetros é nulo ou inexistente
    IF p_id_product IS NULL OR p_quantity IS NULL OR p_id_customer IS NULL THEN
        SELECT 'erro: parâmetros não foram fornecidos ou são nulos' AS error_message;
    ELSE
        -- Iniciar um registro
        START TRANSACTION;

        -- Inserir um novo pedido
        INSERT INTO `order` (`id_customer`, `id_pay`, `id_status`, `created_at`)
        VALUES (p_id_customer, 1, 1, NOW());

        -- Obter o ID do pedido inserido
        SET v_order_id = LAST_INSERT_ID();

        -- Inserir itens do pedido
        INSERT INTO `order_items` (`id_order`, `id_product`, `amount`)
        VALUES (v_order_id, p_id_product, p_quantity);

        -- Calcular o preço total do item do pedido
        SELECT `value` * p_quantity INTO v_total_price
        FROM `product`
        WHERE `id` = p_id_product;

        -- Atualizar o estoque do produto
        UPDATE `product`
        SET `amount` = `amount` - p_quantity
        WHERE `id` = p_id_product;

        -- Commit da transação
        COMMIT;

        -- Selecionar informações do pedido adicionado
        SET @sql = '
            SELECT 
                o.id AS order_id,
                o.id_customer AS customer_id,
                CONCAT(c.name, '' '', c.last_name) AS customer_name,
                oi.id AS item_id,
                p.name AS product_name,
                oi.amount AS quantity,
                ? AS total_price,
                o.created_at AS order_created_at
            FROM
                `order` o
            JOIN `customer` c ON o.id_customer = c.id
            JOIN `order_items` oi ON o.id = oi.id_order
            JOIN `product` p ON oi.id_product = p.id
            WHERE
                o.id = ?';

        -- Preparar e executar o comando SQL
        PREPARE stmt FROM @sql;
        SET @total_price = v_total_price;
        SET @order_id = v_order_id;
        EXECUTE stmt USING @total_price, @order_id;
        DEALLOCATE PREPARE stmt;
    END IF;
END $$

CALL sp_place_order(48, 6, 78);