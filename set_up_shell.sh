#!/bin/bash

# This script installs QoL tools to our shell, such as zsh, oh-my-zsh, powerline-shell and more.
# Precondition: DOTFILES_DIR must be set and exist.

# Update packages first
sudo yum update -y

# Install zsh
sudo yum install zsh -y
# Install "util-linux-user" because "chsh" is not available by default. See https://superuser.com/a/1389273/599050
sudo yum install util-linux-user -y
# Set the default shell to zsh
sudo chsh -s $(which zsh) $(whoami)

# Install oh-my-zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "Installing oh-my-zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
  echo "oh-my-zsh is already installed."
fi

# Install powerline-shell font "Meslo Slashed"
clone_or_update https://github.com/powerline/fonts.git --depth=1
cd fonts
# This script uses a string argument to look for font with prefixes with the given string
./install.sh "Meslo LG"
cd ..
rm -rf fonts

# Install powerline-shell
clone_or_update https://github.com/b-ryan/powerline-shell.git --depth=1
cd powerline-shell
sudo python3 setup.py install
cd ..
sudo rm -rf powerline-shell

# Set up powerline-shell segment
mkdir -p $HOME/.config/powerline-shell/
ln -sf $DOTFILES_DIR/powerline-shell-config.json $HOME/.config/powerline-shell/config.json

clone_or_update "https://github.com/zsh-users/zsh-syntax-highlighting.git" "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"
clone_or_update "https://github.com/zsh-users/zsh-autosuggestions" "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"

source ~/.zshrc
