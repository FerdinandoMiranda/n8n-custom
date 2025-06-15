# Começa com a imagem oficial do n8n
FROM n8nio/n8n:latest

# Muda para o usuário root para poder instalar tudo
USER root

# Instala as dependências de sistema essenciais.
# A GRANDE MUDANÇA: Instalamos o 'py3-av' diretamente do Alpine,
# o que evita a compilação problemática do PyAV pelo pip.
RUN apk add --no-cache ffmpeg python3 py3-pip git py3-av

# Instala os pacotes Python restantes.
# O pip vai ver que o 'av' já está instalado e não tentará compilá-lo.
RUN pip install yt-dlp faster-whisper torch --break-system-packages --extra-index-url https://download.pytorch.org/whl/cpu

# Retorna para o usuário padrão do n8n por segurança
USER node
