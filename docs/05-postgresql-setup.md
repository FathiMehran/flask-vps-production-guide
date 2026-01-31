# PostgreSQL Setup for Flask

This document explains how to install PostgreSQL on Ubuntu, create users and databases, and prepare it for use with a Flask application.

It also covers common authentication issues and best practices.

---

## Step 1: Install PostgreSQL

Update system packages and install PostgreSQL:

```bash
sudo apt update
sudo apt install -y postgresql postgresql-contrib
```

Check the service status:

```bash
sudo systemctl status postgresql
```

---

## Step 2: Switch to the PostgreSQL User

PostgreSQL runs under the `postgres` system user:

```bash
sudo -i -u postgres
```

Open the PostgreSQL prompt:

```bash
psql
```

---

## Step 3: Create a Database User

Create a user that Flask will use to connect:

```sql
CREATE USER mehran WITH PASSWORD 'your_secure_password';
```

Replace `'your_secure_password'` with a strong password.

Grant privileges:

```sql
ALTER USER mehran WITH SUPERUSER;
```

> Note: For production, consider granting only the necessary privileges.

---

## Step 4: Create a Database

Create a database owned by this user:

```sql
CREATE DATABASE mehran OWNER mehran;
```

Verify:

```sql
\l
```

---

## Step 5: Configure Authentication (pg_hba.conf)

Edit the PostgreSQL authentication file:

```bash
sudo nano /etc/postgresql/14/main/pg_hba.conf
```

Add or update lines for local connections:

```
# TYPE  DATABASE  USER    ADDRESS         METHOD
local     mehran    mehran                  md5
host      mehran    mehran    127.0.0.1/32  md5
```

Reload PostgreSQL:

```bash
sudo systemctl restart postgresql
```

---

## Step 6: Test the Connection

Exit to your normal user and test with psql:

```bash
psql -h 127.0.0.1 -U mehran -d mehran
```

Enter the password you set. You should connect successfully.

---

## Step 7: Connect Flask with psycopg2

In your Flask project:

```python
import psycopg2

conn = psycopg2.connect(
    database="mehran",
    user="mehran",
    password="your_secure_password",
    host="127.0.0.1",
    port="5432"
)
```

Replace `your_secure_password` with the password you set.

---

## Common Errors

* `password authentication failed`: Make sure the password matches the PostgreSQL user
* `role does not exist`: Ensure the user and database were created
* `connection refused`: Check that PostgreSQL is listening on 127.0.0.1

---

## Result of This Step

After completing this document:

* PostgreSQL is installed and running
* A user and database exist for Flask
* Authentication is configured for local connections
* Flask can connect securely using psycopg2

---

## Next Step

Continue with:

**docs/06-postgresql-authentication.md**

This document explains advanced authentication issues, managing passwords, and avoiding common operational errors in production environments.

