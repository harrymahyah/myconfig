# System-wide .bashrc file for interactive bash(1) shells.
if [ -z "$PS1" ]; then
   return
fi

#PS1='\h:\W \u\$ '
# Make bash check its window size after a process completes
shopt -s checkwinsize
# Tell the terminal about the working directory at each prompt.
if [ "$TERM_PROGRAM" == "Apple_Terminal" ] && [ -z "$INSIDE_EMACS" ]; then
    update_terminal_cwd() {
        # Identify the directory using a "file:" scheme URL,
        # including the host name to disambiguate local vs.
        # remote connections. Percent-escape spaces.
	local SEARCH=' '
	local REPLACE='%20'
	local PWD_URL="file://$HOSTNAME${PWD//$SEARCH/$REPLACE}"
	printf '\e]7;%s\a' "$PWD_URL"
    }
    PROMPT_COMMAND="update_terminal_cwd; $PROMPT_COMMAND"
fi

alias ls="ls -G"
alias la="ls -alG"
alias ll="ls -lG"
alias li='ls -1G'
alias cp='cp -i'
alias mv='mv -i'
alias du='du -h'
alias less='less -RX'
alias tree='tree -C'
alias xcode='open -a Xcode.app'
alias updatedb='sudo /usr/libexec/locate.updatedb'

#xcode completion
complete -d -X '!*.xc*' xcode

#git
alias gil="git log --graph --date-order -C -M --pretty=format:'<%h> %ad [%cn] %Cgreen%d%Creset %s' --date=short"
alias gila="git log --graph --date-order -C -M --pretty=format:'<%h> %ad [%cn] %Cgreen%d%Creset %s' --all --date=short"
alias gib="git branch --color"
alias gicm="git commit"
alias gico="git checkout"
alias gicof="git checkout --" #complete unstaged file only
alias gis="git status --ignore-submodules"
alias gisu="git status -uno "
alias gica="git commit -a"
alias gid="git diff --color"
alias gidn="git diff --name-only --ignore-submodules --color"
alias gipl="git pull"
alias gils="git ls-files"
alias gimg="git merge --no-ff "
alias gimgs="git merge --squash "
alias gist="git stash"
alias gists="git stash save"
alias gistp="git stash pop"
#alias giprn="git remote prune origin"
alias giprn="git fetch --prune"
alias giad="git add"

#tig 
alias tigal="tig --all"

# git complete
git_install_dir="/usr/local/etc/bash_completion.d"
git_comp="${git_install_dir}/git-completion.bash"
git_prompt="${git_install_dir}/git-prompt.sh"

if [ -f $git_comp ]; then
	source $git_comp
fi
if [ -f $git_prompt ]; then
	source $git_prompt
fi


_git_unstaged()
{
	__gitcomp "$(git status -suno|awk '{print $2}')"
}


__git_complete gico _git_checkout
__git_complete gicof _git_unstaged
__git_complete giad _git_unstaged
__git_complete gid _git_diff
__git_complete gidn _git_diff
__git_complete gib _git_branch
__git_complete gimg _git_merge
__git_complete gimgs _git_merge

# display branch name to prompt
git_prompt="/usr/share/git-core/git-prompt.sh"
if [ -f $git_prompt ]; then
	source $git_prompt
fi

### interactive git add

#PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '
export PS1='[\[\033[01;32m\]\u@\h\[\033[01;33m\] \w$(__git_ps1) \[\e[00m\] $(date '+%Y/%m/%d') \t]\n\[\033[01;34m\]\$\[\033[00m\] '
GIT_PS1_SHOWDIRTYSTATE=true
#export PS1='\[\033[32m\]\u@\h\[\033[00m\]:\[\033[34m\]\w\[\033[31m\]$(__git_ps1)\[\033[00m\]\$ '

export HISTCONTROL=ignoreboth
export HISTIGNORE="fg*:bg*:history*:cd:cd -:ls:ll"
export HISTTIMEFORMAT="%Y%m%d %T ";
shopt -s histappend

HISTSIZE=1000
HISTFILESIZE=2000

TIMEFORMAT=$'real %3lR user %3lU sys %3lS'

IGNOREEOF=1 #ignore ctrl-D once
export IGNOREEOF

#export _JAVA_OPTIONS=-Dfile.encoding=UTF-8

#PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
