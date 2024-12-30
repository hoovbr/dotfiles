#!/bin/zsh

################################################################################
### Install Dependencies
################################################################################

set -e # Immediately rethrows exceptions

echo " 📦 Updating packages"
package_manager update -y || true # Ignore failures
echo " ✅ Updated packages successfully!"

echo " 📦 Installing rbenv"
# These are rbenv dependencies
package_manager install git gcc make libreadline-dev libssl-dev libyaml-dev -y
clone_or_update https://github.com/rbenv/rbenv.git ~/.rbenv
eval "$($HOME/.rbenv/bin/rbenv init - zsh)"
# Install ruby-build as an rbenv plugin
clone_or_update https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build
echo " ✅ rbenv installed successfully!"

echo " 📦 Installing Ruby"
RUBY_VERSION="$(cat $HOME/.ruby-version)"
rbenv install --skip-existing -y
rbenv global $RUBY_VERSION
echo " ✅ Ruby $RUBY_VERSION installed successfully!"

echo " 📦 Installing hub"
package_manager install hub -y
echo " ✅ hub installed successfully!"

sudo apt-get update
sudo apt-get install docker.io docker-compose certbot python3-certbot-dns-route53 awscli
sudo systemctl start docker
sudo systemctl enable docker

# If a nginx machine was set up, this was started by default. Let's stop this because we use our own dockerized nginx instance.
sudo systemctl stop nginx
