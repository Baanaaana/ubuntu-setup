# Ubuntu Setup Script

This repository contains a script to set up Nginx, PHP, and Neofetch on Ubuntu 24.

## How to Use

To run the setup script directly from this repository, use the following command:

```bash
bash <(curl -s https://raw.githubusercontent.com/Baanaaana/ubuntu-setup/main/ubuntu-setup.sh)
```

This command will download and execute the script, installing and configuring Nginx, PHP, and Neofetch on your Ubuntu system.

## What the Script Does

- Updates the package list
- Disables Apache2 to prevent conflicts with Nginx
- Installs Nginx
- Starts and enables Nginx to start at boot
- Installs PHP, PHP-FPM, and additional PHP extensions
- Starts and enables PHP-FPM to start at boot
- Installs Neofetch
- Configures Nginx to use PHP-FPM
- Backs up the original Nginx configuration file and creates a new one
- Tests the Nginx configuration and restarts the service
- Allows HTTP traffic through the firewall
- Adds useful aliases and configurations to `.bashrc`
  - Includes an alias for updating the system
  - Adds a command to clear the terminal and run Neofetch on SSH login
- Displays the installed versions of Nginx, PHP, and Neofetch

## Requirements

- Ubuntu 24
- Internet connection to download packages

## Notes

Ensure you have the necessary permissions to execute the script and install packages on your system.