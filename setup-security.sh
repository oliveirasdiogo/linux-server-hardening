#!/bin/bash

# Cores para o output do terminal
GREEN='\033[032m'
RED='\033[031m'
NC='\033[0m'

echo -e "${GREEN}[*] Iniciando o Hardening e Configuração de Segurança...${NC}"

# 1. Atualizar o sistema operacional
echo -e "${GREEN}[*] Atualizando pacotes do sistema...${NC}"
sudo apt update && sudo apt upgrade -y

# 2. Instalar ferramentas de segurança essenciais
echo -e "${GREEN}[*] Instalando UFW e Fail2Ban...${NC}"
sudo apt install ufw fail2ban -y

# 3. Configurar o Firewall (UFW)
echo -e "${GREEN}[*] Aplicando regras estritas de Firewall...${NC}"
sudo ufw default deny incoming
sudo ufw default allow outgoing

# Permitir portas essenciais (Altere se usar portas customizadas)
sudo ufw allow ssh/tcp
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp

# Habilitar o Firewall
echo "y" | sudo ufw enable

# 4. Aplicar configurações de Hardening no SSH
echo -e "${GREEN}[*] Aplicando melhorias de segurança no SSH...${NC}"
SSHD_CONFIG="/etc/ssh/sshd_config"

if [ -f "$SSHD_CONFIG" ]; then
    # Desabilitar login de Root via SSH
    sudo sed -i 's/^#\?PermitRootLogin.*/PermitRootLogin no/' $SSHD_CONFIG
    # Desabilitar autenticação por senha pura (forçar uso de chaves SSH se desejado, opcional)
    # sudo sed -i 's/^#\?PasswordAuthentication.*/PasswordAuthentication no/' $SSHD_CONFIG
    
    # Reiniciar o serviço SSH para aplicar as mudanças
    sudo systemctl restart ssh
else
    echo -e "${RED}[!] Arquivo sshd_config não encontrado.${NC}"
fi

# 5. Configurar o Fail2Ban
echo -e "${GREEN}[*] Copiando configurações do Fail2Ban...${NC}"
if [ -f "./jail.local" ]; then
    sudo cp ./jail.local /etc/fail2ban/jail.local
    sudo systemctl restart fail2ban
    sudo systemctl enable fail2ban
else
    echo -e "${RED}[!] Arquivo jail.local não encontrado no diretório atual.${NC}"
fi

echo -e "${GREEN}[+] Hardening concluído com sucesso! Servidor Protegido.${NC}"
sudo ufw status verbose