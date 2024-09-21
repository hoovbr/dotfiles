#!/bin/bash

# This script installs QoL tools to our shell, such as zsh, oh-my-zsh, powerline-shell and more.
# Precondition: DOTFILES_DIR must be set and exist.

function print_change_shell_troubleshooting() {
  echo "❗️ Looks like you had issues running chsh to change the default shell to zsh."
  echo "Try running the following command manually:"
  echo
  echo "sudo chsh -s $(which zsh) $(whoami)"
  echo
  echo "If it still doesn't work, try running the following command:"
  echo
  echo "sudo nano /etc/default/useradd"
  echo
  echo "And edit the line that says 'SHELL=/bin/sh' to say 'SHELL=$(which zsh)' instead."
  echo "This will ensure all the new users created will have zsh as their default shell."
  echo "To change the default shell of the existing users, run the following command:"
  echo
  echo "sudo nano /etc/passwd"
  echo
  echo "And find the users you want to edit this setting, and modify the last component of their line to say $(which zsh) instead of /bin/sh."
  echo
  echo "I hope this helps! 👋"
}

# Update packages first
package_manager update -y || true # Ignore failures

# Install zsh
package_manager install zsh -y

# On Debian-based systems, 'util-linux-user' is not required as 'chsh' is typically available by default
if ! command -v chsh >/dev/null 2>&1; then
  package_manager install util-linux-user -y
fi

# Set the default shell to zsh
sudo chsh -s $(which zsh) $(whoami) || print_change_shell_troubleshooting

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
package_manager install python3-setuptools -y
sudo python3 setup.py install -y
cd ..
sudo rm -rf powerline-shell

# Set up powerline-shell segment
mkdir -p $HOME/.config/powerline-shell/
ln -sf $DOTFILES_DIR/powerline-shell-config.json $HOME/.config/powerline-shell/config.json

clone_or_update "https://github.com/zsh-users/zsh-syntax-highlighting.git" "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"
clone_or_update "https://github.com/zsh-users/zsh-autosuggestions" "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
