#!/bin/bash

################################################################################
### Set up everything in the correct order
################################################################################

set -e # Immediately rethrows exceptions

# Install system updates in the EC2 machine
sudo yum update -y
# Install git
sudo yum install git -y

# Make the clone_or_update function available
source <(curl -s https://raw.githubusercontent.com/hoovbr/dotfiles/main/.aliases)

clone_or_update "https://github.com/hoovbr/dotfiles.git" "$HOME/.dotfiles"
cd $HOME/.dotfiles

source set_up_symlinks.sh
source set_up_shell.sh
source set_up_dependencies.sh

echo " ✅ Everything set up successfully!"
