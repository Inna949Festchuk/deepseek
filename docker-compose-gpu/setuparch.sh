#!/bin/bash

# Для операционных систем:
# - Manjaro Linux основан на Arch Linux

# Убедитесь, что система обновлена
echo "Обновление системы..."
# sudo pacman -Syu --noconfirm

# Установка Docker, если он еще не установлен
echo "Установка Docker..."
# sudo pacman -S --noconfirm docker

# Установка NVIDIA драйверов (если они еще не установлены)
echo "Установка драйверов NVIDIA..."
# sudo pacman -S --noconfirm nvidia-utils

# Добавление репозитория NVIDIA Container Toolkit
echo "Установка NVIDIA Container Toolkit..."
# distribution=$(. /etc/os-release; echo $ID$VERSION_ID) && \
#     curl -s -L https://nvidia.github.io/libnvidia-container/arch.repo | \
#     sudo tee /etc/pacman.d/mirrorlist && \
#     sudo pacman -Syy --noconfirm nvidia-container-toolkit

# Настройка Docker для использования NVIDIA runtime
echo "Настройка Docker для NVIDIA runtime..."
sudo nvidia-ctk runtime configure --runtime=docker

# Перезапуск Docker
echo "Перезапуск Docker службы..."
sudo systemctl enable docker --now
sudo systemctl restart docker
