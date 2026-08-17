/*
Projeto: Análise de Vendas em E-commerce
Igor Henrique
Arquivo: 03_analise_produtos.sql
*/

USE ecommerce_olist;
GO

-- Categorias com maior quantidade de itens vendidos

SELECT TOP 10
    produto.product_category_name AS categoria,
    COUNT(*) AS total_itens_vendidos
FROM dbo.order_items AS item

INNER JOIN dbo.orders AS pedido
    ON item.order_id = pedido.order_id

INNER JOIN dbo.products AS produto
    ON item.product_id = produto.product_id

WHERE pedido.order_status = 'delivered'
  AND produto.product_category_name IS NOT NULL

GROUP BY
    produto.product_category_name

ORDER BY
    total_itens_vendidos DESC;
GO

-- Categorias com maior faturamento

SELECT TOP 10
    produto.product_category_name AS categoria,
    COUNT(*) AS total_itens_vendidos,
    ROUND(SUM(item.price), 2) AS faturamento
FROM dbo.order_items AS item

INNER JOIN dbo.orders AS pedido
    ON item.order_id = pedido.order_id

INNER JOIN dbo.products AS produto
    ON item.product_id = produto.product_id

WHERE pedido.order_status = 'delivered'
  AND produto.product_category_name IS NOT NULL

GROUP BY
    produto.product_category_name

ORDER BY
    faturamento DESC;
GO

-- Produtos com maior faturamento

SELECT TOP 10
    item.product_id AS id_produto,
    produto.product_category_name AS categoria,
    COUNT(*) AS total_itens_vendidos,
    ROUND(SUM(item.price), 2) AS faturamento
FROM dbo.order_items AS item

INNER JOIN dbo.orders AS pedido
    ON item.order_id = pedido.order_id

INNER JOIN dbo.products AS produto
    ON item.product_id = produto.product_id

WHERE pedido.order_status = 'delivered'

GROUP BY
    item.product_id,
    produto.product_category_name

ORDER BY
    faturamento DESC;
GO