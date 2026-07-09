# linux-server-hardening
Script automatizado em Bash para Hardening de servidores Linux, aplicando regras estritas de firewall (UFW), segurança SSH e proteção contra força bruta com Fail2Ban.

# 🔒 Linux Server Hardening & Firewall Automation

Este repositório contém um script automatizado em **Bash** desenvolvido para aplicar boas práticas de segurança, gerenciamento de regras de rede e proteção proativa em servidores Linux (Debian/Ubuntu).

O script automatiza a instalação e configuração de barreiras de proteção, reduzindo a superfície de ataque de uma nova instância ou VPS em produção.

## 🛡️ O que este script faz?

1.  **Atualização de Segurança:** Garante que o gerenciador de pacotes do sistema esteja atualizado com as últimas correções.
2.  **Firewall Estrito (UFW):** Bloqueia todo o tráfego de entrada por padrão (`deny incoming`), liberando explicitamente apenas as portas essenciais de redes (`22/SSH`, `80/HTTP`, `443/HTTPS`).
3.  **Proteção contra Força Bruta (Fail2Ban):** Monitora os logs do sistema e bane temporariamente (por 1 hora) IPs que errarem a senha do SSH mais de 3 vezes consecutivas.
4.  **SSH Hardening:** Desabilita o acesso direto do usuário `root` via SSH, mitigando ataques direcionados ao superusuário.

## 🚀 Como Executar o Projeto

### Pré-requisitos
*   Um servidor rodando Linux (Ubuntu Server ou Debian recomendado).
*   Acesso com privilégios de superusuário (`sudo`).

### Passo a Passo

1. Clone este repositório para o seu servidor:
   ```bash
   git clone [https://github.com/SEU_USUARIO/linux-server-hardening.git](https://github.com/SEU_USUARIO/linux-server-hardening.git)
   cd linux-server-hardening

2. Dê permissão de execução para o script Bash:
   [chmod +x setup-security.sh]

3. Execute o script com privilégios de administrador:
   [sudo ./setup-security.sh]

🔍 Verificando o Status de Redes
Após a execução, você pode conferir as tabelas de regras ativas e o monitoramento através dos comandos:

Verificar Firewall: [sudo ufw status verbose]

Verificar Proteção SSH: [sudo fail2ban-client status sshd]
