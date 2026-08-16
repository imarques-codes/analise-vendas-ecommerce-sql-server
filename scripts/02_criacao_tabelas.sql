/*
Projeto: Análise de Vendas em E-commerce
Igor Henrique
Arquivo: 02_criacao_tabelas.sql
*/

USE ecommerce_olist;
GO


-- Clientes

CREATE TABLE dbo.customers (
    customer_id NVARCHAR(50) PRIMARY KEY,
    customer_unique_id NVARCHAR(50),
    customer_zip_code_prefix INT,
    customer_city NVARCHAR(100),
    customer_state CHAR(2)
);
GO


-- Vendedores

CREATE TABLE dbo.sellers (
    seller_id NVARCHAR(50) PRIMARY KEY,
    seller_zip_code_prefix INT,
    seller_city NVARCHAR(100),
    seller_state CHAR(2)
);
GO


-- Produtos

CREATE TABLE dbo.products (
    product_id NVARCHAR(50) PRIMARY KEY,
    product_category_name NVARCHAR(100),
    product_name_lenght INT,
    product_description_lenght INT,
    product_photos_qty INT,
    product_weight_g INT,
    product_length_cm INT,
    product_height_cm INT,
    product_width_cm INT
);
GO


-- Tradução das categorias

CREATE TABLE dbo.product_category_translation (
    product_category_name NVARCHAR(100) PRIMARY KEY,
    product_category_name_english NVARCHAR(100)
);
GO


-- Pedidos

CREATE TABLE dbo.orders (
    order_id NVARCHAR(50) PRIMARY KEY,
    customer_id NVARCHAR(50),
    order_status NVARCHAR(30),
    order_purchase_timestamp DATETIME2,
    order_approved_at DATETIME2,
    order_delivered_carrier_date DATETIME2,
    order_delivered_customer_date DATETIME2,
    order_estimated_delivery_date DATETIME2,

    FOREIGN KEY (customer_id)
        REFERENCES dbo.customers(customer_id)
);
GO


-- Itens dos pedidos

CREATE TABLE dbo.order_items (
    order_id NVARCHAR(50),
    order_item_id INT,
    product_id NVARCHAR(50),
    seller_id NVARCHAR(50),
    shipping_limit_date DATETIME2,
    price DECIMAL(10, 2),
    freight_value DECIMAL(10, 2),

    PRIMARY KEY (order_id, order_item_id),

    FOREIGN KEY (order_id)
        REFERENCES dbo.orders(order_id),

    FOREIGN KEY (product_id)
        REFERENCES dbo.products(product_id),

    FOREIGN KEY (seller_id)
        REFERENCES dbo.sellers(seller_id)
);
GO


-- Pagamentos

CREATE TABLE dbo.order_payments (
    order_id NVARCHAR(50),
    payment_sequential INT,
    payment_type NVARCHAR(30),
    payment_installments INT,
    payment_value DECIMAL(10, 2),

    PRIMARY KEY (order_id, payment_sequential),

    FOREIGN KEY (order_id)
        REFERENCES dbo.orders(order_id)
);
GO


-- Avaliações

CREATE TABLE dbo.order_reviews (
    review_id NVARCHAR(50),
    order_id NVARCHAR(50),
    review_score INT,
    review_comment_title NVARCHAR(500),
    review_comment_message NVARCHAR(4000),
    review_creation_date DATETIME2,
    review_answer_timestamp DATETIME2,

    PRIMARY KEY (review_id, order_id),

    FOREIGN KEY (order_id)
        REFERENCES dbo.orders(order_id)
);
GO


-- Validação das tabelas

SELECT
    name AS nome_tabela
FROM sys.tables
ORDER BY name;
GO