# Análise de Vendas em E-commerce com SQL Server

Projeto de análise de dados desenvolvido com SQL Server utilizando dados públicos
de e-commerce da Olist.

O objetivo é praticar SQL aplicado a um cenário de negócio, analisando vendas,
clientes, produtos, vendedores e entregas.

## Objetivo

Utilizar SQL para organizar e analisar os dados históricos de um e-commerce,
buscando responder perguntas comerciais e operacionais.

Entre as perguntas analisadas estão:

- Qual foi o faturamento total?
- Quantos pedidos foram realizados?
- Qual foi o ticket médio?
- Como as vendas evoluíram ao longo do tempo?
- Quais estados possuem maior volume de pedidos?
- Quais categorias de produtos tiveram maior faturamento?
- Quais vendedores apresentaram maior volume de vendas?
- Qual foi o tempo médio de entrega?
- Quantos pedidos foram entregues com atraso?
- Pedidos atrasados possuem avaliações menores?

## Tecnologias

- SQL Server
- SQL
- Visual Studio Code
- Git
- GitHub

## Dataset

Foi utilizado o dataset público **Brazilian E-Commerce Public Dataset by Olist**.

O conjunto de dados contém informações sobre:

- clientes;
- pedidos;
- produtos;
- vendedores;
- itens dos pedidos;
- pagamentos;
- avaliações.

Os arquivos CSV originais não são armazenados neste repositório.

## Estrutura do projeto

```text
analise-vendas-ecommerce-sql-server/
│
├── dados/
│   └── brutos/
│
├── documentacao/
│   ├── case_negocio.md
│   └── modelo_dados.md
│
├── scripts/
│   ├── 01_criacao_banco.sql
│   ├── 02_criacao_tabelas.sql
│   └── 03_importacao_dados.sql
│
├── consultas/
├── imagens/
├── utils/
├── .gitignore
└── README.md

Conceitos SQL utilizados

Durante o projeto serão utilizados conceitos fundamentais de SQL, como:

SELECT
WHERE
ORDER BY
GROUP BY
HAVING
COUNT
SUM
AVG
INNER JOIN
LEFT JOIN
CASE WHEN
CTE
Funções de data
Etapas do projeto
Definição do problema de negócio
Estruturação do banco de dados
Criação das tabelas
Importação dos dados
Validação dos dados
Análise de vendas
Análise de clientes
Análise de produtos
Análise de vendedores
Análise de entregas
Documentação dos principais insights
Status

Projeto em desenvolvimento.

Desenvolvido por Igor Henrique