/*
Projeto: Análise de Vendas em E-commerce
Igor Henrique
Arquivo: 05_analise_entregas.sql
*/

USE ecommerce_olist;
GO

-- Tempo médio de entrega

SELECT
    ROUND(
        AVG(
            CAST(
                DATEDIFF(
                    DAY,
                    order_purchase_timestamp,
                    order_delivered_customer_date
                ) AS DECIMAL(10, 2)
            )
        ),
        2
    ) AS tempo_medio_entrega_dias
FROM dbo.orders
WHERE order_status = 'delivered'
  AND order_purchase_timestamp IS NOT NULL
  AND order_delivered_customer_date IS NOT NULL;
GO

-- Pedidos entregues com atraso

SELECT
    COUNT(*) AS total_pedidos,
    
    SUM(
        CASE
            WHEN order_delivered_customer_date > order_estimated_delivery_date
                THEN 1
            ELSE 0
        END
    ) AS pedidos_atrasados,

    ROUND(
        SUM(
            CASE
                WHEN order_delivered_customer_date > order_estimated_delivery_date
                    THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS taxa_atraso_percentual

FROM dbo.orders

WHERE order_status = 'delivered'
  AND order_delivered_customer_date IS NOT NULL
  AND order_estimated_delivery_date IS NOT NULL;
GO

-- Taxa de atraso por estado

SELECT
    cliente.customer_state AS estado,
    COUNT(*) AS total_entregas,

    SUM(
        CASE
            WHEN pedido.order_delivered_customer_date >
                 pedido.order_estimated_delivery_date
                THEN 1
            ELSE 0
        END
    ) AS pedidos_atrasados,

    ROUND(
        SUM(
            CASE
                WHEN pedido.order_delivered_customer_date >
                     pedido.order_estimated_delivery_date
                    THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS taxa_atraso_percentual

FROM dbo.orders AS pedido

INNER JOIN dbo.customers AS cliente
    ON pedido.customer_id = cliente.customer_id

WHERE pedido.order_status = 'delivered'
  AND pedido.order_delivered_customer_date IS NOT NULL
  AND pedido.order_estimated_delivery_date IS NOT NULL

GROUP BY
    cliente.customer_state

HAVING COUNT(*) >= 100

ORDER BY
    taxa_atraso_percentual DESC;
GO

-- Avaliação dos clientes por situação da entrega

;WITH avaliacao_por_pedido AS (
    SELECT
        order_id,
        AVG(
            CAST(review_score AS DECIMAL(10, 2))
        ) AS nota_avaliacao
    FROM dbo.order_reviews
    GROUP BY order_id
)

SELECT
    CASE
        WHEN pedido.order_delivered_customer_date >
             pedido.order_estimated_delivery_date
            THEN 'Entrega atrasada'
        ELSE 'Entrega no prazo'
    END AS situacao_entrega,

    COUNT(DISTINCT pedido.order_id) AS total_pedidos,

    ROUND(
        AVG(avaliacao.nota_avaliacao),
        2
    ) AS nota_media

FROM dbo.orders AS pedido

INNER JOIN avaliacao_por_pedido AS avaliacao
    ON pedido.order_id = avaliacao.order_id

WHERE pedido.order_status = 'delivered'
  AND pedido.order_delivered_customer_date IS NOT NULL
  AND pedido.order_estimated_delivery_date IS NOT NULL

GROUP BY
    CASE
        WHEN pedido.order_delivered_customer_date >
             pedido.order_estimated_delivery_date
            THEN 'Entrega atrasada'
        ELSE 'Entrega no prazo'
    END

ORDER BY
    nota_media;
GO