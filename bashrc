# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# ... or force ignoredups and ignorespace
export HISTCONTROL=ignoreboth:erasedups

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
export HISTFILESIZE=20000
export HISTSIZE=20000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

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

if [ "$color_prompt" = yes ]; then
    #PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
	. ~/.bash_prompts
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
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

# hack to get 256 color support in gnome terminal, cuz it's a piece of shit
case "$TERM" in
xterm)
    export TERM=xterm-256color
    ;;
*)
    ;;
esac

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'
alias vi='vim'

# useful alias for instant webserver
alias http='python -m http.server'
alias randpass="dd if=/dev/urandom bs=9 count=1 2>/dev/null | base64"
alias myip='curl https://diagnostic.opendns.com/myip'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi


# User specific aliases and functions
export EDITOR=vim
export LS_OPTIONS="$LS_OPTIONS -h"

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

export PAGER=less
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

complete -W "$(echo `cat ~/.ssh/known_hosts | cut -f 1 -d ' ' | sed -e s/,.*//g | uniq | grep -v "\["`;)" ssh

#key bindings
set -o emacs
bind "\C-j":edit-and-execute-command

#CUDA
if [ -d $HOME/cuda ]; then
	export PATH=$HOME/cuda/bin:$PATH
	export LD_LIBRARY_PATH=$HOME/cuda/lib64:$HOME/cuda/lib:$LD_LIBRARY_PATH
	export CPATH=$HOME/cuda/include:$CPATH
fi


# set up local bash config
if [ -n "${USE_LOCAL_CONFIG}" ]; then
	echo "Sourcing local config '$USE_LOCAL_CONFIG'"
	. ${USE_LOCAL_CONFIG}
fi

# set up specific rvm, python, and venv based on shell variables
if [ -n "$USE_PYTHON_VENV" ]; then
	echo "Starting venv '$USE_PYTHON_VENV'"
	#pybrew venv use "$USE_PYTHON_VENV"
	. ${USE_PYTHON_VENV}/bin/activate
fi

# RVM
if [ -x $HOME/.rvm/bin ]; then 
	PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
fi
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
if [ -n "$USE_RUBY" ]; then
	rvm use "$USE_RUBY"
fi

if command -v ruby; then
	export PATH="$PATH:$(ruby -e 'print Gem.user_dir')/bin"
fi

# NVM
[[ -s "/usr/share/nvm/init-nvm.sh" ]] && source "/usr/share/nvm/init-nvm.sh"

export AMDAPPSDKROOT="/home/josh/AMD/AMDAPPSDK-3.0"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
