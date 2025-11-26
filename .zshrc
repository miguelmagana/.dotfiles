# ============================================================================
# ZSH CONFIGURATION - Hacker/Bug Bounty Optimized
# ============================================================================

# Exit if not running in zsh
if [ -z "$ZSH_VERSION" ]; then
    return 0 2>/dev/null || exit 0
fi

# History Configuration (Large for tool outputs)
HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=50000
setopt SHARE_HISTORY          # Share history between sessions
setopt HIST_IGNORE_DUPS       # Don't record duplicates
setopt HIST_IGNORE_SPACE      # Ignore commands starting with space
setopt HIST_VERIFY            # Show command before execution
setopt HIST_EXPIRE_DUPS_FIRST # Expire duplicates first
setopt HIST_FIND_NO_DUPS      # Don't show duplicates in history search
setopt APPEND_HISTORY         # Append to history file

# Basic Options
setopt AUTO_CD                # cd by typing directory name
setopt CORRECT                # Correct spelling
setopt COMPLETE_IN_WORD       # Complete from both ends
setopt ALWAYS_TO_END          # Move cursor to end after completion

# Enable colors
autoload -Uz colors && colors

# ============================================================================
# CUSTOM PROMPT - Two-line with separator border
# Inspired by robbyrussell, jonathan, duellj, nanotech themes
# ============================================================================

# Load VCS info for Git
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' formats ' %F{magenta}%b%f%F{red}%u%f%F{green}%c%f'
zstyle ':vcs_info:git:*' actionformats ' %F{magenta}%b%f%F{yellow}|%a%f%F{red}%u%f%F{green}%c%f'
zstyle ':vcs_info:*' unstagedstr '*'
zstyle ':vcs_info:*' stagedstr '+'
zstyle ':vcs_info:*' check-for-changes true

