#!/bin/bash
# Atualizar todos os pacotes do sistema
sudo apt-get update -y

# Instalar o Apache
sudo apt-get install -y apache2

# Habilitar o Apache para iniciar no boot
sudo systemctl enable apache2

# Instalar o Git
sudo apt-get install -y git

# Clonar o repositório Git
git clone https://github.com/FofuxoSibov/sitebike

# Mover os arquivos para o diretório do Apache
sudo mv sitebike/* /var/www/html/

# Reiniciar o serviço Apache
sudo systemctl restart apache2
