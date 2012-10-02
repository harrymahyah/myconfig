# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

#if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
#    . /etc/bash_completion
#fi

# User specific aliases and functions
#alias ls='ls --color=auto -X'
alias la='ls -A -X'
alias li='ls -1'
alias ll='ls -lh'
alias cp='cp -i'
alias mv='mv -i'
alias du='du -h'
alias less='less -RX'
alias tree='tree -C'
alias odc='od -tx1c'
#alias dir='dir --color=auto'
#vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

#git
alias gil="git log --graph --date-order -C -M --pretty=format:'<%h> %ad [%cn] %Cgreen%d%Creset %s' --all --date=short"
alias gib="git branch"
alias gico="git commit"
alias gis="git status"
alias gisu="git status -uno"
alias gici="git commit -a"
alias gid="git diff"
alias gip="git pull"

#prompt
#export PS1="\[$(tput setaf 2)¥u$(tput setaf 7)@$(tput setaf 3)¥h $(tput sgr0)¥t $(tput setaf 6)¥w$(tput sgr0)\]¥¥n¥$ "

export HISTCONTROL=ignoreboth
export HISTIGNORE="fg*:bg*:history*:cd:cd -:ls:ll"
export HISTTIMEFORMAT="%Y%m%d %T ";
shopt -s histappend

HISTSIZE=1000
HISTFILESIZE=2000

TIMEFORMAT=$'real %3lR user %3lU sys %3lS'
