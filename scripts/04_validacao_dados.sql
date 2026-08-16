/*
Projeto: Análise de Vendas em E-commerce
Igor Henrique
Arquivo: 04_validacao_dados.sql
*/

USE ecommerce_olist;
GO


-- Quantidade de registros por tabela

SELECT 'customers' AS tabela, COUNT(*) AS total_registros
FROM dbo.customers

UNION ALL

SELECT 'product_category_translation', COUNT(*)
FROM dbo.product_category_translation

UNION ALL

SELECT 'sellers', COUNT(*)
FROM dbo.sellers

UNION ALL

SELECT 'products', COUNT(*)
FROM dbo.products

UNION ALL

SELECT 'orders', COUNT(*)
FROM dbo.orders

UNION ALL

SELECT 'order_items', COUNT(*)
FROM dbo.order_items

UNION ALL

SELECT 'order_payments', COUNT(*)
FROM dbo.order_payments

UNION ALL

SELECT 'order_reviews', COUNT(*)
FROM dbo.order_reviews;
GO


-- Pedidos sem cliente

SELECT COUNT(*) AS pedidos_sem_cliente
FROM dbo.orders
WHERE customer_id IS NULL;
GO


-- Pedidos sem data de compra

SELECT COUNT(*) AS pedidos_sem_data_compra
FROM dbo.orders
WHERE order_purchase_timestamp IS NULL;
GO


-- Itens com preço inválido

SELECT COUNT(*) AS itens_preco_invalido
FROM dbo.order_items
WHERE price <= 0
   OR price IS NULL;
GO


-- Pagamentos com valor inválido

SELECT COUNT(*) AS pagamentos_valor_invalido
FROM dbo.order_payments
WHERE payment_value <= 0
   OR payment_value IS NULL;
GO


-- Avaliações fora da escala de 1 a 5

SELECT COUNT(*) AS avaliacoes_invalidas
FROM dbo.order_reviews
WHERE review_score < 1
   OR review_score > 5
   OR review_score IS NULL;
GO


-- Quantidade de pedidos por status

SELECT
    order_status AS status_pedido,
    COUNT(*) AS total_pedidos
FROM dbo.orders
GROUP BY order_status
ORDER BY total_pedidos DESC;
GO

-- Verificação dos pagamentos inválidos

-- Verificação dos pagamentos inválidos

SELECT
    order_id,
    payment_sequential,
    payment_type,
    payment_installments,
    payment_value
FROM dbo.order_payments
WHERE payment_value <= 0
   OR payment_value IS NULL;
GO


-- Verificação dos pagamentos inválidos

SELECT
    order_id,
    payment_type,
    payment_installments,
    payment_value
FROM dbo.order_payments
WHERE payment_value <= 0
   OR payment_value IS NULL;
GO