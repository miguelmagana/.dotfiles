# ============================================================================
# BASH CONFIGURATION - Fallback for systems without Zsh
# Hacker/Bug Bounty Optimized
# ============================================================================

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# ============================================================================
# HISTORY CONFIGURATION
# ============================================================================

HISTCONTROL=ignoreboth
HISTSIZE=50000
HISTFILESIZE=50000
shopt -s histappend
shopt -s checkwinsize
shopt -s globstar

# ============================================================================
# PROMPT CONFIGURATION
# ============================================================================

# Git branch in prompt
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

# Exit code indicator
exit_code_indicator() {
    if [ $? -eq 0 ]; then
        echo "✓"
    else
        echo "✗ [$?]"
    fi
}

# Custom prompt with Git support
PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\[\033[01;33m\]$(parse_git_branch)\[\033[00m\] \[\033[01;36m\]\t\[\033[00m\] \[\033[01;31m\]\$\[\033[00m\] '

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# ============================================================================
# COLOR SUPPORT
# ============================================================================

# Enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# ============================================================================
# ALIASES - Navigation
# ============================================================================

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# ============================================================================
# ALIASES - Standard Linux
# ============================================================================

# Listing
alias ll='ls -lah'
alias la='ls -A'
alias l='ls -CF'

# Safety
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# System
alias df='df -h'
alias du='du -h'
alias free='free -h'
alias ps='ps aux'
alias top='htop'

# ============================================================================
# ALIASES - Git
# ============================================================================

alias g='git'
alias ga='git add'
alias gaa='git add --all'
alias gb='git branch'
alias gc='git commit'
alias gcm='git commit -m'
alias gco='git checkout'
alias gd='git diff'
alias gl='git log --oneline --graph --decorate --all'
alias gp='git push'
alias gpl='git pull'
alias gs='git status'
alias gst='git stash'
alias gstp='git stash pop'

# ============================================================================
# ALIASES - Penetration Testing & Bug Bounty
# ============================================================================

# Network
alias myip='curl -s ifconfig.me'
alias localip='hostname -I | awk "{print \$1}"'
alias ports='netstat -tulanp'
alias listen='netstat -tulanp | grep LISTEN'
alias connections='netstat -an | grep ESTABLISHED'

# Nmap
alias nmap-quick='nmap -sn'
alias nmap-full='nmap -sC -sV -oA scan'
alias nmap-stealth='nmap -sS -sV -O'
alias nmap-udp='nmap -sU -sV'

# Directory Enumeration
alias gobuster-dir='gobuster dir -u'
alias ffuf-dir='ffuf -w /usr/share/wordlists/dirb/common.txt -u'
alias dirb-scan='dirb'

# Web Testing
alias burp='java -jar /opt/burpsuite/burpsuite.jar'
alias sqlmap-basic='sqlmap --batch --random-agent'
alias nikto-scan='nikto -h'

# File Operations
alias extract='tar -xzf'
alias compress='tar -czf'
alias find-large='find . -type f -size +100M'
alias find-perms='find . -type f -perm -4000'

# Process Management
alias pkill='pkill -9'
alias killport='fuser -k'

# Quick Tools
alias http-server='python3 -m http.server'
alias https-server='python3 -m http.server --bind 0.0.0.0'
alias nc-listener='nc -lvnp'

# ============================================================================
# FUNCTIONS - Bug Bounty Helpers
# ============================================================================

# Quick port scan
portscan() {
  if [ -z "$1" ]; then
    echo "Usage: portscan <target>"
    return 1
  fi
  nmap -p- --min-rate=1000 -T4 "$1"
}

# Subdomain enumeration helper
subdomain() {
  if [ -z "$1" ]; then
    echo "Usage: subdomain <domain>"
    return 1
  fi
  echo "Running subdomain enumeration on $1"
  # Add your favorite subdomain tool here
}

# Quick web server
serve() {
  local port=${1:-8000}
  python3 -m http.server "$port"
}

# ============================================================================
# ENVIRONMENT VARIABLES
# ============================================================================

export EDITOR=vim
export VISUAL=vim
export PAGER=less

# Add common tool paths
export PATH="$HOME/.local/bin:$PATH"
export PATH="/opt/tools:$PATH"

# ============================================================================
# COMPLETION
# ============================================================================

# Enable programmable completion features
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# ============================================================================
# STARTUP MESSAGE
# ============================================================================

# Display system info on startup
if command -v neofetch &> /dev/null; then
    neofetch
elif command -v fastfetch &> /dev/null; then
    fastfetch
elif command -v screenfetch &> /dev/null; then
    screenfetch
else
    # Fallback system info
    echo ""
    echo "User: $(whoami)@$(hostname)"
    echo "OS: $(uname -s) $(uname -r)"
    echo "Shell: $SHELL"
    echo ""
fi
