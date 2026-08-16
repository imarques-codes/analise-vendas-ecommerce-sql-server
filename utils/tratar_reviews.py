import csv
from pathlib import Path


# Caminhos dos arquivos
pasta_projeto = Path(__file__).resolve().parent.parent

arquivo_entrada = (
    pasta_projeto
    / "dados"
    / "brutos"
    / "olist_order_reviews_dataset.csv"
)

arquivo_saida = (
    pasta_projeto
    / "dados"
    / "tratados"
    / "olist_order_reviews_tratado.csv"
)


# Controle dos registros
total_registros = 0
total_duplicados = 0
chaves_encontradas = set()


with open(
    arquivo_entrada,
    "r",
    encoding="utf-8",
    newline=""
) as entrada:

    with open(
        arquivo_saida,
        "w",
        encoding="utf-8",
        newline=""
    ) as saida:

        leitor = csv.reader(entrada)
        escritor = csv.writer(saida, lineterminator="\n")

        cabecalho = next(leitor)
        escritor.writerow(cabecalho)

        for linha in leitor:

            # Remove quebras de linha dos campos
            linha_limpa = [
                campo.replace("\r", " ").replace("\n", " ")
                for campo in linha
            ]

            # Chave utilizada na tabela order_reviews
            chave = (
                linha_limpa[0],  # review_id
                linha_limpa[1]   # order_id
            )

            # Ignora registros duplicados
            if chave in chaves_encontradas:
                total_duplicados += 1
                continue

            chaves_encontradas.add(chave)

            escritor.writerow(linha_limpa)
            total_registros += 1


print("Arquivo tratado com sucesso.")
print(f"Registros gravados: {total_registros}")
print(f"Duplicados removidos: {total_duplicados}")