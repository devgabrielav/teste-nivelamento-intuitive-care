
# TESTES DE NIVELAMENTO 
Scripts Python e backend para soluções do teste de nivelamento.
A coleção Postman, se encontra na raiz do projeto.


## Iniciando o servidor e realizando testes

Após fazer o clone do repositório.

No terminal digite:

```bash
  python3 -m venv venv 
```

```bash
  pip install -r requirements.txt
```

Para rodar os scripts para os testes 1 e 2, respectivamente:

```bash
  python webScraping.py  
```

```bash
  python dataTransform.py 
```


Para rodar o servidor:

```bash
  uvicorn main:app --reload
```
## Autor

- [devgabrielav](https://github.com/devgabrielav)

