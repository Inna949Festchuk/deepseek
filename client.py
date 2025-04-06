from openai import OpenAI

client = OpenAI(
    base_url='http://localhost:11434/v1/', # Стандартный порт
    # base_url='http://localhost:11435/v1/', # Проброшенный в контейнер CPU
    # base_url='http://localhost:11436/v1/', # Проброшенный в контейнер GPU

    # required but ignored
    api_key='ollama',
)

response = client.chat.completions.create(
    messages=[
        {
            'role': 'user',
            'content': 'You are a programmer, write "Hello world" in Python',
        }
    ],
    model='deepseek-r1:1.5b',
    # model='llama3',
)

# print(response)

# Извлечение content
content = response.choices[0].message.content
print(content)
