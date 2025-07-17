# Ubuntu Setup Scripts

This repository contains two scripts for setting up Ubuntu systems with different configurations:

## Scripts Available

### 1. ubuntu-setup.sh (Basic Setup)
A lightweight script that installs essential system tools and configurations.

```bash
bash <(curl -s https://raw.githubusercontent.com/Baanaaana/ubuntu-setup/main/ubuntu-setup.sh)
```

**What it does:**
- Updates the package list
- Installs Neofetch
- Installs and configures unattended-upgrades for automatic security updates
- Sets up a cron job to update and upgrade the system daily at 3 AM
- Adds useful aliases and configurations to `.bashrc`:
  - `update` alias for comprehensive system updates
  - `cron` alias for quick crontab editing
  - Clears terminal and runs Neofetch on login
- Displays the installed version of Neofetch

### 2. ubuntu-nginx-setup.sh (Full Web Server Setup)
A comprehensive script that sets up a complete web server environment.

```bash
bash <(curl -s https://raw.githubusercontent.com/Baanaaana/ubuntu-setup/main/ubuntu-nginx-setup.sh)
```

**What it does:**
- Updates the package list
- Disables Apache2 to prevent conflicts with Nginx
- Installs and configures Nginx web server
- Installs PHP 8.3, PHP-FPM, and essential PHP extensions (mysql, mbstring, bcmath, zip, gd, curl, xml)
- Configures Nginx to work with PHP-FPM
- Backs up original Nginx configuration and creates optimized setup
- Configures firewall to allow HTTP traffic
- Optionally creates a new admin user with sudo privileges
- Installs Neofetch
- Installs and configures unattended-upgrades for automatic security updates
- Sets up a cron job to update and upgrade the system daily at 3 AM
- Adds useful aliases and configurations to `.bashrc`:
  - `update` alias for comprehensive system updates
  - `cron` alias for quick crontab editing
  - Clears terminal and runs Neofetch on login
- Displays the installed versions of Nginx, PHP, and Neofetch

## Requirements

- Ubuntu 24.04 (or compatible Ubuntu version)
- Internet connection to download packages
- Root/sudo privileges

## Notes

- Choose `ubuntu-setup.sh` for basic system setup without web server components
- Choose `ubuntu-nginx-setup.sh` for full web development environment
- Both scripts are idempotent and can be run multiple times safely
- The scripts will prompt for user input where necessary (admin user creation in nginx setup)