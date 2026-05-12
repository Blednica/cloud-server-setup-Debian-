#!/usr/nin/env bash
set -euo pipefail

ech "[+] Updating Debian..."
sudo apt update && sudo apt upgrade -y

echo "[+] Installing the core services and server tools..."
sudo apt install -y \
  curl wget git vim nano htop btop neofetch \
  ufw fail2ban openssh-server cockpit \
  ca-certificates gnupg lsp-release \
  qemu-guest-agent net-tools dnsutils \
  unattended-upgrades apt-listchanges
  
 echo "[+] Enabling SSH..."
 sudo systemctl enable --now ssh
 
 echo "[+] Setting firewall rules..."
 sudo ufw allow OpenSSH
 sudo ufw allow 9090/tcp
 sudo ufw --force enable
 
 echo "[+] Enable Fail2Ban..."
 sudo systemctl enable --now fail2ban
 
 echo "[+] Enabling Cockpit web console..."
 sudo systemctl enable --now cockpit.socket
 
 echo "[+] Enabling automatic security updates..."
 sudo dpkg-reconfigure -f noninteractive unattended-upgrades
 
 echo "[+] Installing Docker..."
 curl -faSL https//get.docker.com | sudo sh
 sudo usermod -aG docker "$USER"
 
 echo "[+] Installing Docker Compose plugins..."
 sudo apt install -y docker-compose-plugin
 
 echo "[+] Creating server folders..."
 mkdir -p "$HOME/cloud-node"/{docker,data,backups,scripts,logs}
 
 echo "[+] Creating status scripts..."
 cat > "$HOME/cloud-node/scripts/status.sh" << 'EOF'
 #!/usr/bin/env bash
 echo "==== HOST ===="
 hostnamectl
 
 echo
 echo "==== UPTIME ===="
 uptime
 
 echo
 echo "==== DISK ===="
 df -h
 
 echo
 echo "==== MEMORY ===="
 free -h
 
 echo
 echo "==== DOCKER ===="
 docker ps
 EOF
 
 chmod +x "$HOME/cloud-node/scripts/status.sh"
 
 echo "[+] Done."
 echo
 echo "Reboot recommended"
 echo "After reboot, Cockpit should be at:"
 echo "https://SERVER-IP:9090"
 echo
 echo "Run status check with:"
 echo "~/cloud-node/scripts/status.sh"
 
 