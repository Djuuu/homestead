#!/bin/sh

# Check If Adminer has been installed
if [ -f /home/vagrant/.adminer ]; then
    echo "Adminer already installed."
    exit 0
fi

touch /home/vagrant/.adminer

################################################################################
# Install Adminer

echo "Installiong Adminer..."

sudo mkdir -p /usr/local/share/adminer
sudo wget http://www.adminer.org/latest.php -O /usr/local/share/adminer/index.php
