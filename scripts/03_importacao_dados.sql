/*
Projeto: Análise de Vendas em E-commerce
Igor Henrique
Arquivo: 03_importacao_dados.sql
*/

USE ecommerce_olist;
GO


-- Clientes

BULK INSERT dbo.customers
FROM 'C:\caminho\para\dados\brutos\olist_customers_dataset.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDQUOTE = '"',
    ROWTERMINATOR = '0x0a',
    CODEPAGE = '65001',
    TABLOCK
);
GO


-- Vendedores

BULK INSERT dbo.sellers
FROM 'C:\caminho\para\dados\brutos\olist_sellers_dataset.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDQUOTE = '"',
    ROWTERMINATOR = '0x0a',
    CODEPAGE = '65001',
    TABLOCK
);
GO


-- Produtos

BULK INSERT dbo.products
FROM 'C:\caminho\para\dados\brutos\olist_products_dataset.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDQUOTE = '"',
    ROWTERMINATOR = '0x0a',
    CODEPAGE = '65001',
    TABLOCK
);
GO


-- Tradução das categorias

BULK INSERT dbo.product_category_translation
FROM 'C:\caminho\para\dados\brutos\product_category_name_translation.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDQUOTE = '"',
    ROWTERMINATOR = '0x0a',
    CODEPAGE = '65001',
    TABLOCK
);
GO


-- Pedidos

BULK INSERT dbo.orders
FROM 'C:\caminho\para\dados\brutos\olist_orders_dataset.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDQUOTE = '"',
    ROWTERMINATOR = '0x0a',
    CODEPAGE = '65001',
    TABLOCK
);
GO


-- Itens dos pedidos

BULK INSERT dbo.order_items
FROM 'C:\caminho\para\dados\brutos\olist_order_items_dataset.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDQUOTE = '"',
    ROWTERMINATOR = '0x0a',
    CODEPAGE = '65001',
    TABLOCK
);
GO


-- Pagamentos

BULK INSERT dbo.order_payments
FROM 'C:\caminho\para\dados\brutos\olist_order_payments_dataset.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDQUOTE = '"',
    ROWTERMINATOR = '0x0a',
    CODEPAGE = '65001',
    TABLOCK
);
GO

--Avaliação

BULK INSERT dbo.order_reviews
FROM 'C:\Users\DataCore\Desktop\projetos_Git\analise-vendas-ecommerce-sql-server\dados\tratados\olist_order_reviews_tratado.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDQUOTE = '"',
    ROWTERMINATOR = '0X0a',
    CODEPAGE = '65001',
    TABLOCK
);
GO


-- Validação da importação

SELECT 'customers' AS tabela, COUNT(*) AS total_registros
FROM dbo.customers

UNION ALL

SELECT 'sellers', COUNT(*)
FROM dbo.sellers

UNION ALL

SELECT 'products', COUNT(*)
FROM dbo.products

UNION ALL

SELECT 'product_category_translation', COUNT(*)
FROM dbo.product_category_translation

UNION ALL

SELECT 'orders', COUNT(*)
FROM dbo.orders

UNION ALL

SELECT 'order_items', COUNT(*)
FROM dbo.order_items

UNION ALL

SELECT 'order_payments', COUNT(*)
FROM dbo.order_payments;
GO

--testes

