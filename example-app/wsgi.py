"""
WSGI entry point for production servers like Gunicorn.

Usage example:
    gunicorn -w 4 -b 127.0.0.1:5000 wsgi:app
"""

from app import app

# Expose the Flask application object as `app`
# Gunicorn will look for this variable

if __name__ == "__main__":
    app.run()

