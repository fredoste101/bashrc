#STOLEN FROM:
#https://serverfault.com/questions/3743/what-useful-things-can-one-add-to-ones-bashrc 
#EXTRACT ANY ARCHIVE
extract () {
   if [ -f $1 ] ; then
       case $1 in
           *.tar.bz2)   tar xvjf $1    ;;
           *.tar.gz)    tar xvzf $1    ;;
           *.bz2)       bunzip2 $1     ;;
           *.rar)       unrar x $1       ;;
           *.gz)        gunzip $1      ;;
           *.tar)       tar xvf $1     ;;
           *.tbz2)      tar xvjf $1    ;;
           *.tgz)       tar xvzf $1    ;;
           *.zip)       unzip $1       ;;
           *.Z)         uncompress $1  ;;
           *.7z)        7z x $1        ;;
           *)           echo "don't know how to extract '$1'..." ;;
       esac
   else
       echo "'$1' is not a valid file!"
   fi
}

#SHOW MANPAGES IN COLOR WITH LESS
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'


#STOLEN FROM: 
#https://askubuntu.com/questions/339546/how-do-i-see-the-history-of-the-commands-i-have-run-in-tmux
# avoid duplicates..
export HISTCONTROL=ignoredups:erasedups

# append history entries..
shopt -s histappend

# After each command, save and reload history
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

# SET PROMPT #
#export PS1

RESET="\[\033[0m\]"
RED="\[\033[0;31m\]"
GREEN="\[\033[01;32m\]"
BLUE="\[\033[01;34m\]"
BLUE2="\[\033[00;34m\]"
YELLOW="\[\033[0;33m\]"
RESETPOS="\[\033[0G\]"
SMILEY="${GREEN}:)${RESET}"
FROWNY="${RED}:(${RESET}"
SELECT="if [ \$? = 0 ]; then echo \"${SMILEY}\"; else echo \"${FROWNY}\"; fi"

PS_LINE=`printf -- '- %.0s' {1..200}`
function parse_git_branch {
  PS_BRANCH=''
  PS_FILL=${PS_LINE:0:$COLUMNS}
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  PS_BRANCH="(${ref#refs/heads/}) "
}
PROMPT_COMMAND=parse_git_branch
PS_INFO="$BLUE2\u@\h$RESET:$BLUE\w"
PS_GIT="$YELLOW\$PS_BRANCH$RESET"
PS_TIME="\[\033[\$((COLUMNS-10))G\] $RED[\t]$RESET"

export PS1="\${PS_FILL}${RESETPOS}${PS_INFO} \`${SELECT}\` ${PS_GIT}${PS_TIME}\n${RESET}>> "


