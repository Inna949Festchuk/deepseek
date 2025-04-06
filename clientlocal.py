from ollama import chat

messages = [
  {
    'role': 'user',
    'content': 'Why is the sky blue?',
  },
]

# response = chat('deepseek-r1:7b', messages=messages)
response = chat('deepseek-r1:1.5b', messages=messages)
print(response['message']['content'])