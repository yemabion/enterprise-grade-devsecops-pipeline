
import os

from flask import Flask, jsonify

app = Flask(__name__)


@app.get("/")
def home():
    return "Hello from CI/CD Pipeline!", 200


@app.get("/health")
def health():
    return jsonify({
        "status": "healthy"
    }), 200


if __name__ == "__main__":
    port = int(os.environ.get("PORT", 3000))

    app.run(
        host="0.0.0.0",
        port=port,
        debug=False
    )
