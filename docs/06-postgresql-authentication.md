# PostgreSQL Authentication and Common Issues

This document explains advanced PostgreSQL authentication, managing passwords, and avoiding common operational errors when using PostgreSQL with Flask.

---

## Step 1: Understanding Authentication Methods

In `pg_hba.conf`, the `METHOD` field controls authentication:

* `md5` - password-based authentication (hashed)
* `peer` - matches Linux username with PostgreSQL username
* `trust` - no password required (not recommended in production)

For Flask, `md5` is recommended for local connections.

---

## Step 2: Resetting a Password

If you forgot the password for a PostgreSQL user:

```bash
sudo -i -u postgres
psql
```

Then:

```sql
ALTER USER mehran WITH PASSWORD 'new_secure_password';
```

Reload PostgreSQL:

```bash
sudo systemctl restart postgresql
```

---

## Step 3: Troubleshooting Authentication

### Common Errors

1. `password authentication failed for user "mehran"`

   * Ensure `pg_hba.conf` has `md5` for this user
   * Ensure the password matches exactly
   * Check for whitespace or special characters in the password

2. `role "mehran" does not exist`

   * Make sure you created the role in PostgreSQL

3. `connection refused`

   * Check PostgreSQL is running
   * Verify `listen_addresses` in `postgresql.conf` includes `127.0.0.1`

---

## Step 4: Using Peer Authentication

Optionally, you can use peer authentication for local connections:

```text
# pg_hba.conf
local   mehran    mehran    peer
```

This allows the Linux user `mehran` to connect without a password. Useful for scripts running under that user.

---

## Step 5: Security Considerations

* Never use `trust` in production
* Use strong passwords for all PostgreSQL users
* Limit superuser privileges; only grant what is necessary
* Regularly rotate passwords and monitor connection logs

---

## Step 6: Testing the Connection from Flask

```python
import psycopg2

conn = psycopg2.connect(
    database="mehran",
    user="mehran",
    password="new_secure_password",
    host="127.0.0.1",
    port="5432"
)
```

Verify you can create tables and insert data.

---

## Result of This Step

After completing this document:

* You understand PostgreSQL authentication methods
* You can reset and manage user passwords
* Common connection errors are easily diagnosable
* Flask can connect securely without encountering authentication failures

---

## Next Step

Continue with:

**docs/07-common-problems-and-fixes.md**

This final document covers common errors encountered in Flask + Nginx + PostgreSQL deployments and their solutions.

