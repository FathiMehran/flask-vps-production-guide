#!/bin/bash
# Start Flask application with Gunicorn
# Usage: ./start-flask.sh

APP_DIR="/home/mehran/myFlaskApp"
VENV_DIR="$APP_DIR/env"
APP_MODULE="app:app"  # Flask app entry point

echo "Activating virtual environment..."
source "$VENV_DIR/bin/activate"

echo "Starting Gunicorn server..."
# 4 workers, bind to localhost:5000
gunicorn -w 4 -b 127.0.0.1:5000 "$APP_MODULE"

echo "Flask application started on 127.0.0.1:5000"

