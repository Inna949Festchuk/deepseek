
## Использовать Ollama c Docker-compose и GPU

1. Идем в эту дирректорию `docker-compose-gpu` и запускаем в ней терминал

2. В терминале для операционных систем:
    - Ubuntu (16.04, 18.04, 20.04, 22.04 и выше)
    - Debian (10 и выше)
    - Другие системы, работающие с apt, например:
    - Linux Mint (на базе Ubuntu/Debian)

- запускаем скрипт `setup.sh`
```bash
setup.sh
```

2. В терминале для операционных систем:
    - Manjaro Linux основан на Arch Linux

- даем право на выполнение
```bash
sudo chmod +x setuparch.sh
```

- запускаем скрипт `setuparch.sh`
```bash
sudo ./setuparch.sh
```

3. Запускаем Docker Compose:
```bash
docker-compose up -d
```

4. Проверяем запущенные контейнеры
```bash
docker ps
```

5. Загружаем [нужную](https://ollama.com/library) модель в запущенный контейнер с названием `ollama_gpu`
```bash
docker exec -it ollama_gpu ollama run deepseek-r1:1.5b
```

6. Выполняем тестовые запросы

7. Останавливаем модель в контейнере:
```bash
/bye
```

8. Останавливаем и выгружаем контейнер:
```bash
docker-compose down <ID CONTAINER>
```
