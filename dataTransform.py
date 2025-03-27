import os
import zipfile
from tabula import read_pdf
from PyPDF2 import PdfReader
import pandas

project_dir = os.path.dirname(os.path.abspath(__file__))
out_dir = os.path.join(project_dir, 'files')
zip_file_path = os.path.join(out_dir, 'anexos.zip')
new_zip_file_path = os.path.join(out_dir, 'Teste_Gabriela.zip')

with zipfile.ZipFile(zip_file_path, 'r') as zip_file:
    for file_name in zip_file.namelist():
        if file_name.lower().endswith('.pdf') and 'anexo_i_' in file_name.lower():
            pdf_name = file_name
            zip_file.extract(file_name)

            with open(pdf_name, 'rb') as f:
                pdf_reader = PdfReader(f)

                table_list = read_pdf(pdf_name, pages='all',  multiple_tables=True)

                final_list = pandas.concat(table_list, ignore_index=True)

                final_list.rename(columns={
                    "OD": "Seg. Odontológica",
                    "AMB": "Seg. Ambulatorial"
                }, inplace=True)

                new_file_name = os.path.splitext(file_name)[0] + '.csv'

                final_list.to_csv(new_file_name, index=False, encoding='utf-8-sig')
            
            with zipfile.ZipFile(new_zip_file_path, 'w', zipfile.ZIP_DEFLATED) as new_zip_file:
                    new_zip_file.write(new_file_name, os.path.basename(new_file_name))

            os.remove(file_name)
            os.remove(new_file_name)
