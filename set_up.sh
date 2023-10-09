#!/bin/bash

################################################################################
### Set up everything in the correct order
################################################################################

git clone https://github.com/hoovbr/dotfiles.git $HOME/.dotfiles
cd $HOME/.dotfiles

source set_up_symlinks.sh
source set_up_shell.sh
source set_up_dependencies.sh
