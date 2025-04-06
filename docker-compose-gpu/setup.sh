#!/bin/bash

# Операционные системы, для которых подходит:
# Ubuntu (16.04, 18.04, 20.04, 22.04 и выше)
# Debian (10 и выше)
# Другие системы, работающие с apt, например:
# Linux Mint (на базе Ubuntu/Debian)

# Настройка репозитория NVIDIA
echo "Setting up NVIDIA repository..."
curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg
curl -s -L https://nvidia.github.io/libnvidia-container/stable/deb/nvidia-container-toolkit.list \
    | sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' \
    | sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list

# Обновление пакетов и установка NVIDIA Container Toolkit
echo "Installing NVIDIA Container Toolkit..."
sudo apt-get update
sudo apt-get install -y nvidia-container-toolkit

# Настройка Docker runtime
echo "Configuring Docker to use NVIDIA runtime..."
sudo nvidia-ctk runtime configure --runtime=docker
sudo systemctl restart docker
