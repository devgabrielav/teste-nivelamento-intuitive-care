from fastapi import FastAPI
import pandas
from fastapi.middleware.cors import CORSMiddleware
from helper import organize_data

app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

@app.get('/operadoras')
def get_all():
    try:
        content = organize_data()
        return {"data": content}
    except pandas.errors.ParserError as e:
        return {"error": f"Erro ao processar o arquivo CSV: {str(e)}"}

@app.get('/operadoras/{text_search}')
def get_by_text(text_search: str):
    try:
        content = organize_data()
        filtered_content = [
            item for item in content
            if any(text_search.lower() in str(valor).lower()
            for valor in item.values())
        ]
        return { "data": filtered_content }
    except pandas.errors.ParserError as e:
        return {"error": f"Erro ao processar o arquivo CSV: {str(e)}"}