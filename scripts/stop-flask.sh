#!/bin/bash
# Stop Flask/Gunicorn application
# Usage: ./stop-flask.sh

echo "Stopping Gunicorn..."
pkill -f 'gunicorn -w 4 -b 127.0.0.1:5000'

echo "Flask application stopped."

