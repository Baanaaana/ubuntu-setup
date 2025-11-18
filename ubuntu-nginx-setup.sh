#!/bin/bash

# Update the package list
sudo apt update

# Install Nginx
sudo apt install -y nginx

# Start and enable Nginx to start at boot
sudo systemctl start nginx
sudo systemctl enable nginx

# Install PHP, PHP-FPM, and additional PHP extensions
sudo apt install -y php php-fpm php-mysql php-mbstring php-bcmath php-zip php-gd php-curl php-xml

# Detect the installed PHP version
PHP_VERSION=$(php -r "echo PHP_MAJOR_VERSION.'.'.PHP_MINOR_VERSION;")
echo "Detected PHP version: $PHP_VERSION"

# Start and enable PHP-FPM to start at boot
sudo systemctl start php${PHP_VERSION}-fpm
sudo systemctl enable php${PHP_VERSION}-fpm

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
        fastcgi_pass unix:/run/php/php${PHP_VERSION}-fpm.sock;
    }
}
EOL

# Test Nginx configuration and restart the service
sudo nginx -t && sudo systemctl restart nginx

# Allow HTTP traffic through the firewall
sudo ufw allow 'Nginx HTTP'

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

# Add nginx menu function to bashrc
if ! grep -q "nginx_menu()" ~/.bashrc; then
    cat >> ~/.bashrc << 'MENU_EOF'

# Nginx management menu
nginx_menu() {
    while true; do
        echo ""
        echo "================================"
        echo "   NGINX Management Menu"
        echo "================================"
        echo "1) Edit nginx config & restart"
        echo "2) Go to /var/www folder"
        echo "3) View nginx error logs"
        echo "4) View nginx access logs"
        echo "5) Test nginx configuration"
        echo "6) Exit to shell"
        echo "================================"
        read -p "Select an option [1-6]: " choice

        case $choice in
            1)
                sudo nano /etc/nginx/sites-available/default.conf
                echo "Restarting nginx..."
                sudo systemctl restart nginx
                if [ $? -eq 0 ]; then
                    echo "Nginx restarted successfully!"
                else
                    echo "Error restarting nginx. Check configuration."
                fi
                ;;
            2)
                cd /var/www
                echo "Changed directory to /var/www"
                break
                ;;
            3)
                echo "Viewing nginx error logs (Ctrl+C to exit)..."
                sudo tail -f /var/log/nginx/error.log
                ;;
            4)
                echo "Viewing nginx access logs (Ctrl+C to exit)..."
                sudo tail -f /var/log/nginx/access.log
                ;;
            5)
                echo "Testing nginx configuration..."
                sudo nginx -t
                read -p "Press Enter to continue..."
                ;;
            6)
                echo "Exiting to shell..."
                break
                ;;
            *)
                echo "Invalid option. Please select 1-6."
                ;;
        esac
    done
}

# Call nginx menu on login for interactive shells
if [[ $- == *i* ]]; then
    nginx_menu
fi
MENU_EOF
fi

# Display the versions of Nginx and PHP
echo "Installation complete. Versions installed:"
neofetch --version
nginx -v
php -v

echo "Neofetch, Nginx, PHP-FPM, and PHP extensions installation and configuration complete."