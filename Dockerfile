# 1. Começamos com uma base Python padrão (Debian), não mais a do n8n (Alpine).
# Esta base é muito mais amigável para compilação.
FROM python:3.12-slim-bookworm

# 2. Instalamos as ferramentas de sistema essenciais usando 'apt-get' (o gerenciador do Debian)
# - nodejs & npm: Para instalar o n8n
# - ffmpeg & git: Nossas ferramentas de vídeo e código
RUN apt-get update && apt-get install -y --no-install-recommends \
    nodejs \
    npm \
    ffmpeg \
    git \
&& rm -rf /var/lib/apt/lists/*

# 3. Instalamos o n8n globalmente usando npm
RUN npm install -g n8n

# 4. Instalamos os pacotes Python. A compilação do PyAV (dependência do faster-whisper)
# funcionará nesta base de sistema mais completa.
RUN pip install yt-dlp faster-whisper torch --extra-index-url https://download.pytorch.org/whl/cpu

# 5. Criamos um usuário 'node' não-root por segurança, como a imagem oficial faz
RUN useradd -m -d /home/node -s /bin/bash node
USER node
WORKDIR /home/node

# 6. Expomos a porta padrão do n8n
EXPOSE 5678

# 7. Definimos o comando que inicia o n8n quando o container rodar
CMD ["n8n"]
