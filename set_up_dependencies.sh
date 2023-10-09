#!/bin/zsh

################################################################################
### Install Dependencies
################################################################################

set -e # Immediately rethrows exceptions

echo " 📦 Updating packages"
sudo yum update -y
echo " ✅ Updated packages successfully!"

echo " 📦 Installing rbenv"
# These are rbenv dependencies
sudo yum install git gcc make readline-devel openssl-devel libyaml-devel -y
clone_or_update https://github.com/rbenv/rbenv.git ~/.rbenv
eval "$($HOME/.rbenv/bin/rbenv init - zsh)"
# Install ruby-build as an rbenv plugin
clone_or_update https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build
echo " ✅ rbenv installed successfully!"

echo " 📦 Installing Ruby"
RUBY_VERSION="$(cat $HOME/.ruby-version)"
rbenv install --skip-existing
rbenv global $RUBY_VERSION
echo " ✅ Ruby $RUBY_VERSION installed successfully!"

echo " 📦 Installing Postgres"
sudo amazon-linux-extras install epel -y
sudo amazon-linux-extras install postgresql14 -y # Should be the same version we're using in the RDS
echo " ✅ Postgres installed successfully!"

echo " 📦 Installing Redis"
sudo amazon-linux-extras install redis6 -y
echo " ✅ Redis installed successfully!"

echo " 📦 Installing hub"
sudo yum install hub -y
echo " ✅ hub installed successfully!"
