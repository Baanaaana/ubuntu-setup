#!/bin/bash

echo "========================================="
echo "    Ubuntu Setup Uninstaller"
echo "========================================="
echo ""
echo "This script will remove:"
echo "  - Installed packages (fastfetch, htop, tmux, dstat, s-tui)"
echo "  - Unattended-upgrades configuration"
echo "  - Custom aliases (update, cron, m)"
echo "  - Ubuntu menu function"
echo "  - Cron job for daily updates"
echo "  - .bashrc customizations"
echo ""
read -p "Are you sure you want to uninstall? (y/N): " confirm

if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
    echo "Uninstall cancelled."
    exit 0
fi

echo ""
echo "Starting uninstall process..."

# Remove packages
echo "Removing installed packages..."
sudo apt remove -y fastfetch htop tmux dstat s-tui stress 2>/dev/null
sudo apt remove -y unattended-upgrades 2>/dev/null
sudo add-apt-repository --remove ppa:zhangsongcui3371/fastfetch -y 2>/dev/null
sudo apt autoremove -y

# Remove cron job for daily updates
echo "Removing daily update cron job..."
(crontab -l 2>/dev/null | grep -v "apt update && apt upgrade") | crontab -

# Create backup of .bashrc
echo "Creating backup of .bashrc..."
cp ~/.bashrc ~/.bashrc.backup.$(date +%Y%m%d_%H%M%S)

# Remove .bashrc modifications
echo "Removing .bashrc customizations..."

# Remove update alias
sed -i '/# update our debian\/ubuntu box/d' ~/.bashrc 2>/dev/null
sed -i "/alias update='sudo -- sh -c \"apt update && sudo apt dist-upgrade -y && sudo apt upgrade -y && sudo apt autoremove -y\"'/d" ~/.bashrc 2>/dev/null

# Remove cron alias
sed -i '/# quick edit crontab/d' ~/.bashrc 2>/dev/null
sed -i "/alias cron='sudo crontab -e'/d" ~/.bashrc 2>/dev/null

# Remove blank line addition
sed -i '/# add blank line/d' ~/.bashrc 2>/dev/null
sed -i '/^echo ""$/d' ~/.bashrc 2>/dev/null

# Remove clear command
sed -i '/# clear default message/d' ~/.bashrc 2>/dev/null
sed -i '/^clear$/d' ~/.bashrc 2>/dev/null

# Remove fastfetch from startup
sed -i '/# start fastfetch at SSH login/d' ~/.bashrc 2>/dev/null
sed -i '/^fastfetch$/d' ~/.bashrc 2>/dev/null

# Remove Ubuntu menu function and related content
# This removes everything from "# Ubuntu Utility Menu Function" to "alias m='ubuntu-menu'"
sed -i '/# Ubuntu Utility Menu Function/,/alias m=.ubuntu-menu./d' ~/.bashrc 2>/dev/null

# Remove welcome message
sed -i '/Welcome to Ubuntu Server/,/=========================================/d' ~/.bashrc 2>/dev/null

# Clean up any remaining empty lines at the end of .bashrc
sed -i -e :a -e '/^\s*$/d;N;ba' ~/.bashrc 2>/dev/null

echo ""
echo "========================================="
echo "    Uninstall Complete!"
echo "========================================="
echo "Removed:"
echo "  ✓ Packages (fastfetch, htop, tmux, dstat, s-tui, unattended-upgrades)"
echo "  ✓ Daily update cron job"
echo "  ✓ Custom aliases and functions"
echo "  ✓ .bashrc customizations"
echo ""
echo "A backup of your .bashrc was saved as:"
echo "  ~/.bashrc.backup.$(date +%Y%m%d)_*"
echo ""
echo "Please reload your shell or run 'source ~/.bashrc'"
echo "========================================="