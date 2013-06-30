# Set locale
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="fx"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins+=(git django virtualenvwrapper)

# Add standard system paths
export PATH=/usr/local/bin/:/usr/bin:/bin:/usr/sbin:/sbin:/usr/X11/bin:/usr/local/sbin/:$PATH

# Add my scripts
export PATH=$HOME/Scripts:$PATH

# Editor is VIM
export EDITOR=$(which vim)

# Run custom script
if [[ -e $HOME/.zshrc_before ]]; then source $HOME/.zshrc_before; fi

# Run oh-my-zsh
source $ZSH/oh-my-zsh.sh

# Display MotD
if [[ -e $HOME/.motd ]]; then cat $HOME/.motd; fi

# Run custom script
if [[ -e $HOME/.zshrc_after ]]; then source $HOME/.zshrc_after; fi

# Setup aliases
if [[ -e $HOME/.zshrc_aliases ]]; then source $HOME/.zshrc_aliases; fi

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting