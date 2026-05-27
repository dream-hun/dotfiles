# Jacques's Dotfiles

Originally forked from [Christoph Rumpel](https://github.com/christophrumpel/dotfiles), adapted for Ubuntu Linux.

## System

- **OS:** Ubuntu 26.04 LTS (Resolute Raccoon)
- **Shell:** Zsh + Oh My Zsh
- **Prompt:** Starship
- **Terminal:** Ghostty
- **Package manager:** Homebrew (Linuxbrew)
- **Node:** NVM
- **PHP:** Linuxbrew + Composer

## Backup Checklist

- Did you commit and push any changes/branches to your git repositories?
- Did you copy your `.env` files to a safe place?
- Did you backup your IDE settings? (e.g. PhpStorm / JetBrains)
- Did you backup local databases you need?
- Did you remember to save all important documents from non-cloud directories?
- Did you save all of your work from apps which aren't synced through cloud?

## Installation

1. **Update Ubuntu** to the latest version
    ```zsh
    sudo apt update && sudo apt upgrade
    ```
2. **Install Zsh and Oh My Zsh**
    ```zsh
    sudo apt install zsh
    chsh -s $(which zsh)
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    ```
3. **Install zsh-autosuggestions plugin**
    ```zsh
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    ```
4. **Clone dotfiles** to `~/.dotfiles`
    ```zsh
    git clone https://github.com/mbabazijacques/dotfiles.git ~/.dotfiles
    ```
5. **Run installation script**
    ```zsh
    ~/.dotfiles/install.sh
    ```
6. **Install Ghostty** (if not already installed)
    ```zsh
    sudo snap install ghostty --classic
    ```
7. **Set up SSH keys** — copy your SSH config to `~/.ssh/config`
8. **Restart your terminal** to finalize the process

## Additional Steps

- Install apps manually
    - PhpStorm (JetBrains Toolbox: https://www.jetbrains.com/toolbox-app/)
    - TablePlus (https://tableplus.com/linux)
- Custom Settings
    - PhpStorm: enable settings sync or restore from backup
- Fonts
    - Install FiraCode Nerd Font (used by Ghostty config):
        ```zsh
        sudo apt install fonts-firacode
        ```
        Or download the Nerd Font variant from https://www.nerdfonts.com/font-downloads

## What Each File Does

| File | Purpose |
|------|---------|
| `zshrc` | Main Zsh config — symlinked to `~/.zshrc` |
| `aliases.zsh` | Shell aliases — auto-loaded by Oh My Zsh custom |
| `path.zsh` | PATH exports — auto-loaded by Oh My Zsh custom |
| `starship.toml` | Starship prompt config — symlinked to `~/.config/starship.toml` |
| `ghostty.conf` | Ghostty terminal config — symlinked to `~/.config/ghostty/config` |
| `Brewfile.linux` | Homebrew CLI packages for Linux |
| `install.sh` | Bootstrap script for a new Ubuntu machine |
| `clone.sh` | Clone personal project repos after install |
