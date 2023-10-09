# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="agnoster"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Format to display history timestamps
# See 'man strftime' for details.
HIST_STAMPS="%Y/%m/%d %k:%M"

# Plugins

BUNDLED_COMMANDS=(
  rubocop
)

# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  bundler
  git
  rails
  z
  zsh-autosuggestions
  zsh-syntax-highlighting
)

# Fixes a warning when initializing zsh that can be safely silented.
# See https://github.com/ohmyzsh/ohmyzsh/issues/6835#issuecomment-390216875
ZSH_DISABLE_COMPFIX=true

if [ -f $ZSH/oh-my-zsh.sh ]; then
  source $ZSH/oh-my-zsh.sh
fi

################################################################################
# Exports
################################################################################

if [ -f "$HOME/.exports" ]; then
  source "$HOME/.exports"
fi

if [ -f "$HOME/.paths" ]; then
  source "$HOME/.paths"
fi

################################################################################
# Aliases
################################################################################

if [ -f "$HOME/.aliases" ]; then
  source "$HOME/.aliases"
fi

################################################################################
# User configuration
################################################################################

# Run Powerline Shell
function powerline_precmd() {
  if which powerline-shell > /dev/null; then
    PS1="$(powerline-shell --shell zsh $?)"
  fi
}

function install_powerline_precmd() {
  for s in "${precmd_functions[@]}"; do
    if [ "$s" = "powerline_precmd" ]; then
      return
    fi
  done
  precmd_functions+=(powerline_precmd)
}

if [ "$TERM" != "linux" ]; then
  install_powerline_precmd
fi

# Initialize rbenv if it's already installed
if [ -f "$HOME/.rbenv/bin/rbenv" ]; then
  eval "$($HOME/.rbenv/bin/rbenv init - zsh)"
fi

# Initialize Homebrew if it's already installed
if [ -f "~/.linuxbrew/bin/brew" ]; then
  eval $(~/.linuxbrew/bin/brew shellenv)
fi
