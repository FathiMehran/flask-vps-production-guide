# Python Virtual Environments and Flask

This document explains how to set up Python virtual environments on an Ubuntu VPS and run a Flask application correctly.

A proper Python environment setup prevents dependency conflicts, permission issues, and unexpected runtime errors in production.

---

## Why Virtual Environments Matter

System Python is shared by the operating system and other services. Installing application dependencies globally can:

* Break system tools
* Cause version conflicts
* Create permission problems

A virtual environment isolates application dependencies and keeps the system stable.

---

## Installing Required Packages

Ensure Python and virtual environment tools are installed:

```bash
sudo apt update
sudo apt install -y python3 python3-venv python3-pip
```

Verify versions:

```bash
python3 --version
pip3 --version
```

---

## Creating a Virtual Environment

Navigate to your project directory:

```bash
cd /home/mehran/myFlaskApp
```

Create the virtual environment:

```bash
python3 -m venv env
```

This avoids issues that can occur with the legacy `virtualenv` command.

---

## Activating the Virtual Environment

```bash
source env/bin/activate
```

You should see `(env)` in your shell prompt.

To deactivate:

```bash
deactivate
```

---

## Installing Flask and Dependencies

With the environment activated:

```bash
pip install flask
```

For real projects, dependencies should be pinned:

```bash
pip freeze > requirements.txt
```

---

## Running Flask Correctly

### Development Mode

For local testing only:

```bash
flask run
```

Important notes:

* This runs on `127.0.0.1:5000` by default
* It is not accessible externally without a reverse proxy
* It is not suitable for production

---

## Understanding the Flask Warning

When running `flask run`, you will see:

```text
WARNING: This is a development server. Do not use it in a production deployment.
```

This warning exists for a reason. The built-in server:

* Is single-threaded
* Has no request management
* Lacks security hardening

---

## Running Flask as the Correct User

Never run Flask as root.

Switch to the deployment user:

```bash
su - mehran
```

Activate the environment and run Flask:

```bash
cd /home/mehran/myFlaskApp
source env/bin/activate
flask run
```

This ensures file permissions and ownership behave as expected.

---

## Binding to External Interfaces (Temporary)

For testing with a reverse proxy:

```bash
flask run --host=127.0.0.1 --port=5000
```

Avoid binding directly to `0.0.0.0` without a proper web server.

---

## Common Errors and Solutions

### SameFileError When Creating Virtualenv

Cause:
Using the deprecated `virtualenv` command incorrectly.

Solution:

```bash
python3 -m venv env
```

---

## Result of This Step

After completing this document:

* Flask runs inside an isolated Python environment
* Dependency conflicts are avoided
* The application runs as a non-root user

---

## Next Step

Continue with:

**docs/04-nginx-and-process-user.md**

This next document explains how Nginx interacts with Flask and which user actually serves requests.

