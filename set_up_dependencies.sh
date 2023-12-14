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
rbenv install --skip-existing
rbenv global $RUBY_VERSION
echo " ✅ Ruby $RUBY_VERSION installed successfully!"

echo " 📦 Installing hub"
package_manager install hub -y
echo " ✅ hub installed successfully!"

echo " 📦 Installing Postgres"
if command -v amazon-linux-extras >/dev/null 2>&1; then
  sudo amazon-linux-extras install epel -y
  sudo amazon-linux-extras install postgresql14 -y # Should be the same version we're using in the RDS
elif command -v apt-get >/dev/null 2>&1; then
  sudo apt-get install postgresql postgresql-contrib
else
  echo "Error: neither amazon-linux-extras nor apt-get is available, so Postgres couldn't be installed." >&2
  exit 1
fi
echo " ✅ Postgres installed successfully!"

echo " 📦 Installing Redis"
if command -v amazon-linux-extras >/dev/null 2>&1; then
  sudo amazon-linux-extras install redis6 -y
elif command -v apt-get >/dev/null 2>&1; then
  sudo apt-get install redis-server -y
else
  echo "Error: neither amazon-linux-extras nor apt-get is available, so Redis couldn't be installed." >&2
  exit 1
fi
echo " ✅ Redis installed successfully!"
