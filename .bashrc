
##
# Your previous /Users/fx/.bash_profile file was backed up as /Users/fx/.bash_profile.macports-saved_2011-09-28_at_15:06:02
##
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export PAGER=/usr/local/bin/most
export NODE_PATH=/usr/local/lib/node_modules
export PYTHONPATH="/usr/local/lib/python2.7/site-packages:$PYTHONPATH"
export PATH=/Users/fx/Scripts:/usr/local/sbin/:/Applications/Xcode.app/Contents/Developer/usr/bin/:/usr/local/opt/i2p/:/Users/fx/.cabal/bin/:$PATH

# Don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups
# ... and ignore same sucessive entries.
export HISTCONTROL=ignoreboth

# Check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Enable color support of ls
if [ "$TERM" != "dumb" ]; then
    alias ls='ls -h -G'
fi

# Enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if type brew >/dev/null 2>&1; then
  if [ -f `brew --prefix`/etc/bash_completion ]; then
    . `brew --prefix`/etc/bash_completion
  fi
fi

# Set vi-style command line editing
#set -o vi

# Set VIM as the default editor
export EDITOR="vim"

# Set prompt variables
# From: http://www.jonmaddox.com/2008/03/13/show-your-git-branch-name-in-your-prompt/
function setPromptVars {
  P_GITBRANCH=$(git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/' -e 's/^/[git:/' -e 's/$/]/')
  P_HGTIP=$(hg branch 2> /dev/null | sed -e 's/^/[hg:/' -e 's/$/]/')
}

# Set prompt
function setPromptText {
  local     RETCODE=$?
  local      YELLOW="\[\033[0;33m\]"
  local        BLUE="\[\033[0;34m\]"
  local  LIGHT_BLUE="\[\033[0;36m\]"
  local         RED="\[\033[0;31m\]"
  local   LIGHT_RED="\[\033[1;31m\]"
  local       GREEN="\[\033[0;32m\]"
  local LIGHT_GREEN="\[\033[1;32m\]"
  local       WHITE="\[\033[1;37m\]"
  local  LIGHT_GRAY="\[\033[0;37m\]"
  local      NORMAL="\[\033[0m\]"
  case $TERM in
    xterm*)
    TITLEBAR='\[\033]0;\u@\h:\w\007\]'
    ;;
    *)
    TITLEBAR=""
    ;;
  esac

  local P_USER="\u"
  local P_HOST="\h"
  local P_DATE="\d"
  local P_TIME="\t"
  local P_PWD="\w"
  local P_COUNT="\#"
  local P_RETCODE=""
  if [ $RETCODE -ne 0 ]; then
    P_RETCODE="[$RETCODE]"
  fi

  setPromptVars

  PS1="$LIGHT_BLUE${P_USER}$GREEN@$RED${P_HOST}$YELLOW${P_GITBRANCH}${P_HGTIP}$GREEN [${P_DATE}/${P_TIME}] [${P_PWD}] [${P_COUNT}] $RED${P_RETCODE}$NORMAL\n"
  PS2='> '
  PS4='+ '
}

# Set 'setPromptText' to be executed on each new prompt
# See: http://tldp.org/HOWTO/Bash-Prompt-HOWTO/x264.html
export PROMPT_COMMAND=setPromptText
