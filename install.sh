#!/bin/sh

echo "Setting up your Ubuntu system..."

# Ask for the administrator password upfront
echo "We need your password for some installation steps..."
sudo -v

# Keep sudo alive until script finishes
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

DOTFILES="$HOME/.dotfiles"

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
# Starship prompt
#-----------------------------------------------------------------------------------#

echo "Installing Starship..."
if command -v starship > /dev/null 2>&1; then
    echo "Starship is already installed"
else
    sudo mkdir -p /usr/local/bin
    if curl -sS https://starship.rs/install.sh | sh; then
        echo "Starship installed successfully"
    else
        echo "Failed to install Starship" >&2
        exit 1
    fi
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

# Starship config
mkdir -p "$HOME/.config"
ln -sf "$DOTFILES/starship.toml" "$HOME/.config/starship.toml"
echo "Linked starship.toml"

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
mkdir -p "$HOME/Sites/Tests"
mkdir -p "$HOME/Sites/Packages"
mkdir -p "$HOME/Sites/Forks"

echo ""
echo "Done! Restart your terminal (Ghostty) to apply all changes."
