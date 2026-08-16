# Modelo de Dados

O projeto utiliza dados públicos de e-commerce da Olist.

As tabelas principais representam clientes, pedidos, produtos, vendedores,
pagamentos e avaliações.

## Tabelas utilizadas

### customers

Contém informações dos clientes.

Campos principais:

- customer_id
- customer_unique_id
- customer_city
- customer_state

### orders

Contém os pedidos realizados.

Campos principais:

- order_id
- customer_id
- order_status
- order_purchase_timestamp
- order_delivered_customer_date
- order_estimated_delivery_date

Relacionamento:

Um cliente pode possuir um ou mais pedidos.

```text
customers
    |
    | customer_id
    |
orders