# Ubuntu Setup Scripts

This repository contains scripts for setting up and managing Ubuntu systems with useful tools and configurations.

## Scripts Available

### 1. ubuntu-setup.sh (System Setup & Tools)
A comprehensive script that installs essential system monitoring tools and creates an interactive utility menu.

```bash
bash <(curl -s https://raw.githubusercontent.com/Baanaaana/ubuntu-setup/main/ubuntu-setup.sh)
```

**Packages installed:**
- **neofetch** - System information display tool
- **htop** - Interactive process viewer
- **tmux** - Terminal multiplexer for managing multiple sessions
- **dstat** - Versatile system resource statistics tool
- **s-tui** - Terminal UI for CPU monitoring and stress testing
- **unattended-upgrades** - Automatic security updates

**Configurations added:**
- Daily system update cron job (3:00 AM)
- Custom bash aliases:
  - `update` - Full system update command
  - `cron` - Quick crontab editing
  - `m` - Shortcut to open Ubuntu menu
- Interactive Ubuntu utility menu accessible via `ubuntu-menu` or `m`
- Neofetch display on login
- Clean terminal startup

**Ubuntu Utility Menu features:**
1. System Update (full update/upgrade)
2. Show System Info (neofetch)
3. Edit Crontab
4. View Current Cron Jobs
5. Check Unattended Upgrades Status
6. View System Logs
7. Check Disk Usage
8. Check Memory Usage
9. Run htop (Process Viewer)
10. Run tmux (Terminal Multiplexer)
11. Run dstat (System Statistics)
12. Run s-tui (CPU Monitor & Stress Test)

### 2. ubuntu-uninstall.sh (Uninstaller)
Safely removes all changes made by the ubuntu-setup.sh script.

```bash
bash <(curl -s https://raw.githubusercontent.com/Baanaaana/ubuntu-setup/main/ubuntu-uninstall.sh)
```

**What it removes:**
- All installed packages (neofetch, htop, tmux, dstat, s-tui, unattended-upgrades)
- Daily update cron job
- Custom aliases and menu function
- All .bashrc customizations
- Creates a backup of .bashrc before removal

### 3. ubuntu-nginx-setup.sh (Full Web Server Setup)
A comprehensive script that sets up a complete web server environment with Nginx and PHP.

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
- Includes all features from ubuntu-setup.sh (tools, aliases, menu)

## Requirements

- Ubuntu 24.04 (or compatible Ubuntu version)
- Internet connection to download packages
- Root/sudo privileges

## Usage

### Initial Setup
1. Run the setup script:
   ```bash
   bash ubuntu-setup.sh
   ```
   or for web server setup:
   ```bash
   bash ubuntu-nginx-setup.sh
   ```

2. Reload your shell configuration:
   ```bash
   source ~/.bashrc
   ```
   or logout and login again

3. Access the utility menu anytime:
   ```bash
   ubuntu-menu
   # or simply
   m
   ```

### Uninstalling
To remove all changes made by the setup script:
```bash
bash ubuntu-uninstall.sh
```

## Notes

- Choose `ubuntu-setup.sh` for system tools and monitoring setup
- Choose `ubuntu-nginx-setup.sh` for full web development environment
- Both scripts are idempotent and can be run multiple times safely
- The uninstall script creates a backup of .bashrc before making changes
- All scripts will prompt for confirmation where necessary