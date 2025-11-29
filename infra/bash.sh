#!/bin/bash
set -e
export DEBIAN_FRONTEND=noninteractive

echo "===== Updating packages ====="
sudo apt-get update -y

echo "===== Installing Python 3.10 ====="
sudo add-apt-repository -y ppa:deadsnakes/ppa
sudo apt update -y
sudo apt install -y python3.10 python3.10-dev python3.10-venv
python3.10 --version

echo "===== Installing Azure Function Core Tools ====="
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/microsoft-ubuntu-jammy-prod jammy main" > /etc/apt/sources.list.d/dotnetdev.list'
sudo apt-get update -y
sudo apt-get install -y azure-functions-core-tools-4

echo "===== Installing Azure CLI ====="

# Reset corrupted repo if it exists
sudo rm -f /etc/apt/sources.list.d/azure-cli.list

sudo apt-get update -y
sudo apt-get install -y apt-transport-https ca-certificates curl gnupg lsb-release

# Add Microsoft key
curl -sL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | \
  sudo tee /etc/apt/keyrings/microsoft.gpg > /dev/null

# Add correct repo
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/microsoft.gpg] \
https://packages.microsoft.com/repos/azure-cli/ jammy main" \
  | sudo tee /etc/apt/sources.list.d/azure-cli.list

sudo apt-get update -y
sudo apt-get install -y azure-cli


echo "===== Setup Completed Successfully ====="
