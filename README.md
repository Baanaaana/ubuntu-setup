# Ubuntu Setup Script

This repository contains a script to set up Nginx, PHP, and Neofetch on Ubuntu 24, along with additional system configurations.

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
- Adds a new admin user with sudo privileges
- Installs and configures unattended-upgrades for automatic security updates
- Sets up a cron job to update and upgrade the system daily
- Adds useful aliases and configurations to `.bashrc`
  - Includes an alias for updating the system
  - Adds a command to clear the terminal and run Neofetch on SSH login
- Displays the installed versions of Nginx, PHP, and Neofetch

## Requirements

- Ubuntu 24
- Internet connection to download packages

## Notes

Ensure you have the necessary permissions to execute the script and install packages on your system.

# n8n-nodes-picqer

This is an n8n community node. It lets you use Picqer in your n8n workflows.

[n8n](https://n8n.io/) is a [fair-code licensed](https://docs.n8n.io/reference/license/) workflow automation platform.

[Installation](#installation)  
[Operations](#operations)  
[Credentials](#credentials)  
[Compatibility](#compatibility)  
[Resources](#resources)  

## Installation

Follow the [installation guide](https://docs.n8n.io/integrations/community-nodes/installation/) in the n8n community nodes documentation.

## Operations

- Customer
  - Create/Get/Update/Delete customers
  - Get all customers
- Order
  - Create/Get/Update orders
  - Get all orders
  - Close order
- Product
  - Create/Get/Update products
  - Get all products
  - Update stock

## Credentials

The node needs your Picqer subdomain and API key to connect to your account.

## Compatibility

Tested against n8n version 1.0+

## Resources

* [n8n community nodes documentation](https://docs.n8n.io/integrations/community-nodes/)
* [Picqer API documentation](https://picqer.com/en/api)