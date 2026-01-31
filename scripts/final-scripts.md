# Flask VPS Scripts - Final Version

This document contains the finalized versions of all scripts for managing a Flask application on a VPS. Each script includes checks and comments to 
ensure safe execution and easier debugging.

---

## 1️⃣ start-flask.sh

```bash
#!/bin/bash
# Start Flask application with Gunicorn
# Usage: ./start-flask.sh

# Configurable variables
APP_DIR="/home/mehran/myFlaskApp"
VENV_DIR="$APP_DIR/env"
APP_MODULE="app:app"  # Flask app entry point
USER_TO_RUN="mehran"

# Check if the user running the script matches deployment user
if [ "$(whoami)" != "$USER_TO_RUN" ]; then
    echo "ERROR: This script must be run as user $USER_TO_RUN"
    exit 1
fi

# Activate virtual environment
if [ -f "$VENV_DIR/bin/activate" ]; then
    source "$VENV_DIR/bin/activate"
else
    echo "ERROR: Virtual environment not found at $VENV_DIR"
    exit 1
fi

# Start Gunicorn
echo "Starting Gunicorn server..."
gunicorn -w 4 -b 127.0.0.1:5000 "$APP_MODULE"
```

---

## 2️⃣ stop-flask.sh

```bash
#!/bin/bash
# Stop Flask/Gunicorn application
# Usage: ./stop-flask.sh

APP_MODULE="app:app"

# Kill Gunicorn processes running this app
PIDS=$(pgrep -f "gunicorn.*$APP_MODULE")
if [ -n "$PIDS" ]; then
    echo "Stopping Gunicorn processes: $PIDS"
    kill $PIDS
else
    echo "No Gunicorn processes found for $APP_MODULE"
fi
```

---

## 3️⃣ setup-postgres.sh

```bash
#!/bin/bash
# Setup PostgreSQL user and database for Flask
# Usage: sudo ./setup-postgres.sh

DB_USER="mehran"
DB_NAME="mehran"
DB_PASS="your_secure_password"  # Replace with strong password

# Must be run as root to use sudo -u postgres
if [ "$(whoami)" != "root" ]; then
    echo "ERROR: This script must be run as root"
    exit 1
fi

echo "Creating PostgreSQL user and database..."
sudo -i -u postgres psql <<EOF
DO
\$$
BEGIN
   IF NOT EXISTS (SELECT FROM pg_catalog.pg_roles WHERE rolname = '$DB_USER') THEN
      CREATE USER $DB_USER WITH PASSWORD '$DB_PASS';
   END IF;
   IF NOT EXISTS (SELECT FROM pg_database WHERE datname = '$DB_NAME') THEN
      CREATE DATABASE $DB_NAME OWNER $DB_USER;
   END IF;
END
\$$;
ALTER USER $DB_USER WITH SUPERUSER;
EOF

echo "PostgreSQL setup completed."
```

---

## 4️⃣ cleanup.sh

```bash
#!/bin/bash
# Cleanup temporary files, swap, and leftover CyberPanel or Docker artifacts
# Usage: sudo ./cleanup.sh

# Must be root
if [ "$(whoami)" != "root" ]; then
    echo "ERROR: This script must be run as root"
    exit 1
fi

# Remove CyberPanel swap if exists
SWAP_FILE="/var/lib/cyberpanel.swap"
if [ -f "$SWAP_FILE" ]; then
    echo "Removing CyberPanel swap..."
    swapoff "$SWAP_FILE"
    rm -f "$SWAP_FILE"
fi

# Stop Docker services if running
if systemctl is-active --quiet docker; then
    echo "Stopping Docker services..."
    systemctl stop docker
    systemctl disable docker
fi

if systemctl is-active --quiet docker.socket; then
    echo "Stopping Docker socket..."
    systemctl stop docker.socket
    systemctl disable docker.socket
fi

echo "Cleanup completed."
```

