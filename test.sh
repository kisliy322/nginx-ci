#!/bin/bash
set -e

# Запуск контейнера с nginx
./start_nginx.sh

# Проверка кода ответа HTTP
response_code=$(curl -s -o /dev/null -w "%{http_code}" localhost:9889)
if [[ "$response_code" != "200" ]]; then
    echo "Error: Unexpected HTTP response code $response_code"
    exit 1
fi

# Сравнение md5-сумм файла index.html
expected_md5=$(md5sum index.html | awk '{print $1}')
actual_md5=$(curl -s localhost:9889/index.html | md5sum | awk '{print $1}')
if [[ "$expected_md5" != "$actual_md5" ]]; then
    echo "Error: MD5 checksums do not match"
    exit 1
fi

echo "Tests passed successfully"

# Остановка и удаление контейнера
./stop_nginx.sh
