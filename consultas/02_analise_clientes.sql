/*
Projeto: Análise de Vendas em E-commerce
Igor Henrique
Arquivo: 02_analise_clientes.sql
*/

USE ecommerce_olist;
GO

-- Clientes únicos por estado

SELECT
    customer_state AS estado,
    COUNT(DISTINCT customer_unique_id) AS total_clientes
FROM dbo.customers
GROUP BY customer_state
ORDER BY total_clientes DESC;
GO

-- Pedidos entregues por estado

SELECT
    cliente.customer_state AS estado,
    COUNT(DISTINCT pedido.order_id) AS total_pedidos
FROM dbo.orders AS pedido

INNER JOIN dbo.customers AS cliente
    ON pedido.customer_id = cliente.customer_id

WHERE pedido.order_status = 'delivered'

GROUP BY
    cliente.customer_state

ORDER BY
    total_pedidos DESC;
GO

-- Faturamento por estado

SELECT
    cliente.customer_state AS estado,
    COUNT(DISTINCT pedido.order_id) AS total_pedidos,
    ROUND(SUM(pagamento.payment_value), 2) AS faturamento
FROM dbo.orders AS pedido

INNER JOIN dbo.customers AS cliente
    ON pedido.customer_id = cliente.customer_id

INNER JOIN dbo.order_payments AS pagamento
    ON pedido.order_id = pagamento.order_id

WHERE pedido.order_status = 'delivered'
  AND pagamento.payment_value > 0

GROUP BY
    cliente.customer_state

ORDER BY
    faturamento DESC;
GO

-- Clientes recorrentes

SELECT
    COUNT(*) AS clientes_recorrentes
FROM (
    SELECT
        cliente.customer_unique_id
    FROM dbo.customers AS cliente

    INNER JOIN dbo.orders AS pedido
        ON cliente.customer_id = pedido.customer_id

    WHERE pedido.order_status = 'delivered'

    GROUP BY
        cliente.customer_unique_id

    HAVING COUNT(DISTINCT pedido.order_id) > 1
) AS clientes_com_recompra;
GO

-- Taxa de recompra

SELECT
    COUNT(DISTINCT cliente.customer_unique_id) AS total_clientes
FROM dbo.customers AS cliente

INNER JOIN dbo.orders AS pedido
    ON cliente.customer_id = pedido.customer_id

WHERE pedido.order_status = 'delivered';
GO

-- Taxa de recompra

WITH pedidos_por_cliente AS (
    SELECT
        cliente.customer_unique_id,
        COUNT(DISTINCT pedido.order_id) AS total_pedidos
    FROM dbo.customers AS cliente

    INNER JOIN dbo.orders AS pedido
        ON cliente.customer_id = pedido.customer_id

    WHERE pedido.order_status = 'delivered'

    GROUP BY
        cliente.customer_unique_id
)

SELECT
    COUNT(*) AS total_clientes,

    SUM(
        CASE
            WHEN total_pedidos > 1 THEN 1
            ELSE 0
        END
    ) AS clientes_recorrentes,

    ROUND(
        SUM(
            CASE
                WHEN total_pedidos > 1 THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS taxa_recompra_percentual

FROM pedidos_por_cliente;
GO