import os
import requests
import zipfile
from selenium import webdriver
from webdriver_manager.chrome import ChromeDriverManager
from selenium.webdriver.chrome.service import Service

project_dir = os.path.dirname(os.path.abspath(__file__))
out_dir = os.path.join(project_dir, 'files')

url = 'https://www.gov.br/ans/pt-br/acesso-a-informacao/participacao-da-sociedade/atualizacao-do-rol-de-procedimentos'

service = Service(ChromeDriverManager().install())

browser = webdriver.Chrome(service=service)

def get_files():
    browser.get(url)

    anexos = [ browser.find_element('xpath',
                                '//*[@id="cfec435d-6921-461f-b85a-b425bc3cb4a5"]/div/ol/li[1]/a[1]').get_attribute('href'),
            browser.find_element('xpath',
                                '//*[@id="cfec435d-6921-461f-b85a-b425bc3cb4a5"]/div/ol/li[2]/a').get_attribute('href')
            ]

    with zipfile.ZipFile(os.path.join(out_dir, 'anexos.zip'), 'w') as zip_file:
        for anexo in anexos:
            response = requests.get(anexo)
            if response.status_code == 200:
                file_name = os.path.basename(anexo)
                zip_file.writestr(file_name, response.content)


