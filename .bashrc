# System-wide .bashrc file for interactive bash(1) shells.
if [ -z "$PS1" ]; then
   return
fi

PS1='\h:\W \u\$ '
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
#alias less='less -RX'
alias tree='tree -C'

#git
alias gil="git log --graph --date-order -C -M --pretty=format:'<%h> %ad [%cn] %Cgreen%d%Creset %s' --all --date=short"
alias gib="git branch"
alias gicm="git commit"
alias gico="git checkout"
alias gis="git status"
alias gisu="git status -uno"
alias gica="git commit -a"
alias gid="git diff"
alias gidn="git diff --name-only"
alias gip="git pull"
alias gils="git ls-files"

# git complete
git_comp="/usr/share/git-core/git-completion.bash"
if [ -f $git_comp ]; then
	source $git_comp
fi

__git_complete gico _git_checkout
__git_complete gid _git_diff
__git_complete gidn _git_diff
__git_complete gib _git_branch

export HISTCONTROL=ignoreboth
export HISTIGNORE="fg*:bg*:history*:cd:cd -:ls:ll"
export HISTTIMEFORMAT="%Y%m%d %T ";
shopt -s histappend

HISTSIZE=1000
HISTFILESIZE=2000

TIMEFORMAT=$'real %3lR user %3lU sys %3lS'
