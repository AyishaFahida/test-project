#!/usr/bin/bash

# Reload systemd daemon
sudo systemctl daemon-reload

# Remove default Nginx site
sudo rm -f /etc/nginx/sites-enabled/default

# Copy new configuration
sudo cp /home/ubuntu/deploy_app/nginx/nginx.conf /etc/nginx/sites-available/deploymodel

# Remove old symbolic link if it exists
sudo rm -f /etc/nginx/sites-enabled/deploymodel

# Create new symbolic link
sudo ln -s /etc/nginx/sites-available/deploymodel /etc/nginx/sites-enabled/deploymodel

# Add www-data user to ubuntu group
sudo gpasswd -a www-data ubuntu

# Test Nginx configuration
sudo nginx -t

# If test passes, restart Nginx
if [ $? -eq 0 ]; then
    sudo systemctl restart nginx
else
    echo "Nginx configuration test failed. Please check your configuration."
    exit 1
fi