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
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# Install powerline-shell font "Meslo Slashed"
git clone https://github.com/powerline/fonts.git --depth=1
cd fonts
# This script uses a string argument to look for font with prefixes with the given string
./install.sh "Meslo LG"
cd ..
rm -rf fonts

# Install powerline-shell
git clone https://github.com/b-ryan/powerline-shell.git --depth=1
cd powerline-shell
sudo python3 setup.py install
cd ..
sudo rm -rf powerline-shell

# Set up powerline-shell segment
mkdir -p $HOME/.config/powerline-shell/
ln -s $DOTFILES_DIR/powerline-shell-config.json $HOME/.config/powerline-shell/config.json

function clone_or_update() {
  # Check if the repository directory already exists
  repo_url="$1"
  repo_dir="$2"
  if [ -d "$repo_dir" ]; then
    echo "Repository for '$repo_dir' already exists. Updating it…"
    (cd "$repo_dir" && git fetch && git pull)
    echo "Repository updated successfully."
  else
    echo "Cloning the repository…"
    git clone "$repo_url" "$repo_dir"
    echo "Repository cloned successfully."
  fi
}

clone_or_update "https://github.com/zsh-users/zsh-syntax-highlighting.git" "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"
clone_or_update "https://github.com/zsh-users/zsh-autosuggestions" "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"

source ~/.zshrc
