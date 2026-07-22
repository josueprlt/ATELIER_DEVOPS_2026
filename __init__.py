import os

from flask import Flask, render_template

app = Flask(__name__)

# Si une clé secrète Flask est fournie, on l'utilise depuis une variable d'environnement.
if secret_key := os.environ.get("FLASK_SECRET_KEY"):
    app.secret_key = secret_key

@app.route("/")
def hello_world():
    return "<h2>Bonjour tout le monde !</h2><p>Pour accéder à vos exerices cliquez <a href='./exercices/'>Ici</a></p>"

@app.route("/exercices/")
def exercices():
    return render_template("exercices.html")

if __name__ == "__main__":
    debug = os.environ.get("FLASK_DEBUG", "0") == "1"
    app.run(host="0.0.0.0", debug=debug)
