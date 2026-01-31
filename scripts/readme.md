# Scripts Usage and Pre-requisites

This README explains the usage, prerequisites, and important notes for all scripts in the `scripts/` folder of the Flask VPS Production Guide 
repository.

---

## Prerequisites

Before running any scripts:

1. Ensure Python 3.x, pip, and virtualenv are installed.
2. Ensure PostgreSQL is installed and running.
3. Make the scripts executable:

```bash
chmod +x scripts/*.sh
```

4. Run scripts under the correct user as indicated below.

---

## Scripts Overview

### 1. start-flask.sh

* **Purpose:** Start the Flask application using Gunicorn.
* **User:** The deployment user (`mehran` in examples).
* **Usage:**

```bash
./scripts/start-flask.sh
```

* **Notes:**

  * Must be run inside the virtual environment directory.
  * Check APP_DIR and APP_MODULE variables for correct paths.

### 2. stop-flask.sh

* **Purpose:** Stop the running Flask/Gunicorn server.
* **User:** Any user with permission to kill Gunicorn processes.
* **Usage:**

```bash
./scripts/stop-flask.sh
```

* **Notes:**

  * Verifies running processes before attempting to stop.

### 3. setup-postgres.sh

* **Purpose:** Create PostgreSQL user and database for Flask.
* **User:** Must be run as `root` to execute `sudo -u postgres` commands.
* **Usage:**

```bash
sudo ./scripts/setup-postgres.sh
```

* **Notes:**

  * Set a secure password in the script before running.
  * Script checks if user/database already exists to prevent errors.

### 4. cleanup.sh

* **Purpose:** Remove temporary files, CyberPanel swap, and stop Docker if not needed.
* **User:** Must be run as `root`.
* **Usage:**

```bash
sudo ./scripts/cleanup.sh
```

* **Notes:**

  * Ensures leftover services or files do not interfere with Flask deployment.

---

## General Recommendations

* Always test scripts in a **development or simulation environment** before running on production VPS.
* Review and modify variables like `APP_DIR`, `DB_USER`, `DB_PASS`, and `APP_MODULE` to match your environment.
* Monitor logs for Flask, Nginx, and PostgreSQL during and after running scripts.
* Ensure permissions for directories (uploads, static) are set correctly to allow Flask to write files without errors.
* Use `chmod +x` for any new script added to maintain executability.

---

With this README, users can safely execute scripts and understand the prerequisites and environment requirements.

