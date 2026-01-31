# Common Problems and Fixes in Flask + Nginx + PostgreSQL Deployments

This document covers the most common issues encountered when running a Flask application on an Ubuntu VPS with Nginx as a reverse proxy and PostgreSQL 
as the database.

It provides clear steps to identify, troubleshoot, and resolve these problems.

---

## 1. Flask Development Server Warning

**Problem:** Running `flask run` shows:

```text
WARNING: This is a development server. Do not use it in a production deployment.
```

**Fix:** Use a production WSGI server such as Gunicorn or uWSGI behind Nginx.

```bash
pip install gunicorn
cd /home/mehran/myFlaskApp
gunicorn -w 4 -b 127.0.0.1:5000 app:app
```

---

## 2. Permission Denied When Writing Files

**Problem:** Flask cannot create or modify files:

```text
PermissionError: [Errno 13] Permission denied
```

**Fix:** Ensure the deployment user owns writable directories:

```bash
sudo chown -R mehran:www-data /home/mehran/myFlaskApp/uploads
sudo chmod -R 770 /home/mehran/myFlaskApp/uploads
```

Check which user Flask runs as:

```bash
ps aux | grep flask
```

---

## 3. Nginx Cannot Serve Static Files

**Problem:** 403 Forbidden for static assets

**Fix:** Ensure static directories are readable by Nginx worker user (`www-data`):

```bash
sudo chown -R mehran:www-data /home/mehran/myFlaskApp/static
sudo chmod -R 750 /home/mehran/myFlaskApp/static
```

Restart Nginx:

```bash
sudo systemctl restart nginx
```

---

## 4. PostgreSQL Connection Errors

### a. Password Authentication Failed

**Fix:**

* Verify password in `pg_hba.conf` using `md5`
* Reset password if necessary:

```sql
ALTER USER mehran WITH PASSWORD 'new_secure_password';
```

* Restart PostgreSQL:

```bash
sudo systemctl restart postgresql
```

### b. Role Does Not Exist

**Fix:** Ensure the user was created:

```sql
CREATE USER mehran WITH PASSWORD 'your_secure_password';
CREATE DATABASE mehran OWNER mehran;
```

---

## 5. Port Conflicts

**Problem:** Nginx or Flask cannot bind to ports

**Fix:**

* Check which process is using a port:

```bash
sudo lsof -i :80
sudo lsof -i :5000
```

* Stop conflicting service:

```bash
sudo systemctl stop apache2  # example if Apache is running
```

* Restart the desired service

---

## 6. Docker Interference

**Problem:** `docker0` network or Docker services conflict with Flask/Nginx ports

**Fix:** Stop and disable Docker if not needed:

```bash
sudo systemctl stop docker
sudo systemctl disable docker
sudo systemctl stop docker.socket
sudo systemctl disable docker.socket
```

---

## 7. Swap or CyberPanel Artifacts

**Problem:** Swap files or leftover CyberPanel services causing resource or port conflicts

**Fix:**

* Remove swap file if present:

```bash
sudo swapoff /var/lib/cyberpanel.swap
sudo rm -f /var/lib/cyberpanel.swap
```

* Check and remove CyberPanel services manually if needed

---

## 8. Logging for Debugging

* Flask logs (stdout or files in app)
* Nginx error and access logs: `/var/log/nginx/error.log`, `/var/log/nginx/access.log`
* PostgreSQL logs: `/var/log/postgresql/postgresql-14-main.log` (path may vary)

Monitoring logs is critical for production troubleshooting.

---

## Result of This Step

After completing this document:

* Most common deployment issues are covered
* Steps to diagnose and fix permission, authentication, port, and service conflicts are known
* Flask + Nginx + PostgreSQL environment is stable and production-ready

---

## Conclusion

Following these guides ensures a clean, production-ready Flask application on Ubuntu VPS with proper user management, file permissions, Python 
environment, web server configuration, and database setup.

This concludes the documentation series for **Flask VPS Production Guide**.

