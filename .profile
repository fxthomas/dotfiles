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
if [ -d "/opt/android-sdk" ]; then export ANDROID_PREFIX="/opt"
elif [ -d "$HOME/.local/opt/android-sdk" ]; then export ANDROID_PREFIX="$HOME/.local/opt"; fi
if [ -n "$ANDROID_PREFIX" ];
then
  export ANDROID_HOME="$ANDROID_PREFIX/android-sdk/"
  export PATH="$ANDROID_HOME/tools:$PATH"
  export PATH="$ANDROID_HOME/tools/bin:$PATH"
  export PATH="$ANDROID_HOME/build-tools/17.0.0:$PATH"
  export PATH="$ANDROID_HOME/platform-tools:$PATH"
  export PATH="$ANDROID_PREFIX/android-studio/bin/:$PATH"
fi

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

# Add aliases and local profile
if [ -f $HOME/.aliases ]; then source $HOME/.aliases; fi
if [ -f $HOME/.profile_local ]; then source $HOME/.profile_local; fi

# Hack to make Digikam icons work properly
# See: https://wiki.archlinux.org/index.php/Digikam
export QT_QPA_PLATFORMTHEME="qt5ct"

# Added by travis gem
[ -f /home/fx/.travis/travis.sh ] && source /home/fx/.travis/travis.sh
