# !/bin/bash

# Install Docker & Docker Compose

sudo apt update && sudo apt upgrade -y

# Install Docker
sudo apt install -y docker.io

# Enable Docker without sudo (optional)
sudo usermod -aG docker $USER
newgrp docker

# Enable Docker at boot
sudo systemctl enable docker

# Create Project Folder

mkdir -p ~/pokemon-stack/app
cd ~/pokemon-stack

# Add Files

# .env file
cat <<EOF >.env
MONGO_INITDB_ROOT_USERNAME=admin
MONGO_INITDB_ROOT_PASSWORD=123123
MONGO_DB=pokemon
EOF

# Dockerfile compose file
cat <<EOF >docker-compose.yml
version: "3.9"
services:
  mongodb:
    image: mongo:7
    restart: always
    env_file: .env
    environment:
      MONGO_INITDB_DATABASE: "\${MONGO_DB}"
    volumes:
      - mongo_data:/data/db
    networks:
      - backend

  flask:
    build: ./app
    restart: always
    env_file: .env
    environment:
      MONGO_URI: "mongodb://\${MONGO_INITDB_ROOT_USERNAME}:\${MONGO_INITDB_ROOT_PASSWORD}@mongodb:27017/\${MONGO_DB}?authSource=admin"
    ports:
      - "5000:5000"
    depends_on:
      - mongodb
    networks:
      - backend

volumes:
  mongo_data:

networks:
  backend:
EOF

# app/requirements.txt
cat <<EOF >app/requirements.txt
Flask==3.0.3
pymongo[srv]==4.8.0
EOF

# app/Dockerfile
cat <<EOF >app/Dockerfile
FROM python:3.12-slim
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY . .
ENV FLASK_APP=main.py
CMD ["flask", "run", "--host", "0.0.0.0", "--port", "5000"]
EOF

# app/main.py
cat <<EOF >app/main.py
from flask import Flask, jsonify
from pymongo import MongoClient
import os

app = Flask(__name__)
client = MongoClient(os.environ["MONGO_URI"])
db = client.get_database()

@app.route("/health")
def health():
    try:
        client.admin.command("ping")
        return jsonify(status="ok"), 200
    except:
        return jsonify(status="mongo unreachable"), 500

@app.route("/pokemon/<int:poke_id>")
def get_pokemon(poke_id):
    doc = db.pokemon.find_one({"id": poke_id}, {"_id": 0})
    return jsonify(doc or {"error": "not found"})

if __name__ == "__main__":
    app.run(debug=True)
EOF

# Build and run the Docker containers
cd ~/pokemon-stack
docker compose build
docker compose up -d

# Test the Flask app
echo "Waiting for Flask app to start..."
sleep 5 # Wait for the containers to start
curl http://localhost:5000/health || echo "Flask app is not running"
