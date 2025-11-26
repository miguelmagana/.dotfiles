# Hacker/Bug Bounty Optimized Dotfiles

Custom dotfiles optimized for penetration testing and bug bounty hunting. Features a custom two-line prompt with box-drawing borders, comprehensive aliases, and integration with Zellij terminal multiplexer.

## Features

- **Custom Two-Line Prompt**: Inspired by robbyrussell, jonathan, duellj, and nanotech themes
  - Box-drawing borders with information spread across terminal width
  - Git branch and status indicators
  - Exit code indicators
  - Timestamp display
  - Cannabis green (#098009) ASCII handle on startup

- **Large History**: 50,000 entries for long tool outputs

- **Comprehensive Aliases**: 50+ aliases for:
  - Navigation (.., ..., ...., .....)
  - Standard Linux commands
  - Git operations
  - Penetration testing tools (nmap, gobuster, sqlmap, etc.)

- **Zellij Integration**: Auto-starts Zellij terminal multiplexer

- **System Information**: Displays neofetch on terminal startup

- **Optimized Vim Configuration**: Enhanced vim settings for efficient editing

- **Bash Fallback**: Enhanced .bashrc for systems without Zsh

## Requirements

- Debian/Ubuntu Linux
- Terminal with 256-color support (or true color)
- UTF-8 encoding support (for box-drawing characters)

## Installation

1. Clone this repository:
   ```bash
   git clone <your-repo-url> ~/dotfiles
   cd ~/dotfiles
   ```

2. Make the installation script executable:
   ```bash
   chmod +x install.sh
   ```

3. Run the installation script:
   ```bash
   ./install.sh
   ```

The script will:
- Backup your existing dotfiles
- Create symlinks to the new dotfiles
- Install dependencies (zsh, zellij, neofetch)
- Optionally set zsh as default shell

4. Apply the changes:
   ```bash
   source ~/.zshrc
   ```

Or simply restart your terminal.

## Uninstallation

To revert to your original settings:

1. Run the uninstallation script:
   ```bash
   chmod +x uninstall.sh
   ./uninstall.sh
   ```

2. Apply the restored configuration:
   ```bash
   source ~/.zshrc
   source ~/.bashrc
   ```

## Dependencies

### Required (installed automatically):
- **zsh**: Shell
- **zellij**: Terminal multiplexer
- **neofetch**: System information display

### Optional (for aliases to work):
- git (version control)
- nmap (network scanning)
- gobuster (directory enumeration)
- sqlmap (SQL injection testing)
- nikto (web vulnerability scanning)

## Customization

### Prompt Colors
Edit `.zshrc` to customize prompt colors:
- Cyan: User@Host, Box borders
- Blue: Directory path
- Magenta: Git branch name
- Red: Git unstaged changes, Exit code (on error)
- Green: Git staged changes, Exit code (success), Prompt symbol
- Yellow: Timestamp
- Cannabis Green (#098009): ASCII handle

### Aliases
Add custom aliases in `.zshrc` or `.bashrc` in the appropriate alias section.

### Vim Configuration
Edit `.vimrc` to customize vim settings.

## File Structure

```
.dotfiles/
├── .zshrc              # Main Zsh configuration
├── .bashrc             # Bash fallback configuration
├── .vimrc              # Vim configuration
├── .gitconfig          # Git configuration
├── install.sh          # Installation script
├── uninstall.sh        # Uninstallation script
├── README.md           # This file
├── ALIASES.md          # Alias cheat sheet
└── ARCHITECTURE.md     # Technical documentation
```

## Prompt Structure

```
┌─ user@host /path/to/dir (main*) [✓] ──────────────────────────── 14:30:25 ─┐
└─ % 
```

**Line 1 Components:**
- `┌─` (cyan border)
- `user@host` (cyan)
- `/path/to/dir` (blue, shortened if >35 chars)
- `(main*)` (magenta branch, red unstaged, green staged)
- `[✓]` (green on success, red ✗ on failure)
- `─` (cyan separator, fills remaining width)
- `14:30:25` (yellow timestamp)
- `─┐` (cyan border)

**Line 2:**
- `└─` (cyan border)
- `%` or `#` (green prompt symbol)

## See Also

- [ALIASES.md](ALIASES.md) - Complete alias reference
- [ARCHITECTURE.md](ARCHITECTURE.md) - Technical documentation

## License

This configuration is provided as-is for personal use.

