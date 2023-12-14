#!/bin/bash

################################################################################
### Set up everything in the correct order
################################################################################

set -e # Immediately rethrows exceptions

# Make the some utility functions available
source <(curl -s https://raw.githubusercontent.com/hoovbr/dotfiles/main/.aliases)

# Update the list of packages and install git if needed
package_manager update -y || true # Ignore failures
package_manager install git -y

clone_or_update "https://github.com/hoovbr/dotfiles.git" "$HOME/.dotfiles"
cd $HOME/.dotfiles

source set_up_symlinks.sh
source set_up_shell.sh
source set_up_dependencies.sh

echo " ✅ Everything set up successfully!"
