#!/bin/bash

# Add docker repos
apt -qq -o=Dpkg::Use-Pty=0 update # Use-Pty=0 is an undocumented option to silence dpkg (users had mixed results)
apt -qq -o=Dpkg::Use-Pty=0 install -y apt-transport-https ca-certificates gnupg-agent software-properties-common
wget -q -O - https://download.docker.com/linux/debian/gpg | apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"

# Install packages
apt -qq -o=Dpkg::Use-Pty=0 update
apt -qq -o=Dpkg::Use-Pty=0 install -y \
    docker-ce docker-ce-cli containerd.io \
    ufw fail2ban


###
##  TOOLS
###

# Install Docker & docker-compose
wget -q -O /usr/local/bin/docker-compose "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)"
chmod +x /usr/local/bin/docker-compose
service docker restart
systemctl enable docker

###
##  VPN
###

# Get the necessary info
HOST_ADDR=$(wget -qO- http://ipecho.net/plain | xargs echo)

# Start the containers
docker-compose up -d

###
##  SECURITY
###

# Secure SSH
sed -i "s/#Port 22.*/Port 333/" /etc/ssh/sshd_config
systemctl restart ssh

# Enable firewall
ufw default deny
ufw default allow outgoing
ufw allow 333/tcp # SSH
#ufw allow 443/tcp # HTTPS for portal
#ufw allow 80/tcp # HTTP (for redirect to HTTPS)
ufw allow 50 # IKEv2
ufw allow 4500/udp # IKEv2
ufw allow 500/udp # IKEv2
ufw allow 51820/udp # Wireguard
ufw --force enable

echo "\nInstallation complete, quitting..."
exit 0