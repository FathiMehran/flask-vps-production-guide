Flask VPS Production Guide

This repository documents a clean and practical approach to deploying a Flask application on an Ubuntu VPS in a production-oriented manner.

The goal of this project is not to provide a quick demo, but to explain a realistic setup that considers Linux users, file permissions, PostgreSQL 
authentication, and common issues that usually appear when moving from local development to a VPS environment.

This guide is based on real problems encountered during deployment and focuses on stable, understandable solutions.

What This Repository Covers

This documentation explains how to:

Prepare an Ubuntu VPS for hosting a Flask application

Create and manage Linux users for application execution

Use Python virtual environments correctly on a server

Run Flask as a non-root user

Configure file and directory permissions safely

Set up PostgreSQL users and databases

Understand PostgreSQL authentication methods

Connect Flask to PostgreSQL using psycopg2

Diagnose and fix common permission and authentication errors

Avoid common production mistakes (running Flask as root, incorrect ownership, etc.)

What This Repository Does NOT Cover

Frontend development

CI/CD pipelines

Containerization (Docker)

High-availability or load balancing

Cloud-provider-specific services

The focus is intentionally limited to a single VPS setup using standard Linux tools.

Target Audience

This guide is intended for:

Developers deploying Flask applications on a VPS for the first time

Developers moving from local development to production

Anyone who wants to understand why certain Linux and PostgreSQL configurations are required, not just copy commands

Basic familiarity with Linux and Python is assumed.

Technology Stack

Ubuntu Server

Python 3

Flask

Virtualenv

PostgreSQL

psycopg2

Nginx (as a web server / reverse proxy)

Repository Structure

flask-vps-production-guide/
│
├── README.md
│
├── docs/
│   ├── 01-vps-initial-setup.md
│   ├── 02-linux-users-and-permissions.md
│   ├── 03-python-virtualenv-and-flask.md
│   ├── 04-nginx-and-process-user.md
│   ├── 05-postgresql-setup.md
│   ├── 06-postgresql-authentication.md
│   ├── 07-common-problems-and-fixes.md
│
├── scripts/
│   ├── create_user.sh
│   ├── fix_permissions.sh
│   └── postgres_cleanup.sql
│
└── example-app/
    ├── app.py
    ├── requirements.txt
    └── static/

How to Use This Guide

It is recommended to read the documents in the order provided in the docs/ directory.
Each file focuses on one topic and assumes the previous steps are already completed.

The guide is written to be read, not rushed.

Philosophy Behind This Guide

Run services with the least required privileges

Prefer clarity over shortcuts

Understand configuration instead of blindly copying commands

Treat the VPS as a production system, not a local machine

License

This repository is intended for educational and personal use.
You are free to adapt it to your own projects

