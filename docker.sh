#!/bin/bash

# Функция для установки или обновления Docker
install_or_update_docker() {
  if ! command -v docker &> /dev/null; then
    echo "Docker не найден. Устанавливаю Docker..."
    sudo apt update
    sudo apt install -y docker.io
    sudo systemctl start docker
    sudo systemctl enable docker
    echo "Docker успешно установлен."
  else
    echo "Docker уже установлен. Проверка обновлений..."
    sudo apt update
    sudo apt install --only-upgrade -y docker.io
    echo "Docker обновлен до последней доступной версии."
  fi
}

# Функция для установки или обновления Docker Compose
install_or_update_docker_compose() {
  if ! command -v docker-compose &> /dev/null; then
    echo "Docker Compose не найден. Устанавливаю Docker Compose..."
    sudo apt-get update
    sudo apt-get install -y docker-compose-plugin
    echo "Docker Compose успешно установлен."
  else
    echo "Docker Compose уже установлен. Проверка обновлений..."
    sudo apt-get update
    sudo apt-get install --only-upgrade -y docker-compose-plugin
    echo "Docker Compose обновлен до последней доступной версии."
  fi
}

# Функция для проверки и включения Docker демона
check_docker_daemon() {
  if ! sudo systemctl is-active --quiet docker; then
    echo "Docker демон отключен. Включаю Docker..."
    sudo systemctl start docker
    echo "Docker демон успешно запущен."
  else
    echo "Docker демон уже запущен."
  fi
}

# Проверка и установка/обновление Docker
install_or_update_docker

# Проверка и установка/обновление Docker Compose
install_or_update_docker_compose

# Проверка состояния демона Docker
check_docker_daemon
