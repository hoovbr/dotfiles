#!/usr/bin/zsh

################################################################################
### Install Dependencies
################################################################################

set -e # Immediately rethrows exceptions

echo " 📦 Updating packages"
sudo yum update -y
echo " ✅ Updated packages successfully!"

echo " 📦 Installing rbenv"
clone_or_update https://github.com/rbenv/rbenv.git ~/.rbenv
echo " ✅ rbenv installed successfully!"

# We need to source .zshrc again to apply changes after isntalling rbenv
source ~/.zshrc

echo " 📦 Installing Ruby"

RUBY_VERSION="$(cat $HOME/.ruby-version)"
rbenv install
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

source ~/.zshrc
