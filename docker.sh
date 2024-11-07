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
  if ! command -v docker-compose &> /dev/null && ! docker compose version &> /dev/null; then
    echo "Docker Compose не найден. Устанавливаю Docker Compose..."
    
    # Загрузка последней версии Docker Compose
    sudo curl -L "https://github.com/docker/compose/releases/download/$(curl -s https://api.github.com/repos/docker/compose/releases/latest | grep -Po '"tag_name": "\K[^"]*')/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    
    # Делаем скачанный файл исполняемым
    sudo chmod +x /usr/local/bin/docker-compose
    
    # Проверка установки
    if command -v docker-compose &> /dev/null; then
      echo "Docker Compose успешно установлен."
    else
      echo "Не удалось установить Docker Compose."
    fi
  else
    echo "Docker Compose уже установлен."
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
