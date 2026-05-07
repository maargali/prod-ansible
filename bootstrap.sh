#!/bin/bash
set -e

echo "🔧 Updating system..."
sudo apt update

echo "📦 Installing prerequisites..."
sudo apt install -y software-properties-common

echo "📦 Installing Ansible..."
sudo apt install -y ansible

echo "📦 Checking Docker collection..."
if ! ansible-galaxy collection list | grep -q "community.docker"; then
    echo "Installing community.docker collection..."
    ansible-galaxy collection install -r requirements.yml
else
    echo "community.docker already installed"
fi

echo "📦 Installing sshpass (for password auth)..."
sudo apt install -y sshpass

echo "🔐 Checking SSH key..."
if [ ! -f ~/.ssh/id_rsa ]; then
    echo "Generating SSH key..."
    ssh-keygen -t rsa -b 4096 -f ~/.ssh/id_rsa -N ""
else
    echo "SSH key already exists"
fi

# Ask for VPS details BEFORE using them
read -p "Enter VPS IP: " VPS_IP

# Create inventory properly
mkdir -p inventory
echo "$VPS_IP ansible_user=root" > inventory/hosts

echo "🔑 Copying SSH key to VPS..."
ssh-copy-id root@$VPS_IP

echo "🔍 Testing Ansible connection..."
ansible all -i inventory/hosts -m ping

echo "🚀 Running playbook..."
ansible-playbook -i inventory/hosts install-nginx.yml

echo "✅ Bootstrap completed!"
