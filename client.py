from openai import OpenAI

client = OpenAI(
    base_url='http://localhost:11435/v1/', # Стандартный порт
    # base_url='http://localhost:11435/v1/', # Проброшенный в контейнер

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
print(response)