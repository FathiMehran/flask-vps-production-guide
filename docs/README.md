# Flask VPS Production Guide

This guide provides a complete workflow for deploying a Flask application on an Ubuntu VPS using Nginx as a reverse proxy and PostgreSQL as the 
database. All steps are divided into detailed documents for easy reference.

## Table of Contents

### 1. Linux Users and Permissions

* **File:** `docs/02-linux-users-and-permissions.md`
* Overview of creating deployment users, managing groups, and configuring folder permissions for Flask and Nginx.

### 2. Python Virtual Environment and Flask

* **File:** `docs/03-python-virtualenv-and-flask.md`
* Setting up Python virtual environments, installing dependencies, and running Flask safely as a non-root user.

### 3. Nginx and Process User

* **File:** `docs/04-nginx-and-process-user.md`
* Understanding which user Nginx and Flask run under, configuring permissions, and serving static files.

### 4. PostgreSQL Setup

* **File:** `docs/05-postgresql-setup.md`
* Installing PostgreSQL, creating users and databases for Flask, and configuring authentication.

### 5. PostgreSQL Authentication

* **File:** `docs/06-postgresql-authentication.md`
* Managing passwords, peer vs md5 authentication, common connection issues, and security best practices.

### 6. Common Problems and Fixes

* **File:** `docs/07-common-problems-and-fixes.md`
* Covers Flask, Nginx, and PostgreSQL common errors, permission issues, port conflicts, and leftover service problems (e.g., Docker, CyberPanel).

---

## How to Use This Guide

1. Follow the documents in the order of the table of contents.
2. Ensure all commands are executed as the appropriate user.
3. Check logs for debugging (Flask, Nginx, PostgreSQL).
4. Apply production best practices: non-root Flask, isolated virtual environments, strong database passwords, and proper file permissions.

---

This README acts as a navigation hub for all detailed guides in the repository, making it easier for developers to find each topic and maintain a 
clean, production-ready Flask deployment on VPS.

