#!/bin/bash

################################################################################
### Set up everything in the correct order
################################################################################

# Make the clone_or_update function available
bash <(curl -s https://raw.githubusercontent.com/hoovbr/dotfiles/main/.aliases)

clone_or_update "https://github.com/hoovbr/dotfiles.git" "$HOME/.dotfiles"
cd $HOME/.dotfiles

source set_up_symlinks.sh
source set_up_shell.sh
source set_up_dependencies.sh
