#!/bin/bash

# Обновляем пакеты и устанавливаем зависимости
sudo apt update && sudo apt install -y \
  ca-certificates \
  curl \
  gnupg \
  lsb-release

# Добавляем GPG-ключ для Docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Добавляем Docker репозиторий
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Обновляем информацию о пакетах и устанавливаем Docker
sudo apt update && sudo apt install -y \
  docker-ce \
  docker-ce-cli \
  containerd.io \
  docker-compose-plugin

# Добавляем пользователя в группу docker для работы без sudo
sudo usermod -aG docker $USER

# Применяем изменения для текущей сессии
newgrp docker

# Проверка установки Docker и Docker Compose
docker --version
docker compose version
