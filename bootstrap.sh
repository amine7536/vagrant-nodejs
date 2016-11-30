#!/usr/bin/env bash

export DEBIAN_FRONTEND="noninteractive"

sudo apt-get update -y
sudo apt-get upgrade -y

# Get "add-apt-repository" Command
sudo apt-get install -y software-properties-common

# Install Basics:
# Utilities and some Python dev tools
# NFS Support
sudo apt-get install -y build-essential git vim tree tmux curl wget unzip pigz \
    python-pip python-dev supervisor htop zsh libssl-dev nfs-common

# Add 1GB swap for memory overflow
sudo fallocate -l 1024M /var/tmp/swapfile
sudo chmod 600 /var/tmp/swapfile
sudo mkswap /var/tmp/swapfile
sudo swapon /var/tmp/swapfile
echo "/var/tmp/swapfile   none    swap    sw    0   0" | sudo tee -a /etc/fstab
printf "vm.swappiness=10\nvm.vfs_cache_pressure=50" | sudo tee -a /etc/sysctl.conf && sudo sysctl -p

# Allow caching of NFS file share
sudo apt-get install -y cachefilesd
echo "RUN=yes" | sudo tee /etc/default/cachefilesd

# Install MongoDB
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927
echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.2.list
sudo apt-get update
sudo apt-get install -y mongodb-org
sudo bash -c "echo 'never' > /sys/kernel/mm/transparent_hugepage/enabled"
sudo bash -c "echo 'never' > /sys/kernel/mm/transparent_hugepage/defrag"
sudo systemctl restart mongod
sudo systemctl enable mongod


# Install NodeJS (via NVM)
curl -sL https://raw.githubusercontent.com/creationix/nvm/v0.31.0/install.sh -o /home/ubuntu/install_nvm.sh
chmod +x /home/ubuntu/install_nvm.sh && /home/ubuntu/install_nvm.sh
source /home/ubuntu/.bashrc && sleep 5 && nvm install node
