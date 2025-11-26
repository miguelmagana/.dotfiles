# Alias Cheat Sheet

Complete reference for all aliases and functions in the dotfiles configuration.

## Navigation

| Alias | Command | Description |
|-------|---------|-------------|
| `..` | `cd ..` | Go up one directory |
| `...` | `cd ../..` | Go up two directories |
| `....` | `cd ../../..` | Go up three directories |
| `.....` | `cd ../../../..` | Go up four directories |

## Standard Linux

### Listing

| Alias | Command | Description |
|-------|---------|-------------|
| `ll` | `ls -lah` | List all files with details |
| `la` | `ls -A` | List all files including hidden |
| `l` | `ls -CF` | List files in columns |

### System

| Alias | Command | Description |
|-------|---------|-------------|
| `df` | `df -h` | Disk usage (human-readable) |
| `du` | `du -h` | Directory size (human-readable) |
| `free` | `free -h` | Memory usage (human-readable) |
| `ps` | `ps aux` | Process list |
| `top` | `htop` | Interactive process viewer |

### Safety

| Alias | Command | Description |
|-------|---------|-------------|
| `rm` | `rm -i` | Remove with confirmation |
| `cp` | `cp -i` | Copy with confirmation |
| `mv` | `mv -i` | Move with confirmation |

## Git

| Alias | Command | Description |
|-------|---------|-------------|
| `g` | `git` | Git command |
| `gs` | `git status` | Show repository status |
| `ga` | `git add` | Stage files |
| `gaa` | `git add --all` | Stage all files |
| `gb` | `git branch` | List branches |
| `gc` | `git commit` | Commit changes |
| `gcm` | `git commit -m` | Commit with message |
| `gco` | `git checkout` | Switch branches |
| `gd` | `git diff` | Show differences |
| `gl` | `git log --oneline --graph --decorate --all` | Pretty log view |
| `gp` | `git push` | Push to remote |
| `gpl` | `git pull` | Pull from remote |
| `gst` | `git stash` | Stash changes |
| `gstp` | `git stash pop` | Apply stashed changes |

## Network

| Alias | Command | Description |
|-------|---------|-------------|
| `myip` | `curl -s ifconfig.me` | Get public IP address |
| `localip` | `hostname -I \| awk "{print \$1}"` | Get local IP address |
| `ports` | `netstat -tulanp` | Show all listening ports |
| `listen` | `netstat -tulanp \| grep LISTEN` | Show only listening ports |
| `connections` | `netstat -an \| grep ESTABLISHED` | Show established connections |

## Nmap

| Alias | Command | Description |
|-------|---------|-------------|
| `nmap-quick` | `nmap -sn` | Quick ping scan |
| `nmap-full` | `nmap -sC -sV -oA scan` | Full scan with scripts and version detection |
| `nmap-stealth` | `nmap -sS -sV -O` | Stealth SYN scan with OS detection |
| `nmap-udp` | `nmap -sU -sV` | UDP scan with version detection |

## Directory Enumeration

| Alias | Command | Description |
|-------|---------|-------------|
| `gobuster-dir` | `gobuster dir -u` | Gobuster directory enumeration |
| `ffuf-dir` | `ffuf -w /usr/share/wordlists/dirb/common.txt -u` | FFuF directory enumeration |
| `dirb-scan` | `dirb` | DIRB directory scanner |

## Web Testing

| Alias | Command | Description |
|-------|---------|-------------|
| `burp` | `java -jar /opt/burpsuite/burpsuite.jar` | Launch Burp Suite |
| `sqlmap-basic` | `sqlmap --batch --random-agent` | SQL injection testing (basic) |
| `nikto-scan` | `nikto -h` | Web vulnerability scanner |

## File Operations

| Alias | Command | Description |
|-------|---------|-------------|
| `extract` | `tar -xzf` | Extract tar.gz archive |
| `compress` | `tar -czf` | Create tar.gz archive |
| `find-large` | `find . -type f -size +100M` | Find large files (>100MB) |
| `find-perms` | `find . -type f -perm -4000` | Find SUID files |

## Process Management

| Alias | Command | Description |
|-------|---------|-------------|
| `pkill` | `pkill -9` | Force kill process |
| `killport` | `fuser -k` | Kill process using port |

## Quick Tools

| Alias | Command | Description |
|-------|---------|-------------|
| `http-server` | `python3 -m http.server` | Start HTTP server (port 8000) |
| `https-server` | `python3 -m http.server --bind 0.0.0.0` | Start HTTP server on all interfaces |
| `nc-listener` | `nc -lvnp` | Netcat listener |

## Functions

### portscan

Quick port scan function.

**Usage:**
```bash
portscan <target>
```

**Example:**
```bash
portscan 192.168.1.1
```

### serve

Start a quick HTTP server.

**Usage:**
```bash
serve [port]
```

**Example:**
```bash
serve 8080
```

If no port is specified, defaults to 8000.

### subdomain

Subdomain enumeration helper.

**Usage:**
```bash
subdomain <domain>
```

**Example:**
```bash
subdomain example.com
```

Note: This is a placeholder function. Add your favorite subdomain enumeration tool in `.zshrc`.

## Tips

- Use `alias` to see all active aliases
- Add custom aliases in `.zshrc` or `.bashrc`
- Functions are defined in `.zshrc` and can be customized
- Some aliases require additional tools to be installed (nmap, gobuster, etc.)

