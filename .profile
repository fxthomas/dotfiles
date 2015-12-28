# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# Editor is VIM
export EDITOR=$(which vim)

# Add standard system paths
# export PATH="/usr/local/bin/:/usr/bin:/bin:/usr/sbin:/sbin:/usr/X11/bin:/usr/local/sbin/:$PATH"

# Add standard user paths
if [ -d "$HOME/bin" ]; then PATH="$HOME/bin:$PATH"; fi
if [ -d "$HOME/.local/bin" ]; then PATH="$HOME/.local/bin:$PATH"; fi
if [ -d "$HOME/Scripts" ]; then PATH="$HOME/Scripts:$PATH"; fi
if [ -d "$HOME/.local/lib/python2.7" ]; then export PYTHONUSERBASE="$HOME/.local"; fi
if [ -d "$HOME/.gem/ruby/2.2.0/bin" ]; then PATH="$HOME/.gem/ruby/2.2.0/bin:$PATH"; fi

# Set the GOPATH to ~/.local
export GOPATH="$HOME/.local"

# Add Android tools to the PATH
export ANDROID_HOME="/opt/android-sdk/"
export PATH=$ANDROID_HOME/tools:$PATH
export PATH=$ANDROID_HOME/build-tools/17.0.0:$PATH
export PATH=$ANDROID_HOME/platform-tools:$PATH

# Add Android studio to the path
export PATH="/opt/android-studio/bin/:$PATH"

# Add RVM to PATH for scripting
if [ -d "$HOME/.rvm/bin" ]; then PATH="$HOME/.rvm/bin:$PATH"; fi
if [ -x "$HOME/.rvm/scripts/rvm" ]; then source ~/.rvm/scripts/rvm; fi

# Add aliases
if [ -f $HOME/.aliases ]; then source $HOME/.aliases; fi
