#!/bin/sh

echo "Setting up your Ubuntu system..."

# Ask for the administrator password upfront
echo "We need your password for some installation steps..."
sudo -v

# Keep sudo alive until script finishes
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

DOTFILES="$(cd "$(dirname "$0")" && pwd)"

#-----------------------------------------------------------------------------------#
# Homebrew (Linuxbrew)
#-----------------------------------------------------------------------------------#

echo "Checking Homebrew..."
if test ! $(which brew); then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> "$HOME/.zprofile"
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
else
    echo "Homebrew already installed"
fi

#-----------------------------------------------------------------------------------#
# Spaceship ZSH theme
#-----------------------------------------------------------------------------------#

echo "Installing Spaceship ZSH theme..."
SPACESHIP_DIR="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/spaceship-prompt"
if [ -d "$SPACESHIP_DIR" ]; then
    echo "Spaceship already installed"
else
    git clone --depth=1 https://github.com/spaceship-prompt/spaceship-prompt.git "$SPACESHIP_DIR"
    ln -sf "$SPACESHIP_DIR/spaceship.zsh-theme" "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/spaceship.zsh-theme"
    echo "Spaceship installed"
fi

#-----------------------------------------------------------------------------------#
# NVM
#-----------------------------------------------------------------------------------#

echo "Checking NVM..."
if [ ! -d "$HOME/.nvm" ]; then
    echo "Installing NVM..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
else
    echo "NVM already installed"
fi

#-----------------------------------------------------------------------------------#
# Symlinks
#-----------------------------------------------------------------------------------#

echo "Setting up symlinks..."

# ~/.zshrc
rm -rf "$HOME/.zshrc"
ln -s "$DOTFILES/zshrc" "$HOME/.zshrc"
echo "Linked .zshrc"

# Oh My Zsh custom — aliases and path loaded automatically by OMZ
ln -sf "$DOTFILES/aliases.zsh" "$HOME/.oh-my-zsh/custom/aliases.zsh"
ln -sf "$DOTFILES/path.zsh" "$HOME/.oh-my-zsh/custom/path.zsh"
echo "Linked Oh My Zsh custom files"

# Ghostty config
mkdir -p "$HOME/.config/ghostty"
ln -sf "$DOTFILES/ghostty.conf" "$HOME/.config/ghostty/config"
echo "Linked Ghostty config"

#-----------------------------------------------------------------------------------#
# Homebrew packages (CLI tools only)
#-----------------------------------------------------------------------------------#

echo "Installing Homebrew packages..."
brew bundle --file "$DOTFILES/Brewfile.linux"

#-----------------------------------------------------------------------------------#
# Misc
#-----------------------------------------------------------------------------------#

# Disable "Last login" message
[ ! -f "$HOME/.hushlogin" ] && touch "$HOME/.hushlogin"

# Create Sites directories
mkdir -p "$HOME/Sites/Ui"
mkdir -p "$HOME/Sites/Packages"
mkdir -p "$HOME/Sites/Forks"

echo ""
echo "Done! Restart your terminal (Ghostty) to apply all changes."
