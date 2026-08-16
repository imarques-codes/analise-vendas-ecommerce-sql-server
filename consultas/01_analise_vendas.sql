/*
Projeto: Análise de Vendas em E-commerce
Igor Henrique
Arquivo: 01_analise_vendas.sql
*/

USE ecommerce_olist;
GO

--Total de pedidos entregues

SELECT
    COUNT(*) AS total_pedidos_entregues
FROM dbo.orders
WHERE order_status = 'delivered';
GO

-- Faturamento total dos pedidos entregues

SELECT
    SUM(pagamento.payment_value) AS faturamento_total
FROM dbo.order_payments AS pagamento

INNER JOIN dbo.orders AS pedido
    ON pagamento.order_id = pedido.order_id

WHERE pedido.order_status = 'delivered'
  AND pagamento.payment_value > 0;
GO

-- Ticket médio dos pedidos entregues

SELECT
    ROUND(
        SUM(pagamento.payment_value)
        / COUNT(DISTINCT pedido.order_id),
        2
    ) AS ticket_medio
FROM dbo.order_payments AS pagamento

INNER JOIN dbo.orders AS pedido
    ON pagamento.order_id = pedido.order_id

WHERE pedido.order_status = 'delivered';
GO

-- Faturamento por ano e mês

SELECT
    YEAR(pedido.order_purchase_timestamp) AS ano,
    MONTH(pedido.order_purchase_timestamp) AS mes,
    COUNT(DISTINCT pedido.order_id) AS total_pedidos,
    ROUND(SUM(pagamento.payment_value), 2) AS faturamento
FROM dbo.order_payments AS pagamento

INNER JOIN dbo.orders AS pedido
    ON pagamento.order_id = pedido.order_id

WHERE pedido.order_status = 'delivered'
  AND pagamento.payment_value > 0

GROUP BY
    YEAR(pedido.order_purchase_timestamp),
    MONTH(pedido.order_purchase_timestamp)

ORDER BY
    ano,
    mes;
GO

-- Formas de pagamento

SELECT
    pagamento.payment_type AS forma_pagamento,
    COUNT(DISTINCT pedido.order_id) AS total_pedidos,
    ROUND(SUM(pagamento.payment_value), 2) AS valor_total
FROM dbo.order_payments AS pagamento

INNER JOIN dbo.orders AS pedido
    ON pagamento.order_id = pedido.order_id

WHERE pedido.order_status = 'delivered'
  AND pagamento.payment_value > 0

GROUP BY
    pagamento.payment_type

ORDER BY
    valor_total DESC;
GO