# Example Flask Application

This directory contains a minimal, production-oriented Flask example application. It is designed to work with the documentation and scripts provided in 
this repository and to be easily deployable on an Ubuntu VPS using Nginx and Gunicorn.

---

## Purpose of This Example

The goal of this example app is to:

* Demonstrate a clean Flask project structure
* Run safely as a non-root Linux user
* Work correctly behind Nginx using Gunicorn
* Connect to PostgreSQL using psycopg2
* Write files to disk with proper permissions

This application is intentionally simple and meant for learning, testing, and validation of the deployment process.

---

## Project Structure

```
example-app/
├── app.py
├── requirements.txt
├── wsgi.py
├── static/
│   └── images/
├── templates/
│   └── index.html
└── .env.example
```

---

## Application Files Overview

### app.py

* Main Flask application
* Defines routes and basic logic
* Can be extended for real-world usage

### wsgi.py

* Entry point for Gunicorn
* Exposes the Flask app object

### requirements.txt

* Python dependencies required to run the app

### static/

* Directory for static assets
* Flask must have write permission if files are generated dynamically

### templates/

* HTML templates rendered by Flask

### .env.example

* Example environment variables file
* Copy to `.env` and update values before running

---

## Running the Example Application

1. Create and activate a virtual environment:

```bash
python3 -m venv env
source env/bin/activate
```

2. Install dependencies:

```bash
pip install -r requirements.txt
```

3. Run the application locally:

```bash
flask run --host=127.0.0.1 --port=5000
```

4. For production, use Gunicorn:

```bash
gunicorn -w 4 -b 127.0.0.1:5000 wsgi:app
```

---

## Permissions Notes

* The Linux user running Flask must own or have write access to:

  * `static/`
  * Any upload or generated file directories

Example:

```bash
chown -R mehran:www-data static/
chmod -R 775 static/
```

---

## Database Connection

The example app is designed to connect to PostgreSQL using environment variables:

* `DB_NAME`
* `DB_USER`
* `DB_PASSWORD`
* `DB_HOST`
* `DB_PORT`

Never hard-code database credentials inside source files.

---

## Important Notes

* This app is not meant to be exposed directly to the internet without Nginx.
* Always disable Flask debug mode in production.
* Use strong PostgreSQL passwords and correct `pg_hba.conf` settings.

---

This example application serves as a reference implementation for the full Flask VPS Production Guide.

