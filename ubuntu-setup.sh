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

# Add neofetch to .bashrc to run on SSH login
echo "clear" >> ~/.bashrc
echo "neofetch" >> ~/.bashrc

# Display the versions of Nginx and PHP
echo "Installation complete. Versions installed:"
nginx -v
php -v

echo "Nginx, PHP-FPM, and PHP extensions installation and configuration complete."