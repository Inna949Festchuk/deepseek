## Использовать Ollama c Docker-compose и CPU

1. Идем в эту дирректорию `docker-compose-cpu` и запускаем в ней терминал

2. В терминале:
```bash
docker-compose up -d
```
3. Проверяем запущенные контейнеры
```bash
docker ps
```
4. Загружаем [нужную](https://ollama.com/library) модель в запущенный контейнер с названием `ollama_cpu`
```bash
docker exec -it ollama_cpu ollama run deepseek-r1:1.5b
```
5. Выполняем тестовые запросы

6. Останавливаем модель в контейнере:
```bash
/bye
```
7. Останавливаем и выгружаем контейнер:
```bash
docker-compose down <ID CONTAINER>
```
