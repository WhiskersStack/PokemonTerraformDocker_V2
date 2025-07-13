#!/bin/bash

# --- Ansible Setup ---
echo "[INFO] Installing Ansible and dependencies..."

sudo apt update -y
sudo apt install -y software-properties-common
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt install -y ansible

# Optional: install Python Docker support (if needed by some modules)
# sudo apt install -y python3-docker

echo "[INFO] Installing Ansible Docker collection..."
ansible-galaxy collection install community.docker

ansible --version

# --- Run Ansible Playbook ---
cd /home/ubuntu/pokemon-ansible || {
  echo "[ERROR] /home/ubuntu/pokemon-ansible not found!"
  exit 1
}

echo "[INFO] Running playbook..."
#ansible-playbook -i inventory.ini pokemon_stack.yml
ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i inventory.ini pokemon_stack.yml

###############################################################################

# Game setup
# cd /home/ubuntu
# git clone https://github.com/WhiskersStack/PokemonWithDynamoDB.git
# chown -R ubuntu:ubuntu /home/ubuntu/PokemonWithDynamoDB
# echo 'if [ -n "$SSH_CONNECTION" ]; then cd ~/pokemon-ansible; fi' >> /home/ubuntu/.bashrc

# Ansible setup
# sudo apt update -y
# sudo apt install software-properties-common -y
# sudo add-apt-repository --yes --update ppa:ansible/ansible
# sudo apt install ansible -y
# ansible --version
# ansible-galaxy collection install community.docker

# cd ~/pokemon-ansible
# ansible-playbook -i inventory.ini pokemon_stack.yml --extra-vars="@vars.yml"
