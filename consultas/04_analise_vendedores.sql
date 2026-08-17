/*
Projeto: Análise de Vendas em E-commerce
Igor Henrique
Arquivo: 04_analise_vendedores.sql
*/

USE ecommerce_olist;
GO

--Vendedores com maior faturamento

SELECT TOP 10
    vendedor.seller_id AS id_vendedor,
    vendedor.seller_city AS cidade,
    vendedor.seller_state AS estado,
    COUNT(DISTINCT item.order_id) AS total_pedidos,
    ROUND(SUM(item.price), 2) AS faturamento
FROM dbo.order_items AS item

INNER JOIN dbo.orders AS pedido
    ON item.order_id = pedido.order_id

INNER JOIN dbo.sellers AS vendedor
    ON item.seller_id = vendedor.seller_id

WHERE pedido.order_status = 'delivered'

GROUP BY
    vendedor.seller_id,
    vendedor.seller_city,
    vendedor.seller_state

ORDER BY
    faturamento DESC;
GO


-- Vendedores com maior quantidade de pedidos

SELECT TOP 10
    vendedor.seller_id AS id_vendedor,
    vendedor.seller_city AS cidade,
    vendedor.seller_state AS estado,
    COUNT(DISTINCT item.order_id) AS total_pedidos,
    ROUND(SUM(item.price), 2) AS faturamento
FROM dbo.order_items AS item

INNER JOIN dbo.orders AS pedido
    ON item.order_id = pedido.order_id

INNER JOIN dbo.sellers AS vendedor
    ON item.seller_id = vendedor.seller_id

WHERE pedido.order_status = 'delivered'

GROUP BY
    vendedor.seller_id,
    vendedor.seller_city,
    vendedor.seller_state

ORDER BY
    total_pedidos DESC;
GO

-- Desempenho dos vendedores por estado

SELECT
    vendedor.seller_state AS estado,
    COUNT(DISTINCT vendedor.seller_id) AS total_vendedores,
    COUNT(*) AS total_itens_vendidos,
    ROUND(SUM(item.price), 2) AS faturamento
FROM dbo.order_items AS item

INNER JOIN dbo.orders AS pedido
    ON item.order_id = pedido.order_id

INNER JOIN dbo.sellers AS vendedor
    ON item.seller_id = vendedor.seller_id

WHERE pedido.order_status = 'delivered'

GROUP BY
    vendedor.seller_state

ORDER BY
    faturamento DESC;
GO