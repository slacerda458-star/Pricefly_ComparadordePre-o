from flask import Flask, jsonify, request
from flask_cors import CORS

app = Flask(__name__)
CORS(app)

produtos = [
    {"nome": "arroz", "preco":20},
    {"nome": "feijao", "preco":10},
    {"nome": "Macarrão", "preco":80}
]

@app.route("/")
def home():
    return "API Pricefly rodando!"

@app.route("/produtos", methods=["GET"])
def listar_produtos():
    return jsonify(produtos)

@app.route("/produtos", methods=["POST"])
def adicionar_produtos():
    data = request.json
    produtos.append(data)
    return jsonify({"msg": "Produto adicionado com sucesso"}),
if __name__ == "__main__":
    app.run(debug=True)