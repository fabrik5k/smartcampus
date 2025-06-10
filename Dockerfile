# Usa imagem base leve com Python
FROM python:3.11-slim

# Instala dependências do sistema necessárias para Poetry e build
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl build-essential gcc git && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Instala Poetry
ENV POETRY_VERSION=1.8.2
RUN curl -sSL https://install.python-poetry.org | python3 -
ENV PATH="/root/.local/bin:$PATH"

# Define diretório de trabalho
WORKDIR /app

# Copia apenas arquivos necessários para instalação das dependências
COPY pyproject.toml poetry.lock* ./

# Instala dependências do projeto (sem criar virtualenv separado)
RUN poetry config virtualenvs.create false && \
    poetry install --no-interaction --no-ansi

# Copia o restante do código da aplicação
COPY . .

# Define o comando padrão do container
CMD ["python", "./middleware/consumidor.py"]

