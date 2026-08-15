/*
Projeto: Análise de Vendas em E-commerce
Igor Henrique
Arquivo: 02_criacao_tabelas.sql
*/


USE master;
GO

DROP DATABASE IF EXISTS ecommerce_olist;
GO

CREATE DATABASE ecommerce_olist;
GO

USE ecommerce_olist;
GO

SELECT
    DB_NAME() AS banco_atual;
GO