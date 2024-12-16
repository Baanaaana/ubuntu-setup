# Ubuntu Setup Script

This repository contains a script to set up Nginx and PHP on Ubuntu 24.

## How to Use

To run the setup script directly from this repository, use the following command:

```bash
bash <(curl -s https://raw.githubusercontent.com/Baanaaana/ubuntu-setup/main/ubuntu-setup.sh)
```

This command will download and execute the script, installing and configuring Nginx and PHP on your Ubuntu system.

## What the Script Does

- Updates the package list
- Installs Nginx
- Starts and enables Nginx to start at boot
- Installs PHP, PHP-FPM, and additional PHP extensions
- Starts and enables PHP-FPM to start at boot
- Configures Nginx to use PHP-FPM
- Tests the Nginx configuration and restarts the service
- Allows HTTP traffic through the firewall
- Displays the installed versions of Nginx and PHP

## Requirements

- Ubuntu 24
- Internet connection to download packages

## Notes

Ensure you have the necessary permissions to execute the script and install packages on your system.