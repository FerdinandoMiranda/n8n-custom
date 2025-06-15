# Receita para o n8n com as ferramentas de vídeo
FROM n8nio/n8n:latest

# Mudar para o usuário root para poder instalar programas
USER root

# Instalar FFmpeg, Python e outras dependências direto na VPS
RUN apk add --no-cache ffmpeg ffmpeg-dev python3 py3-pip git build-base linux-headers pkgconfig

# Instalar as ferramentas de Python
RUN pip install yt-dlp faster-whisper torch --break-system-packages --extra-index-url https://download.pytorch.org/whl/cpu

# Voltar para o usuário padrão do n8n por segurança
USER node
