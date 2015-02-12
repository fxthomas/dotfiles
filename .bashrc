# Source common profile settings
source ~/.profile

# Don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups
# ... and ignore same sucessive entries.
export HISTCONTROL=ignoreboth

# Check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

# Enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if type brew >/dev/null 2>&1; then
  if [ -f `brew --prefix`/etc/bash_completion ]; then
    . `brew --prefix`/etc/bash_completion
  fi
fi

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
