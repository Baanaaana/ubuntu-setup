#!/bin/bash

# Update the package list
sudo apt update

# Disable Apache2 to prevent conflicts with Nginx
sudo systemctl stop apache2
sudo systemctl disable apache2

# Install Nginx
sudo apt install -y nginx

# Start and enable Nginx to start at boot
sudo systemctl start nginx
sudo systemctl enable nginx

# Install PHP, PHP-FPM, and additional PHP extensions
sudo apt install -y php php-fpm php-mysql php-mbstring php-bcmath php-zip php-gd php-curl php-xml

# Start and enable PHP-FPM to start at boot
sudo systemctl start php8.3-fpm
sudo systemctl enable php8.3-fpm

# Install neofetch
sudo apt install -y neofetch

# Configure Nginx to use PHP-FPM
ORIGINAL_CONF="/etc/nginx/sites-available/default"
NEW_CONF="/etc/nginx/sites-available/default.conf"
sudo mv $ORIGINAL_CONF $ORIGINAL_CONF.bak

# Create a new Nginx configuration file
sudo tee $NEW_CONF > /dev/null <<EOL
server {
    listen 80;
    server_name localhost;
    root /var/www/html;
    index index.php index.html;

    location / {
        try_files \$uri \$uri/ =404;
    }

    location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/run/php/php8.3-fpm.sock;
    }
}
EOL

# Test Nginx configuration and restart the service
sudo nginx -t && sudo systemctl restart nginx

# Allow HTTP traffic through the firewall
sudo ufw allow 'Nginx HTTP'

# Add a new admin user
read -p "Enter the new admin username: " admin_user
sudo adduser $admin_user
sudo usermod -aG sudo $admin_user

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

# Display the versions of Nginx and PHP
echo "Installation complete. Versions installed:"
neofetch -v
nginx -v
php -v

echo "Neofetch, Nginx, PHP-FPM, and PHP extensions installation and configuration complete."