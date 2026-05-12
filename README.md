# Debian Cloud Node Setup

Simple Bash setup script for turning a Debian system into a lightweight cloud/server node.

## Features

* SSH server
* UFW firewall
* Fail2Ban
* Cockpit web management
* Docker + Docker Compose
* Automatic security updates
* Basic monitoring tools
* Server folder structure

## Usage

Make executable:

```bash
chmod +x cloud_node_setup.sh
```

Run script:

```bash
./cloud_node_setup.sh
```

After installation, reboot the system.

Cockpit Web UI:

```text
https://SERVER-IP:9090
```

## Recommended Uses

* Homelab server
* Docker node
* VM host
* Cybersecurity lab
* Backup node
* Remote Linux management
