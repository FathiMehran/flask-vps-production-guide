# VPS Initial Setup (Ubuntu)

This document covers the initial and essential steps required to prepare an Ubuntu VPS for hosting a Flask application in a production-oriented 
environment.

The goal of this step is to establish a clean, secure baseline before installing any application-level dependencies.

---

## Assumptions

* You have a fresh Ubuntu Server VPS
* You have SSH access (root or a sudo-enabled user)
* The VPS has a static public IP address

---

## Step 1: Update the System

Always start by updating the system packages.

```bash
sudo apt update
sudo apt upgrade -y
```

Reboot if the kernel was updated:

```bash
sudo reboot
```

---

## Step 2: Create a Non-Root User

Running applications as root is unsafe. Create a dedicated user for deployment.

```bash
sudo adduser mehran
```

Follow the prompts and set a strong password.

---

## Step 3: Grant Sudo Access

Allow the new user to perform administrative tasks when needed.

```bash
sudo usermod -aG sudo mehran
```

Verify:

```bash
groups mehran
```

---

## Step 4: Configure SSH Access

Switch to the new user:

```bash
su - mehran
```

(Optional but recommended) Set up SSH key authentication and disable password login later.

---

## Step 5: Secure SSH Configuration

Edit the SSH configuration file:

```bash
sudo nano /etc/ssh/sshd_config
```

Recommended changes:

```text
PermitRootLogin no
PasswordAuthentication yes
```

Restart SSH:

```bash
sudo systemctl restart ssh
```

Ensure you can log in as the new user before closing your current session.

---

## Step 6: Firewall Setup (UFW)

Enable the firewall and allow essential services.

```bash
sudo ufw allow OpenSSH
sudo ufw enable
```

Check status:

```bash
sudo ufw status
```

---

## Step 7: Set Server Timezone

Correct timezone configuration is important for logs.

```bash
sudo timedatectl set-timezone UTC
```

Verify:

```bash
timedatectl
```

---

## Step 8: Install Basic Utilities

Install common tools used during administration.

```bash
sudo apt install -y curl wget git build-essential
```

---

## Result of This Step

After completing this document:

* The VPS is updated and secure
* A non-root user exists for application deployment
* SSH access is hardened
* A firewall is enabled

This server is now ready for application-level setup.

---

## Next Step

Continue with:

**docs/02-linux-users-and-permissions.md**

This next document explains Linux ownership, permissions, and how they affect Flask and Nginx deployments.

