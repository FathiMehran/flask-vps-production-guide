#!/bin/bash
# Setup PostgreSQL user and database for Flask
# Usage: sudo ./setup-postgres.sh

DB_USER="mehran"
DB_NAME="mehran"
DB_PASS="your_secure_password"  # Replace with strong password

echo "Creating PostgreSQL user and database..."
sudo -i -u postgres psql <<EOF
CREATE USER $DB_USER WITH PASSWORD '$DB_PASS';
CREATE DATABASE $DB_NAME OWNER $DB_USER;
ALTER USER $DB_USER WITH SUPERUSER;
EOF

echo "PostgreSQL setup completed."

