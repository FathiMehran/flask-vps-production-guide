# Nginx and Process User

This document explains how Nginx interacts with a Flask application on an Ubuntu VPS and the importance of understanding which user serves the 
requests.

Many common production issues arise from user mismatches between Nginx, Flask, and the filesystem.

---

## Understanding Nginx User

Nginx runs as a system service. You can check which user it runs under:

```bash
ps aux | grep nginx
```

Typical output:

```text
root      1234  0.0  0.1  50000  4000 ? Ss   12:00   0:00 nginx: master process /usr/sbin/nginx
www-data  1235  0.0  0.1  50000  3000 ? S    12:00   0:00 nginx: worker process
```

Key points:

* The master process runs as root (for binding ports below 1024)
* Worker processes run as `www-data` by default

---

## Why User Matters

Flask will typically run on `127.0.0.1:5000` (or another port) and Nginx will act as a reverse proxy.

**Permissions are crucial:**

* `www-data` must be able to read static files served by Nginx
* The Flask deployment user (`mehran`) must be able to write files, logs, and uploads
* Mismatched ownership can cause `Permission denied` or 403 errors

---

## Checking Nginx Configuration

The user directive is defined in `/etc/nginx/nginx.conf`:

```text
user www-data;
```

Confirm by running:

```bash
grep 'user' /etc/nginx/nginx.conf
```

---

## Configuring Flask to Work with Nginx

* Run Flask as the deployment user (`mehran`) on a local port, e.g., 127.0.0.1:5000
* Nginx will proxy requests to this port
* Flask should **never** run as root

Example simple command:

```bash
su - mehran
source /home/mehran/myFlaskApp/env/bin/activate
flask run --host=127.0.0.1 --port=5000
```

---

## Setting File Permissions for Nginx

Static files served by Nginx must be readable by `www-data`:

```bash
sudo chown -R mehran:www-data /home/mehran/myFlaskApp/static
sudo chmod -R 750 /home/mehran/myFlaskApp/static
```

Uploaded or writable directories (uploads, logs) must be writable by `mehran`:

```bash
sudo chown -R mehran:www-data /home/mehran/myFlaskApp/uploads
sudo chmod -R 770 /home/mehran/myFlaskApp/uploads
```

---

## Common Issues

* `Permission denied` when Nginx cannot read static files
* Flask cannot write to a folder because of wrong owner or permissions
* Running Flask as root creates files owned by root, causing later permission problems

Always ensure: **deployment user owns writable directories, Nginx can read static files**.

---

## Result of This Step

After completing this document:

* You understand which users run Nginx and Flask
* Permissions are correctly aligned for reading and writing files
* Flask is safe to run behind Nginx

---

## Next Step

Continue with:

**docs/05-postgresql-setup.md**

This next document covers PostgreSQL installation, creating users, and preparing databases for Flask.

