#!/bin/bash
# Atualizar todos os pacotes do sistema
sudo apt-get update -y

# Instalar pré-requisitos
sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

# Adicionar a chave GPG oficial do Docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Configurar o repositório estável do Docker
echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Atualizar a lista de pacotes
sudo apt-get update -y

# Instalar o Docker
sudo apt-get install -y docker-ce docker-ce-cli containerd.io

# Verificar se o Docker está funcionando
sudo docker run hello-world

# Clonar o repositório do seu site
git clone hhttps://github.com/FofuxoSibov/sitebike

# Construir a imagem Docker
sudo docker build -t meu-site ./sitebike

# Executar o container Docker
sudo docker run -d -p 80:80 meu-site
