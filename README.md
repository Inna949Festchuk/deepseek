## [Все инструкции тут](https://github.com/ollama)

### **Мои заметки:**

## Чтобы запустить модель через Ollama просто в терминале

1. Установить `ollama` через pacman (у меня Linux Manjaro)

2. Выбрать нужную модель тут: https://ollama.com/search

3. Запустить в терминале (например `deepseek-r1:1.5b`)
```bash
ollama run deepseek-r1:1.5b 
```
4. Задать промт

5. Выйти
```bash
/bye
```

## Чтобы запустить модель через Ollama в серверном режиме, выполните следующие шаги:

Установите Ollama (если ещё не установлено):

Для Linux/macOS:

```bash
curl -fsSL https://ollama.com/install.sh | sh
```

Для Windows: загрузите установщик с официального сайта.


Запустите сервер Ollama(первый старт должен быть автоматически):

```bash
ollama serve
```
Сервер будет доступен на http://localhost:11434.


Проверка статуса службы
```bash
sudo systemctl status ollama 
```

[Выбририте](https://ollama.com/search) и загрузите модель (если ещё не загружена, !сервер должен работать!):
```bash
ollama pull deepseek-r1:1.5b
```
см. https://ollama.com/search

Просмотреть загруженные модели:
```bash
ollama ls
```

Проверить доступность API:
```bash
curl http://localhost:11434/api/tags
```

Пример запроса к модели:
```bash
curl http://localhost:11434/api/generate -d '{"model": "deepseek-r1:1.5b", "prompt": "Hello", "stream": false}'
```
см. https://github.com/ollama/ollama/blob/main/docs/api.md#model-names

удаленно
```Python
from openai import OpenAI

client = OpenAI(
    base_url='http://localhost:11434/v1/',

    # required but ignored
    api_key='ollama',
)

response = client.chat.completions.create(
    messages=[
        {
            'role': 'user',
            'content': 'Say this is a test',
        }
    ],
    model='deepseek-r1:1.5b',
)
# print(response)

# Извлечение content
content = response.choices[0].message.content
print(content)

```
локально
```Python
from ollama import chat

messages = [
  {
    'role': 'user',
    'content': 'Why is the sky blue?',
  },
]

response = chat('deepseek-r1:1.5b', messages=messages)
print(response['message']['content'])
```





## Если использовать Dockerfile:
1. Идем сюда:
https://hub.docker.com/r/ollama/ollama

2. Пулим образ ollama/ollama:
```bash
docker pull ollama/ollama
```
3. Проверяем образы
```bash
docker image ls
```
4. Запускаем контейнер с названием `ollama` по [инструкции](https://hub.docker.com/r/ollama/ollama) для CPU или GPU.

*Например, для CPU:*
```bash
docker run -d -v ollama:/root/.ollama -p 11434:11434 --name ollama ollama/ollama
```
5. Проверяем контейнеры:

Запущенные
```bash
docker ps
```

Останавливаем
```bash
docker stop <ID CONTAINER>
```

Остановленные
```bash
docker ps -a
```

Запускаем
```bash
docker start <ID CONTAINER>
```
6. Загружаем [нужную](https://ollama.com/library) модель в запущенный контейнер с названием `ollama`
```bash
docker exec -it ollama ollama run deepseek-r1:1.5b
```
7. Проверить доступность API:
```bash
curl http://localhost:11434/api/tags
```

8. Пример запроса к модели:
```bash
curl http://localhost:11434/api/generate -d '{"model": "deepseek-r1:1.5b", "prompt": "Hello", "stream": false}'
```
см. https://github.com/ollama/ollama/blob/main/docs/api.md#model-names

9. Останавливаем модель в контейнере:
```bash
/bye
```

## Если использовать фреймворк ollama с python:

1. Идем сюда:
https://github.com/ollama/ollama-python

2. Читаем инструкцию

## Если использовать фреймворк ollama с JS:

1. Идем сюда:
https://github.com/ollama/ollama-python

2. Читаем инструкцию
