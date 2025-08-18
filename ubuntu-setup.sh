#!/bin/bash

echo "========================================="
echo "    Starting Ubuntu Setup Script"
echo "========================================="

# Update the package list
echo "Updating package list..."
sudo apt update

# Install neofetch
echo "Installing neofetch..."
sudo apt install -y neofetch

# Install htop (interactive process viewer)
echo "Installing htop..."
sudo apt install -y htop

# Install tmux (terminal multiplexer)
echo "Installing tmux..."
sudo apt install -y tmux

# Install dstat (system resource statistics)
echo "Installing dstat..."
sudo apt install -y dstat

# Install s-tui (stress terminal UI)
echo "Installing s-tui..."
sudo apt install -y s-tui stress

# Install and configure unattended-upgrades
echo "Installing and configuring unattended-upgrades..."
sudo apt install -y unattended-upgrades
sudo dpkg-reconfigure -plow unattended-upgrades

# Set up a cron job for daily updates
echo "Setting up daily update cron job..."
(crontab -l 2>/dev/null; echo "0 3 * * * apt update && apt upgrade -y") | crontab -

# Bash aliases and configurations
# Check if .bashrc exists
if [ ! -f ~/.bashrc ]; then
    echo "Creating .bashrc file..."
    touch ~/.bashrc
fi

echo "Adding configurations to .bashrc..."

# Add update alias
if ! grep -q "alias update='sudo -- sh -c \"apt update && sudo apt dist-upgrade -y && sudo apt upgrade -y && sudo apt autoremove -y\"'" ~/.bashrc; then
    echo -e "\n# update our debian/ubuntu box" >> ~/.bashrc
    echo "alias update='sudo -- sh -c \"apt update && sudo apt dist-upgrade -y && sudo apt upgrade -y && sudo apt autoremove -y\"'" >> ~/.bashrc
fi

# Add cron alias
if ! grep -q "alias cron='sudo crontab -e'" ~/.bashrc; then
    echo -e "\n# quick edit crontab" >> ~/.bashrc
    echo "alias cron='sudo crontab -e'" >> ~/.bashrc
fi

# Add blank line and clear
if ! grep -q "^echo \"\"" ~/.bashrc; then
    echo -e "\n# add blank line" >> ~/.bashrc
    echo "echo \"\"" >> ~/.bashrc
fi

if ! grep -q "^clear" ~/.bashrc; then
    echo -e "\n# clear default message" >> ~/.bashrc
    echo "clear" >> ~/.bashrc
fi

# Add neofetch to startup
if ! grep -q "^neofetch" ~/.bashrc; then
    echo -e "\n# start neofetch at SSH login" >> ~/.bashrc
    echo "neofetch" >> ~/.bashrc
fi

# Add the Ubuntu utility menu function to .bashrc
if ! grep -q "ubuntu-menu()" ~/.bashrc; then
    cat >> ~/.bashrc << 'EOF'

# Ubuntu Utility Menu Function
ubuntu-menu() {
    clear
    echo "========================================="
    echo "        Ubuntu Utility Menu"
    echo "========================================="
    echo "1. System Update (full system update)"
    echo "2. Show System Info (neofetch)"
    echo "3. Edit Crontab"
    echo "4. View Current Cron Jobs"
    echo "5. Check Unattended Upgrades Status"
    echo "6. View System Logs"
    echo "7. Check Disk Usage"
    echo "8. Check Memory Usage"
    echo "9. Run htop (Process Viewer)"
    echo "10. Run tmux (Terminal Multiplexer)"
    echo "11. Run dstat (System Statistics)"
    echo "12. Run s-tui (CPU Monitor & Stress Test)"
    echo "0. Exit Menu"
    echo "========================================="
    echo ""
    read -p "Select an option (0-12): " choice
    
    case $choice in
        1)
            echo "Running full system update..."
            sudo -- sh -c "apt update && sudo apt dist-upgrade -y && sudo apt upgrade -y && sudo apt autoremove -y"
            read -p "Press Enter to continue..."
            ubuntu-menu
            ;;
        2)
            neofetch
            read -p "Press Enter to continue..."
            ubuntu-menu
            ;;
        3)
            sudo crontab -e
            ubuntu-menu
            ;;
        4)
            echo "Current cron jobs:"
            crontab -l
            read -p "Press Enter to continue..."
            ubuntu-menu
            ;;
        5)
            echo "Checking unattended-upgrades status..."
            sudo systemctl status unattended-upgrades
            read -p "Press Enter to continue..."
            ubuntu-menu
            ;;
        6)
            echo "Recent system logs (last 50 lines):"
            sudo journalctl -n 50
            read -p "Press Enter to continue..."
            ubuntu-menu
            ;;
        7)
            echo "Disk usage:"
            df -h
            read -p "Press Enter to continue..."
            ubuntu-menu
            ;;
        8)
            echo "Memory usage:"
            free -h
            read -p "Press Enter to continue..."
            ubuntu-menu
            ;;
        9)
            htop
            ubuntu-menu
            ;;
        10)
            echo "Starting tmux session..."
            echo "Use 'Ctrl-B D' to detach, 'tmux attach' to reattach"
            sleep 2
            tmux
            ubuntu-menu
            ;;
        11)
            echo "Running dstat (press Ctrl-C to stop)..."
            dstat
            ubuntu-menu
            ;;
        12)
            echo "Starting s-tui (press q to quit)..."
            s-tui
            ubuntu-menu
            ;;
        0)
            echo "Exiting menu..."
            ;;
        *)
            echo "Invalid option. Please try again."
            sleep 2
            ubuntu-menu
            ;;
    esac
}

# Display welcome message with available commands
echo ""
echo "========================================="
echo "    Welcome to Ubuntu Server"
echo "========================================="
echo "Available Commands:"
echo "  ubuntu-menu  - Show utility menu"
echo "  update       - Update the system"
echo "  cron         - Edit crontab"
echo "========================================="
EOF
    echo "Ubuntu utility menu added to .bashrc"
fi

# Display completion message
echo ""
echo "========================================="
echo "    Ubuntu Setup Complete!"
echo "========================================="
echo "Installed packages:"
echo "  - neofetch (system information tool)"
echo "  - htop (interactive process viewer)"
echo "  - tmux (terminal multiplexer)"
echo "  - dstat (system resource statistics)"
echo "  - s-tui (CPU monitor and stress test)"
echo "  - unattended-upgrades (automatic security updates)"
echo ""
echo "Configured features:"
echo "  - Daily update cron job (3:00 AM)"
echo "  - 'update' alias for full system update"
echo "  - 'cron' alias for quick crontab editing"
echo "  - 'ubuntu-menu' command for utility menu"
echo "  - neofetch on login"
echo ""
echo "Please run: source ~/.bashrc"
echo "Or logout and login again to apply changes"
echo "========================================="