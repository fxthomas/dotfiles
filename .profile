# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# Editor is VIM
export EDITOR=vim

# Add my standard user paths
if [ -d "$HOME/bin" ]; then PATH="$HOME/bin:$PATH"; fi
if [ -d "$HOME/Scripts" ]; then PATH="$HOME/Scripts:$PATH"; fi

# Add Android tools to the PATH
export ANDROID_HOME="/opt/android-sdk/"
export PATH=$ANDROID_HOME/tools:$PATH
export PATH=$ANDROID_HOME/build-tools/17.0.0:$PATH
export PATH=$ANDROID_HOME/platform-tools:$PATH
export PATH="/opt/android-studio/bin/:$PATH"

# Setup local Python packages
mkdir -p "$HOME/.local/lib"
mkdir -p "$HOME/.local/bin"
export PYTHONUSERBASE="$HOME/.local"
export PATH="$HOME/.local/bin:$PATH"

# Setup local Python startup script
if [ -f "$HOME/.python.py" ]; then export PYTHONSTARTUP="$HOME/.python.py"; fi

# Setup local Ruby gems
if [ -x "$HOME/.rvm/scripts/rvm" ]; then source ~/.rvm/scripts/rvm; fi
if [ -d "$HOME/.gem/ruby" ]; then for p in "$HOME/.gem/ruby"/*; do PATH="$p/bin:$PATH"; done; fi
export PATH="$HOME/.rvm/bin:$PATH"

# Setup local Go packages
export GOPATH="$HOME/.local"

# Setup local NPM packages
export PATH="$HOME/.npm/bin:$PATH"

# Add aliases
if [ -f $HOME/.aliases ]; then source $HOME/.aliases; fi

# Hack to make Digikam icons work properly
# See: https://wiki.archlinux.org/index.php/Digikam
export QT_QPA_PLATFORMTHEME="qt5ct"

# Added by travis gem
[ -f /home/fx/.travis/travis.sh ] && source /home/fx/.travis/travis.sh
