# Linux Users and Permissions

This document explains how Linux users, groups, ownership, and permissions affect a Flask application running on a VPS.

Many production issues are not caused by Flask itself, but by incorrect file ownership or permission configuration. Understanding this topic is 
essential before running any web application on a server.

---

## Linux User Model Overview

Linux controls access using three main concepts:

* **User**: The owner of a file or process
* **Group**: A collection of users
* **Permissions**: Read, write, and execute rules applied to user, group, and others

Every process on the system runs as a specific user.

---

## Why This Matters for Flask

When a Flask application:

* writes files (images, logs, uploads)
* reads configuration files
* accesses static directories

Linux permissions determine whether the operation succeeds or fails.

Common errors include:

* `Permission denied`
* Files not being created
* Static files not updating

---

## Checking the Current User

To see which user you are logged in as:

```bash
whoami
```

To see which user started a process:

```bash
ps aux | grep flask
```

This is important when Flask is run via a service manager or web server.

---

## File Ownership Basics

Check ownership of a directory:

```bash
ls -ld myFlaskApp
```

Example output:

```text
drwxr-xr-x 3 mehran www-data 4096 myFlaskApp
```

Meaning:

* Owner: `mehran`
* Group: `www-data`

---

## Permission Notation

Permissions are represented as:

```text
rwxr-xr--
```

Which maps to:

* Owner: read, write, execute
* Group: read, execute
* Others: read

Numeric representation:

* `7` = rwx
* `5` = r-x
* `4` = r--

---

## Changing Ownership

To change ownership of a directory and all subdirectories:

```bash
sudo chown -R mehran:www-data myFlaskApp
```

This is a common setup for Flask + Nginx.

---

## Changing Permissions Safely

Allow the owner full access and group read/execute:

```bash
sudo chmod -R 750 myFlaskApp
```

Avoid using `777`. It hides problems and introduces security risks.

---

## Allowing File Creation in a Subdirectory

If Flask needs to write files (for example, uploaded images):

```bash
sudo mkdir myFlaskApp/static/uploads
sudo chown -R mehran:www-data myFlaskApp/static/uploads
sudo chmod -R 770 myFlaskApp/static/uploads
```

Only the owner and group can write to this directory.

---

## Using Groups Effectively

Add the deployment user to the web server group:

```bash
sudo usermod -aG www-data mehran
```

Apply group permissions without restarting:

```bash
newgrp www-data
```

---

## Verifying Permissions

Check directory permissions:

```bash
namei -l myFlaskApp/static/uploads
```

This helps trace permission problems across directory paths.

---

## Common Mistakes

* Running Flask as root
* Using `chmod 777`
* Mismatched ownership between files and processes
* Forgetting to restart services after permission changes

---

## Result of This Step

After completing this document:

* You understand which user runs Flask
* File ownership is predictable
* Flask can safely read and write required files

---

## Next Step

Continue with:

**docs/03-python-virtualenv-and-flask.md**

This next document covers Python environments and running Flask correctly on a VPS.

