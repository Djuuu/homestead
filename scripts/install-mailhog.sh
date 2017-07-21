#!/bin/sh

# "upstart" or "systemd". Use "systemd" for homestead box 0.5.0
initsystem="systemd"

# Check If MailHog has been installed
if [ -f /home/vagrant/.mailhog ]; then
    echo "MailHog already installed."
    exit 0
fi

touch /home/vagrant/.mailhog

################################################################################
# Install MailHog

echo "Installiong MailHog..."

#sudo wget \
#    https://github.com/mailhog/MailHog/releases/download/v0.2.0/MailHog_linux_amd64 \
#    -O /usr/local/bin/mailhog

sudo wget \
    https://github.com/mailhog/MailHog/releases/download/v1.0.0/MailHog_linux_amd64 \
    -O /usr/local/bin/mailhog

sudo chmod +x /usr/local/bin/mailhog

cat << EOF2 | sudo tee /etc/systemd/system/mailhog.service
[Unit]
Description=MailHog Email Catcher

[Service]
ExecStart=/usr/local/bin/mailhog
StandardOutput=journal

[Install]
WantedBy=multi-user.target
EOF2

sudo systemctl enable mailhog.service
sudo systemctl start  mailhog.service
