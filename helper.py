import pandas
import os

project_dir = os.path.dirname(os.path.abspath(__file__))
csv_path = os.path.join(project_dir, 'files', 'Relatorio_cadop.csv')

def organize_data():
    content = pandas.read_csv(csv_path, delimiter=',', encoding='utf-8', on_bad_lines='skip')
    organized_content = []
    for data in content.to_dict(orient="records"):
        chaves = list(data.keys())[0].split(';')
        valores = list(data.values())[0].split(';')
        dados_organizados = {}
        for chave, valor in zip(chaves, valores):
            dados_organizados[chave] = valor.strip('"')
        organized_content.append(dados_organizados)

    return organized_content