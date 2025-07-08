#!/bin/bash

# Update the package list
sudo apt update

# Install neofetch
sudo apt install -y neofetch

# Install and configure unattended-upgrades
sudo apt install -y unattended-upgrades
sudo dpkg-reconfigure -plow unattended-upgrades

# Set up a cron job for daily updates
(crontab -l 2>/dev/null; echo "0 3 * * * apt update && apt upgrade -y") | crontab -

# Bash aliases and configurations
# Check if .bashrc exists
if [ ! -f ~/.bashrc ]; then
    echo "Creating .bashrc file..."
    touch ~/.bashrc
fi

echo "Adding configurations to .bashrc..."

if ! grep -q "alias update='sudo -- sh -c \"apt update && sudo apt dist-upgrade -y && sudo apt upgrade -y && sudo apt autoremove -y\"'" ~/.bashrc; then
    echo -e "\n# update our debian/ubuntu box" >> ~/.bashrc
    echo "alias update='sudo -- sh -c \"apt update && sudo apt dist-upgrade -y && sudo apt upgrade -y && sudo apt autoremove -y\"'" >> ~/.bashrc
fi

if ! grep -q "alias cron='sudo crontab -e'" ~/.bashrc; then
    echo -e "\n# quick edit crontab" >> ~/.bashrc
    echo "alias cron='sudo crontab -e'" >> ~/.bashrc
fi

if ! grep -q "^echo \"\"" ~/.bashrc; then
    echo -e "\n# add blank line" >> ~/.bashrc
    echo "echo \"\"" >> ~/.bashrc
fi

if ! grep -q "^clear" ~/.bashrc; then
    echo -e "\n# clear default message" >> ~/.bashrc
    echo "clear" >> ~/.bashrc
fi

# Neofetch installation
if ! command -v neofetch &> /dev/null; then
    echo "Installing neofetch..."
    sudo apt update
    sudo apt install -y neofetch
fi

if ! grep -q "^neofetch" ~/.bashrc; then
    echo -e "\n# start neofetch at SSH login" >> ~/.bashrc
    echo "neofetch" >> ~/.bashrc
fi

# Display the version of neofetch
echo "Installation complete. Version installed:"
neofetch -v

echo "Neofetch installation and basic configuration complete."