# Function to shorten path (breadcrumbs)
shorten_path() {
  local pwd="${PWD/#$HOME/~}"
  local max_len=40
  if [[ ${#pwd} -gt $max_len ]]; then
    echo "${pwd:0:15}...${pwd: -22}"
  else
    echo "$pwd"
  fi
}

# Exit code indicator
exit_code_indicator() {
  if [[ $? -eq 0 ]]; then
    echo "%F{green}✓%f"
  else
    echo "%F{red}✗%f %F{red}[%?]%f"
  fi
}

# Function to build separator line that fills remaining width
build_separator() {
  local term_width=${COLUMNS:-80}
  
  # Build left content (without color codes for length calculation)
  local user_host_plain="${USER}@$(hostname)"
  local path_plain="$(shorten_path)"
  
  # Get git info plain text (remove color codes)
  local git_info_plain="${vcs_info_msg_0_}"
  git_info_plain="${git_info_plain//%F\{[^}]*\}/}"
  git_info_plain="${git_info_plain//%f/}"
  git_info_plain="${git_info_plain//%b/}"
  git_info_plain="${git_info_plain//%u/*}"
  git_info_plain="${git_info_plain//%c/+}"
  
  # Exit code (will be calculated in prompt, use placeholder)
  local exit_plain="✓"
  
  # Build left side plain text
  local left_plain="${user_host_plain} ${path_plain}${git_info_plain} ${exit_plain}"
  
  # Right side (timestamp) - 8 chars for HH:MM:SS
  local right_plain="HH:MM:SS"
  local right_len=8
  
  # Calculate lengths
  local left_len=${#left_plain}
  
  # Border characters: ┌─ (2) + space (1) + space before separator (1) + space after separator (1) + ─┐ (2) = 7
  local border_chars=7
  local available=$((term_width - left_len - right_len - border_chars))
  
  # Minimum separator width
  [[ $available -lt 3 ]] && available=3
  
  # Build separator
  local sep=""
  local i=0
  while [[ $i -lt $available ]]; do
    sep="${sep}─"
    i=$((i + 1))
  done
  
  echo "$sep"
}

# Pre-command hook to update VCS info and build separator
precmd() {
  vcs_info
  _prompt_separator=$(build_separator)
}

# Set prompt with two-line layout and box-drawing borders
setopt PROMPT_SUBST

# First line: Full width with separator
# Left: user@host path git exit_code
# Middle: separator (fills remaining space)
# Right: timestamp
PROMPT='%F{cyan}┌─%f %F{cyan}%n@%m%f %F{blue}%$(shorten_path)%f${vcs_info_msg_0_} $(exit_code_indicator) %F{cyan}${_prompt_separator}%f %F{yellow}%*%f %F{cyan}─┐%f
%F{cyan}└─%f %F{green}%#%f '

RPROMPT=''

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
alias ls='ls --color=auto'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'

# Grep
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

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

autoload -Uz compinit
compinit

# Case insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# ============================================================================
# ZELLIJ INTEGRATION
# ============================================================================

# Auto-start Zellij if not already in a session
if command -v zellij &> /dev/null; then
  if [ -z "$ZELLIJ" ]; then
    if [ "$TERM_PROGRAM" != "vscode" ]; then
      exec zellij attach -c main || zellij
    fi
  fi
fi

# ============================================================================
# STARTUP MESSAGE - ASCII Art + System Stats
# ============================================================================

# Display on interactive shells only (zsh-specific check)
if [[ -o interactive ]] || [[ -n "$PS1" ]]; then
  # Display your custom ASCII art handle in cannabis green (#098009)
  # Use true color if supported, otherwise fallback to closest 256-color
  if [[ "$TERM" == *"256color"* ]] || [[ "$COLORTERM" == "truecolor" ]] || [[ "$COLORTERM" == "24bit" ]]; then
    # True color support - use exact hex color #098009
    print -P "%F{#098009}________ .__              ____          ______________  _____%f"
    print -P "%F{#098009}\_____  \|  |      ______/_   |______  /  |  \______  \/  |  |%f"
    print -P "%F{#098009}  _(__  <|  |      \____ \|   \_  __ \/   |  |_  /    /   |  |_%f"
    print -P "%F{#098009} /       \  |__    |  |_> >   ||  | \/    ^   / /    /    ^   /%f"
    print -P "%F{#098009}/______  /____/____|   __/|___||__|  \____   | /____/\____   |%f"
    print -P "%F{#098009}       \/    /_____/__|                   |__|            |__|%f"
  else
    # Fallback to closest 256-color green (color 28 is close to #098009)
    print -P "%F{28}________ .__              ____          ______________  _____%f"
    print -P "%F{28}\_____  \|  |      ______/_   |______  /  |  \______  \/  |  |%f"
    print -P "%F{28}  _(__  <|  |      \____ \|   \_  __ \/   |  |_  /    /   |  |_%f"
    print -P "%F{28} /       \  |__    |  |_> >   ||  | \/    ^   / /    /    ^   /%f"
    print -P "%F{28}/______  /____/____|   __/|___||__|  \____   | /____/\____   |%f"
    print -P "%F{28}       \/    /_____/__|                   |__|            |__|%f"
  fi
  echo ""

  # Display system information with rotating ASCII art
  if command -v neofetch &> /dev/null; then
    # Rotation mechanism: cycle through 4 ASCII arts
    NEOFETCH_ASCII_DIR="$HOME/.config/neofetch/ascii"
    NEOFETCH_STATE_FILE="$HOME/.config/neofetch/.ascii_state"
    
    # Get current rotation state (default to 1)
    if [ -f "$NEOFETCH_STATE_FILE" ]; then
      CURRENT_ASCII=$(cat "$NEOFETCH_STATE_FILE")
    else
      CURRENT_ASCII=1
    fi
    
    # Cycle through 1-4
    if [ "$CURRENT_ASCII" -ge 4 ]; then
      NEXT_ASCII=1
    else
      NEXT_ASCII=$((CURRENT_ASCII + 1))
    fi
    
    # Save next state for next time
    echo "$NEXT_ASCII" > "$NEOFETCH_STATE_FILE"
    
    # Use the current ASCII art file
    if [ -f "$NEOFETCH_ASCII_DIR/ascii${CURRENT_ASCII}.txt" ]; then
      neofetch --ascii_distro custom --ascii_source "$NEOFETCH_ASCII_DIR/ascii${CURRENT_ASCII}.txt" --ascii_colors 6 6 6 6 6 6
    else
      neofetch
    fi
  elif command -v fastfetch &> /dev/null; then
    fastfetch
  elif command -v screenfetch &> /dev/null; then
    screenfetch
  else
    # Fallback: Custom system info display
    echo ""
    echo "%F{yellow}═══════════════════════════════════════════════════════════%f"
    echo "%F{green}  System Information%f"
    echo "%F{yellow}═══════════════════════════════════════════════════════════%f"
    echo ""
    echo "  %F{cyan}OS:%f        $(uname -s) $(uname -r)"
    echo "  %F{cyan}Host:%f      $(hostname)"
    echo "  %F{cyan}User:%f      $(whoami)"
    echo "  %F{cyan}Shell:%f     $SHELL"
    echo "  %F{cyan}Uptime:%f    $(uptime -p 2>/dev/null || uptime | awk '{print $3,$4}' | sed 's/,//')"
    echo ""
  fi
fi
