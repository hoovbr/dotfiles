#!/bin/bash

################################################################################
### Set up symbolic links
################################################################################

# DOTFILES_DIR may have not been initialized yet, if this is the first time setting up .zshrc
source .exports

ln -sf $DOTFILES_DIR/.aliases $HOME/.aliases
ln -sf $DOTFILES_DIR/.exports $HOME/.exports
ln -sf $DOTFILES_DIR/.gemrc $HOME/.gemrc
ln -sf $DOTFILES_DIR/.paths $HOME/.paths
ln -sf $DOTFILES_DIR/.ruby-version $HOME/.ruby-version
ln -sf $DOTFILES_DIR/.zshrc $HOME/.zshrc

mkdir -p $HOME/.config/powerline-shell
ln -sf $DOTFILES_DIR/powerline-shell-config.json $HOME/.config/powerline-shell/config.json
