## Разворачиваем любые нейронки с помощью Ollama на примере DeepSeek
**Мои заметки. [Полная инструкция тут](https://github.com/ollama)**

### Подготовка системы Linux Manjaro (если хостовая операционная система Linux Manjaro, как у меня, если Ubuntu, Debian и аналогичные смотри ниже или [тут](https://hub.docker.com/r/ollama/ollama)):

- Проверьте и, если не установлен, установите драйвер nvidia (в поиск pacman введите nvidia).
- ollama и ollama-cuda (ввести в поиск pacman) 
- NVIDIA CUDA Toolkit (в поиск pacman введите cuda) [Источник](https://github.com/NVIDIA/nvidia-container-toolkit) "Убедитесь, что вы установили драйвер NVIDIA для вашего дистрибутива Linux. Обратите внимание, что вам не нужно устанавливать CUDA Toolkit на хост-систему, но драйвер NVIDIA должен быть установлен."

<!-- ### Настройка переменных окружения: Добавьте пути к CUDA в ваш файл .bashrc или .zshrc:
```bash
echo 'export PATH="/opt/cuda/bin:$PATH"' >> ~/.bashrc
echo 'export LD_LIBRARY_PATH="/opt/cuda/lib64:$LD_LIBRARY_PATH"' >> ~/.bashrc
source ~/.bashrc
``` -->

- NVIDIA Container Toolkit (в поиск pacman введите nvidia-container-toolkit). **Этого зверя точно надо устанавливать дополнительно**.

### Запуск службы ollama
```bash
echo "Запуск службы и проверка работоспособности"
sudo systemctl enable ollama
sudo systemctl start ollama
sudo systemctl status ollama
```
### Тестирование GPU: Для проверки работы GPU выполните команду:

```bash
nvidia-smi
```

### Тестирование CUDA: Для проверки установки CUDA выполните команду:
```bash
nvcc -V
``` 

Это отобразит информацию о вашей видеокарте NVIDIA и активных процессах.
Теперь вы готовы использовать GPU для ускорения своих моделей.

## Чтобы запустить модель через Ollama просто в терминале

1. Установить `ollama` через pacman (у меня Linux Manjaro)

2. Выбрать нужную модель [тут](https://ollama.com/search)

3. Запустить в терминале (например `deepseek-r1:1.5b`)
```bash
ollama run deepseek-r1:1.5b 
```
4. Задать промт прямо в консоли, либо в клиенте как это сделано ниже
(перед запуском кода установите все зависимости из requirements.txt):

**`clientlocal.py`**

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

5. Чтобы выйти введите в консоли
```bash
/bye
```

6. Остановите службу (при необходимости запуска сервера `ollama serve` см. чуть ниже и если снова нужно запустить локальную версию `sudo systemctl restart ollama`):
```bash
sudo systemctl stop ollama
```

7. Запустить службу:
```bash
sudo systemctl start ollama
```

8. Проверить статус службы:
```bash
sudo systemctl status ollama
```

## Чтобы запустить модель через Ollama в серверном режиме, выполните следующие шаги:

1. Установите Ollama (если ещё не установлено):

- Для Linux/macOS:

```bash
curl -fsSL https://ollama.com/install.sh | sh
```

- Для Windows: загрузите установщик с официального сайта.

2. Запустите сервер Ollama(первый старт должен быть автоматически):
```bash
ollama serve
```
Сервер будет доступен на `http://localhost:11434`.

3. Проверка статуса службы
```bash
sudo systemctl status ollama 
```

4. [Выбирете](https://ollama.com/search) и загрузите модель (если ещё не загружена, **!сервер должен работать!**):
```bash
ollama pull deepseek-r1:1.5b
```

5. Просмотреть загруженные модели:
```bash
ollama ls
```

6. Удалить загруженные модели:
```bash
ollama rm deepseek-r1:1.5b
```

7. Проверить доступность API:
```bash
curl http://localhost:11434/api/tags
```

8. Пример запроса к модели из терминала:
```bash
curl http://localhost:11434/api/generate -d '{"model": "deepseek-r1:1.5b", "prompt": "Hello", "stream": false}'
```
**Другие примеры [тут](https://github.com/ollama/ollama/blob/main/docs/api.md#model-names)**

9. Пример запроса к модели из клиента:

**`client.py`**

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

10. Если снова нужно запустить локальную версию 
```bash
sudo systemctl restart ollama
```

## Если использовать Dockerfile и CPU:

1. Идем [сюда](https://hub.docker.com/r/ollama/ollama)

2. Пулим образ ollama/ollama:
```bash
docker pull ollama/ollama
```

3. Проверяем образы
```bash
docker image ls
```

4. Запускаем контейнер с названием `ollama_cpu` по [инструкции](https://hub.docker.com/r/ollama/ollama) для CPU.
```bash
docker run -d -v ollama:/root/.ollama -p 11435:11434 --name ollama_cpu ollama/ollama
```

5. Проверяем контейнеры:
Запущенные
```bash
docker ps
```

- Останавливаем
```bash
docker stop <ID CONTAINER>
```

- Остановленные
```bash
docker ps -a
```

- Запускаем
```bash
docker start <ID CONTAINER>
```

6. Загружаем [нужную](https://ollama.com/library) модель в запущенный контейнер с названием `ollama_cpu`
```bash
docker exec -it ollama_cpu ollama run deepseek-r1:1.5b
```

7. Проверить доступность API:
```bash
curl http://localhost:11435/api/tags
```

8. Пример запроса к модели:
```bash
curl http://localhost:11435/api/generate -d '{"model": "deepseek-r1:1.5b", "prompt": "Hello", "stream": false}'
```
см. https://github.com/ollama/ollama/blob/main/docs/api.md#model-names

9. Останавливаем модель в контейнере:
```bash
/bye
```

## Если использовать Dockerfile и GPU:

1. Идем [сюда](https://hub.docker.com/r/ollama/ollama)

2. Пулим образ ollama/ollama:
```bash
docker pull ollama/ollama
```

3. Проверяем образы
```bash
docker image ls
```

4. Настраиваем GPU. Действуем по [инструкции](https://hub.docker.com/r/ollama/ollama)


### Настройка репозитория NVIDIA (Если ОС на хостовой машине Ubuntu, Debian и аналогичные)
```bash
echo "Setting up NVIDIA repository..."
curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg
curl -s -L https://nvidia.github.io/libnvidia-container/stable/deb/nvidia-container-toolkit.list \
    | sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' \
    | sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list
```

### Обновление пакетов и установка NVIDIA Container Toolkit
```bash
echo "Installing NVIDIA Container Toolkit..."
sudo apt-get update
sudo apt-get install -y nvidia-container-toolkit
```

### Настройка Docker runtime
```bash
echo "Configuring Docker to use NVIDIA runtime..."
sudo nvidia-ctk runtime configure --runtime=docker
sudo systemctl restart docker
```
---

## !Внимание! пример, для GPU NVIDIA и операционных систем:
- Linux Manjaro/Arch

### Настройка репозитория NVIDIA
Manjaro уже имеет в своем стандартном репозитории NVIDIA драйверы и интеграцию с контейнерами, 
поэтому **настраивать репозитории НЕ НУЖНО** 

### Обновление пакетов и установка NVIDIA Container Toolkit
для установки NVIDIA Container Toolkit в Manjaro **используем `pacman`**

### Настройка Docker для использования NVIDIA runtime
```bash
echo "Настройка Docker для NVIDIA runtime..."
sudo nvidia-ctk runtime configure --runtime=docker
```

### Перезапуск Docker
```bash
echo "Перезапуск Docker службы..."
sudo systemctl enable docker --now
sudo systemctl restart docker
```
---

6. Запускаем контейнер с названием `ollama_gpu`.
```bash
docker run -d --gpus=all -v ollama:/root/.ollama -p 11436:11434 --name ollama_gpu ollama/ollama
```

6. Проверяем контейнеры:

- Запущенные
```bash
docker ps
```

- Останавливаем
```bash
docker stop <ID CONTAINER>
```

- Остановленные
```bash
docker ps -a
```

- Запускаем
```bash
docker start <ID CONTAINER>
```

7. Загружаем [нужную](https://ollama.com/library) модель в запущенный контейнер с названием `ollama_gpu`
```bash
docker exec -it ollama_gpu ollama run deepseek-r1:1.5b
```

8. Проверить доступность API:
```bash
curl http://localhost:11436/api/tags
```

9. Пример запроса к модели:
```bash
curl http://localhost:11436/api/generate -d '{"model": "deepseek-r1:1.5b", "prompt": "Hello", "stream": false}'
```
см. https://github.com/ollama/ollama/blob/main/docs/api.md#model-names

10. Останавливаем модель в контейнере:
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
