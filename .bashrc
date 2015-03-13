# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace:erasedups

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=100000
HISTFILESIZE=200000

# Save and reload the history after each command finishes
# export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# * expansion fails whole command if it doesn't match anything
shopt -s failglob

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
  # We have color support; assume it's compliant with Ecma-48
  # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
  # a case would tend to support setf rather than setaf.)
  color_prompt=yes
    else
  color_prompt=
    fi
fi

_PS1 ()
{
    local PRE= NAME="$1" LENGTH="$2";
    [[ "$NAME" != "${NAME#$HOME/}" || -z "${NAME#$HOME}" ]] &&
        PRE+='~' NAME="${NAME#$HOME}" LENGTH=$[LENGTH-1];
    ((${#NAME}>$LENGTH)) && NAME="/...${NAME:$[${#NAME}-LENGTH+4]}";
    echo "$PRE$NAME"
}

if [ "$color_prompt" = yes ]; then
    PS1='\n[\u@\h \W$(__git_ps1 " (%s)")]\$ '
    PS1='\n${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]$(__git_ps1 "(%s)")\$ '
    PROMPT_DIRTRIM=2 # \w magic on bash 4+, for 3+ we instead need to use the above helper
    PS1='\n${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u\[\033[00m\]:\[\033[01;34m\]$(_PS1 "$PWD" 100)\[\033[00m\]$(__git_ps1 "(%s)")\$ '
else
    PS1='\n${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

if [ -f ~/.bash_functions ]; then
    . ~/.bash_functions
fi

if [ -f ~/.bash_hacks ]; then
    . ~/.bash_hacks
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

GIT_COMPLETION_DIR=/usr/local/git/current/share/git-core/

if [ -f $GIT_COMPLETION_DIR/git-completion.bash ]; then
  . $GIT_COMPLETION_DIR/git-completion.bash
fi

if [ -f $GIT_COMPLETION_DIR/git-prompt.sh ]; then
  . $GIT_COMPLETION_DIR/git-prompt.sh
  export GIT_PS1_SHOWDIRTYSTATE=true
fi

if [ -f ~/.cordova.completion ]; then
  . ~/.cordova.completion
fi

if [ -f ~/dev/ext/hub/etc/hub.bash_completion.sh ]; then
  . ~/dev/ext/hub/etc/hub.bash_completion.sh
fi

[ -s $HOME/.nvm/nvm.sh ] && . $HOME/.nvm/nvm.sh # This loads NVM

################################################################################

# bind "set completion-ignore-case on"

################################################################################

export EDITOR=vim

shopt -s globstar

################################################################################

# The next line updates PATH for the Google Cloud SDK.
source "${HOME}/dev/ext/google-cloud-sdk/path.bash.inc"

# The next line enables bash completion for gcloud.
source "${HOME}/dev/ext/google-cloud-sdk/completion.bash.inc"

################################################################################

source $HOME/.bagpipe/setup.sh $HOME/.bagpipe tommy.hot.corp.google.com

################################################################################

export DART_SDK="${HOME}/opt/dart-sdk"

export PATH="${HOME}/bin:${PATH}"

export PATH="${PATH}:/Applications/Xcode.app/Contents/Developer/usr/bin"
#export PATH="${PATH}:${HOME}/opt/adt-bundle-mac-x86_64-20131030/sdk/tools"
#export PATH="${PATH}:${HOME}/opt/adt-bundle-mac-x86_64-20131030/sdk/platform-tools"
#export PATH="${PATH}:${HOME}/opt/apache-ant-1.9.3/bin"
export PATH="${PATH}:${HOME}/dev/depot_tools"
export PATH="${PATH}:{$DART_SDK}/bin"

export ANDROID_HOME="${HOME}/Library/Android/sdk"
export PATH="${PATH}:${ANDROID_HOME}/tools"
export PATH="${PATH}:${ANDROID_HOME}/platform-tools"

# After installing brew coreutil
export PATH="/usr/local/opt/coreutils/libexec/gnubin:${PATH}"
export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"

export HISTTIMEFORMAT="%d/%m/%y %T "

export P4EDITOR=vim
