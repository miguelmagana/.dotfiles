# Architecture Documentation

Technical documentation for the dotfiles configuration system.

## System Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                    Terminal Startup                         │
└─────────────────────────────────────────────────────────────┘
                          │
                          ▼
┌─────────────────────────────────────────────────────────────┐
│                    Load .zshrc                              │
│  • History Configuration                                    │
│  • Zsh Options                                              │
│  • VCS Info Module (Git)                                    │
│  • Custom Prompt Function                                   │
│  • Aliases                                                  │
│  • Functions                                                │
│  • Zellij Integration                                       │
│  • Startup Display                                          │
└─────────────────────────────────────────────────────────────┘
                          │
                          ▼
┌─────────────────────────────────────────────────────────────┐
│              Display ASCII Handle (#098009)                 │
└─────────────────────────────────────────────────────────────┘
                          │
                          ▼
┌─────────────────────────────────────────────────────────────┐
│              Display System Info (neofetch)                 │
└─────────────────────────────────────────────────────────────┘
                          │
                          ▼
┌─────────────────────────────────────────────────────────────┐
│              Start Zellij (if not in session)                │
└─────────────────────────────────────────────────────────────┘
                          │
                          ▼
┌─────────────────────────────────────────────────────────────┐
│              Display Custom Prompt                          │
└─────────────────────────────────────────────────────────────┘
```

## Prompt Structure Breakdown

### Visual Layout

```
┌─ user@host /path/to/dir (main*) [✓] ──────────────────────────── 14:30:25 ─┐
└─ % 
```

### Component Details

#### Line 1: Information Bar

| Component | Code | Color | Description |
|-----------|------|-------|-------------|
| `┌─` | `%F{cyan}┌─%f` | Cyan | Top-left border |
| `user@host` | `%F{cyan}%n@%m%f` | Cyan | Username and hostname |
| `/path/to/dir` | `%F{blue}%$(shorten_path)%f` | Blue | Current directory (shortened if >35 chars) |
| `(main*)` | `${vcs_info_msg_0_}` | Magenta/Red/Green | Git branch and status |
| `[✓]` | `$(exit_code_indicator)` | Green/Red | Exit code indicator |
| `─` | `%F{cyan}─%f` | Cyan | Separator (fills remaining width) |
| `14:30:25` | `%F{yellow}%*%f` | Yellow | Current time |
| `─┐` | `%F{cyan}─┐%f` | Cyan | Top-right border |

#### Line 2: Input Prompt

| Component | Code | Color | Description |
|-----------|------|-------|-------------|
| `└─` | `%F{cyan}└─%f` | Cyan | Bottom-left border |
| `%` or `#` | `%F{green}%#%f` | Green | Prompt symbol (`%` for user, `#` for root) |

### Git Status Indicators

- **Magenta**: Branch name
- **Red `*`**: Unstaged changes
- **Green `+`**: Staged changes
- **Yellow `\|action`**: Git action (rebase, merge, etc.)

## Color Scheme Reference

### Prompt Colors

| Color | Code | Usage |
|-------|------|-------|
| Cyan | `%F{cyan}` | User@Host, Box borders |
| Blue | `%F{blue}` | Directory path |
| Magenta | `%F{magenta}` | Git branch name |
| Red | `%F{red}` | Git unstaged changes, Exit code (error) |
| Green | `%F{green}` | Git staged changes, Exit code (success), Prompt symbol |
| Yellow | `%F{yellow}` | Timestamp |

### ASCII Handle Color

- **Primary**: `%F{#098009}` - True color support (cannabis green)
- **Fallback**: `%F{28}` - 256-color mode (closest green)

## File Structure

```
.dotfiles/
├── .zshrc              # Main Zsh configuration
│   ├── History Config (50k entries)
│   ├── Zsh Options
│   ├── VCS Info Module
│   ├── Custom Prompt
│   ├── Aliases (50+)
│   ├── Functions (3)
│   ├── Zellij Integration
│   └── Startup Display
│
├── .bashrc             # Bash fallback configuration
│   ├── History Config (50k entries)
│   ├── Custom Prompt
│   ├── Aliases (same as .zshrc)
│   └── Functions (same as .zshrc)
│
├── .vimrc              # Vim configuration
│   ├── Visual Settings
│   ├── Editing Settings
│   ├── Search Settings
│   ├── Key Mappings
│   └── Status Line
│
├── .gitconfig          # Git configuration
│
├── install.sh          # Installation script
│   ├── Backup existing dotfiles
│   ├── Create symlinks
│   ├── Install dependencies
│   └── Set zsh as default (optional)
│
├── uninstall.sh        # Uninstallation script
│   ├── Remove symlinks
│   └── Restore backups
│
└── Documentation/
    ├── README.md
    ├── ALIASES.md
    └── ARCHITECTURE.md
```

## Dependencies

### Required

| Package | Purpose | Installation |
|---------|---------|--------------|
| zsh | Shell | `apt-get install zsh` |
| zellij | Terminal multiplexer | GitHub releases |
| neofetch | System info display | `apt-get install neofetch` |

### Optional

| Package | Purpose | Required For |
|---------|---------|--------------|
| git | Version control | Git aliases, prompt Git info |
| nmap | Network scanning | nmap-* aliases |
| gobuster | Directory enumeration | gobuster-dir alias |
| sqlmap | SQL injection testing | sqlmap-basic alias |
| nikto | Web vulnerability scanning | nikto-scan alias |

## History Configuration

- **HISTSIZE**: 50,000 entries in memory
- **SAVEHIST**: 50,000 entries saved to file
- **HISTFILE**: `~/.zsh_history`

### History Options

- `SHARE_HISTORY`: Share history between sessions
- `HIST_IGNORE_DUPS`: Don't record duplicates
- `HIST_IGNORE_SPACE`: Ignore commands starting with space
- `HIST_VERIFY`: Show command before execution
- `HIST_EXPIRE_DUPS_FIRST`: Expire duplicates first
- `HIST_FIND_NO_DUPS`: Don't show duplicates in history search
- `APPEND_HISTORY`: Append to history file

## VCS Info Configuration

Git integration using Zsh's built-in `vcs_info` module:

```zsh
zstyle ':vcs_info:git:*' formats ' %F{magenta}%b%f%F{red}%u%f%F{green}%c%f'
```

- `%b`: Branch name (magenta)
- `%u`: Unstaged changes (red `*`)
- `%c`: Staged changes (green `+`)
- `%a`: Git action (yellow, shown in actionformats)

## Zellij Integration

Auto-starts Zellij if:
- Zellij is installed
- Not already in a Zellij session (`$ZELLIJ` is empty)
- Not in VS Code terminal (`$TERM_PROGRAM != "vscode"`)

Behavior:
1. Try to attach to existing session named "main"
2. If no session exists, create a new Zellij session

## Startup Sequence

1. Terminal opens
2. Zsh loads `.zshrc`
3. Display ASCII handle in cannabis green (#098009)
4. Display system information (neofetch/fastfetch/screenfetch)
5. Zellij auto-starts (if conditions met)
6. Custom prompt appears

## Installation Process

1. **Backup**: Existing dotfiles moved to `~/dotfiles_backup_YYYYMMDD_HHMMSS`
2. **Symlink**: Create symlinks from `~/dotfiles/` to `~/`
3. **Dependencies**: Check and install zsh, zellij, neofetch
4. **Default Shell**: Optionally set zsh as default shell
5. **Apply**: Source new configuration or restart terminal

## Uninstallation Process

1. **Find Backup**: Locate latest backup directory
2. **Remove Symlinks**: Delete all symlinks
3. **Restore**: Move original files back from backup
4. **Apply**: Source restored configuration

## Customization Points

### Prompt Colors
Edit color codes in `.zshrc` prompt definition.

### ASCII Handle Color
Modify the color check in startup section of `.zshrc`.

### Aliases
Add custom aliases in appropriate sections of `.zshrc` or `.bashrc`.

### Functions
Modify or add functions in `.zshrc` function section.

### Vim Settings
Edit `.vimrc` for vim customization.

## Terminal Requirements

- **256-color support** (minimum) or **true color** (preferred)
- **UTF-8 encoding** (for box-drawing characters)
- **Modern terminal emulator** (supports true color and UTF-8)

## Performance Considerations

- History size (50k) may impact startup time on slow systems
- VCS info check runs on every prompt (may be slow in large repos)
- Zellij auto-start adds minimal overhead
- Neofetch adds ~100-200ms to startup

## Troubleshooting

### Prompt not displaying correctly
- Check terminal supports UTF-8
- Verify color support: `echo $TERM`
- Test box-drawing: `echo "┌─┐"`

### Colors not working
- Check `$TERM` variable
- Verify terminal supports 256-color or true color
- Test: `echo -e "\033[38;5;82mTest\033[0m"`

### Zellij not starting
- Check if Zellij is installed: `which zellij`
- Verify not already in session: `echo $ZELLIJ`
- Check if in VS Code: `echo $TERM_PROGRAM`

### Git info not showing
- Verify in Git repository: `git rev-parse --is-inside-work-tree`
- Check VCS info is enabled: `zstyle -L ':vcs_info:*'`

