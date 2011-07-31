fpath=(~/.zsh/Completion $fpath)

HISTFILE=~/.histfile
HISTSIZE=5000
SAVEHIST=5000
EC2='ecc.rohanjain.in'

# zsh options; man zshoptions
setopt sharehistory
setopt histignoredups
setopt histignorealldups
setopt histfindnodups
setopt histignorespace

setopt extendedglob
setopt notify
setopt correct
setopt interactivecomments
setopt multios

setopt autocd
setopt autopushd
setopt pushdignoredups
setopt pushdsilent

setopt autolist
unsetopt listambiguous

setopt listpacked
setopt listtypes

unsetopt flowcontrol
unsetopt beep

# vim bindings
bindkey -v
bindkey '^P' history-beginning-search-backward
bindkey '^N' history-beginning-search-forward
bindkey '^[[Z' reverse-menu-complete
bindkey '^[/' undo

# configure zsh's autocompletion system; man zshcompsys
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

zstyle ':completion:*' completer _expand _complete _match _approximate
zstyle ':completion:*' matcher-list '+' '+m:{[:lower:]}={[:upper:]}' '+r:|[._-]=** r:|=**' '+l:|=* r:|=*'
zstyle ':completion:*:match:*' original only
zstyle -e ':completion:*' max-errors 'reply=( $(( ($#PREFIX+$#SUFFIX)/3 )) numeric )'
zstyle ':completion:*:functions' ignored-patterns '_*'
zstyle ':completion:*' ignore-parents parent pwd
zstyle ':completion:*' list-suffixes true
zstyle ':completion:*' expand suffix
zstyle ':completion:*:kill:*' command 'ps -u$USER'

zstyle ':completion::expand:*' tag-order 'expansions all-expansions'
zstyle ':completion:*' remove-all-dups true
zstyle ':completion:*' group-name ''
zstyle ':completion:*' format '%B%d:%b'
zstyle ':completion:*' verbose true
zstyle ':completion:*' file-sort access
zstyle ':completion:*' list-colors no=00 fi=00 di=01\;34 pi=33 so=01\;35 bd=00\;35 cd=00\;34 or=00\;41 mi=00\;45 ex=01\;32
zstyle ':completion:*' menu 'select=0'
zstyle ':completion:*' list-prompt ''
zstyle ':completion:*' select-prompt ''

zstyle ':completion:*' insert-tab false
zstyle ':completion:*' prompt ''\''%e'\'''
zstyle ':completion:*:manuals' separate-sections true

autoload -Uz compinit
compinit

# Initialize prompt
autoload -Uz promptinit
promptinit
prompt adam2

#PS1="%~$ "
#export MOZ_NO_REMOTE=1

### Aliases
alias df='df -h'
alias du='du -hs'

alias la='ls -aG --color'
alias ll='ls -lhG --color'
alias ls='ls -G --color'
alias l='ls -G --color'

alias info='info --vi-keys'

alias pi='sudo aptitude install'
alias pr='sudo aptitude remove'
alias pp='sudo aptitude purge'
alias pud='sudo aptitude update'
alias pug='sudo aptitude safe-upgrade'
alias pufg='sudo aptitude full-upgrade'
alias pse='aptitude search'
alias psh='aptitude show'

alias halt='sudo shutdown -h now'
alias reboot='sudo reboot'

alias e='gvim --remote-tab-silent'

alias -g ack='ack-grep'
alias -g G='| grep'
alias -g L='| less'

alias p='pstr paste'
alias pc='proxychains'
alias sz='source ~/.zshrc'
alias ez='e ~/.zshrc'
alias ev='e ~/.vimrc'
#A pad to dump arbit data
alias ed='e /home/rohan/workspace/trash/dumppad.md'

#Launch ec2 account
alias ec2='pc ssh $EC2'

alias pip='pip $@ --proxy="$http_proxy"'


alias entertain='mplayer "$(find "." -type f -regextype posix-egrep -regex ".*\.(avi|mkv|flv|mpg|mpeg|mp4|wmv|3gp|mov|divx)" | shuf -n1)"'
alias rand='tr -c "[:digit:]" " " < /dev/urandom | dd cbs=$COLUMNS conv=unblock | GREP_COLOR="1;32" grep --color "[^ ]"'

alias mirosubs="source /home/rohan/workspace/python/mirosubs/env/bin/activate"
alias venv="source venv"

#Tell tmux 256 color support
alias tmux="tmux -2"

### Exports
export EDITOR=vim
export JAVA_HOME=/usr
export PKG_CONFIG_PATH=/home/yeban/opt/lib/pkgconfig/:${PKG_CONFIG_PATH}
export PATH=$PATH:/opt/src/go/bin:$HOME/bin
export GOROOT=:/opt/src/go

export PYTHONSTARTUP=$HOME/.pythonrc
export _JAVA_AWT_WM_NONREPARENTING=1
export http_proxy=http://144.16.192.216:8080/

s() { find . -iname "*$@*" }

#Search for text in files
sg() {
    if [ $# -gt 1 ];then
        find . -iname "$1" | xargs grep "$2"
    else
        echo 'Input the file and grep patterns'
    fi
}

# if using GNU screen, let the zsh tell screen what the title and hardstatus
# of the tab window should be.
if [[ $TERM == "screen"* ]]; then
  _GET_PATH='echo $PWD | sed "s/^\/Users\//~/;s/^~$USER/~/"'

  # use the current user as the prefix of the current tab title
  TAB_TITLE_PREFIX='"`'$_GET_PATH' | sed "s:..*/::"`$PROMPT_CHAR "'
  # when at the shell prompt, show a truncated version of the current path (with
  # standard ~ replacement) as the rest of the title.
  TAB_TITLE_PROMPT='$SHELL:t'
  # when running a command, show the title of the command as the rest of the
  # title (truncate to drop the path to the command)
  TAB_TITLE_EXEC='$cmd[1]:t'
  # use the current path (with standard ~ replacement) in square brackets as the
  # prefix of the tab window hardstatus.
  TAB_HARDSTATUS_PREFIX='"[`'$_GET_PATH'`] "'
  # when at the shell prompt, use the shell name (truncated to remove the path to
  # the shell) as the rest of the title
  TAB_HARDSTATUS_PROMPT='$SHELL:t'
  # when running a command, show the command name and arguments as the rest of
  # the title
  TAB_HARDSTATUS_EXEC='$cmd'

  # tell GNU screen what the tab window title ($1) and the hardstatus($2) should be
  function screen_set()
  {
    # set the tab window title (%t) for screen
    print -nR $'\033k'$1$'\033'\\\

    # set hardstatus of tab window (%h) for screen
    print -nR $'\033]0;'$2$'\a'
  }
fi

precmd() {
    # reset LD_PRELOAD khat might have been set in preexec()
    export LD_PRELOAD=''

    # send a visual bell to awesome
    #echo -ne '\a'

    # set cwd in terminals
    case $TERM in
        xterm|rxvt|rxvt-unicode|screen)
            print -Pn "\e]2;%d\a"
            ;;
    esac

    # for autojump
    z --add "$(pwd -P)"

    # Set the window title for screen
    if [[ $TERM == "screen"* ]]; then
        eval "tab_title=$TAB_TITLE_PREFIX$TAB_TITLE_PROMPT"
        eval "tab_hardstatus=$TAB_HARDSTATUS_PREFIX$TAB_HARDSTATUS_PROMPT"
        screen_set $tab_title $tab_hardstatus
    fi
}

preexec () {
    local command=${(V)1//\%\%\%}
    local first=${command%% *}

    # set terminal's title to the currently executing command
    case $TERM in
        xterm|rxvt|rxvt-unicode|screen)
            command=$(print -Pn "%40>...>$command" | tr -d "\n")
            print -Pn "\e]2;$command\a"
            ;;
    esac

    # automatically use proxychains for some programs
    case $first in
        alpine|mutt|git|svn)
            export LD_PRELOAD=libproxychains.so.3
            ;;
    esac

    # Set the window title for screen
    if [[ $TERM == "screen"* ]]; then
        local -a cmd; cmd=(${(z)1}) # the command string
        eval "tab_title=$TAB_TITLE_PREFIX$TAB_TITLE_EXEC"
        eval "tab_hardstatus=$TAB_HARDSTATUS_PREFIX$TAB_HARDSTATUS_EXEC"
        screen_set $tab_title $tab_hardstatus
    fi

}

# Set default working directory of tmux to the given directory; use the current
# working directory if none given.
#
# TODO: this does not honour .rvmrc
cdt(){
    [[ -n "$1" ]] && dir="$1" || dir="${PWD}"
    if [[ -d "$dir" ]]; then
        tmux "set-option" "default-path" "${dir}"
        return 0
    else
        echo "tcd: no such directory: ${dir}"
        return 1
    fi
}

# Open a duplicate screen window
dup() {
    screen -c "cd \"$PWD\" && exec $SHELL --login"
}

# Automatically append a / after ..
rationalise-dot() {
  if [[ $LBUFFER = *.. ]]; then
    LBUFFER+=/..
  else
    LBUFFER+=.
  fi
}
zle -N rationalise-dot
bindkey . rationalise-dot

# Start history-incremental-search-backward with whatever has already been typed
# on the command line.
history-incremental-search-backward-initial() {
    zle history-incremental-search-backward $BUFFER
}
zle -N history-incremental-search-backward-initial
bindkey '^R' history-incremental-search-backward-initial
bindkey -M isearch '^R' history-incremental-search-backward

# Load RVM; http://rvm.beginrescueend.com/
if [[ -s "$HOME/.rvm/scripts/rvm" ]] ; then source "$HOME/.rvm/scripts/rvm" ; fi

# Auto jump; https://github.com/sjl/z-zsh
. $HOME/.zsh/z/z.sh

# Rooter; https://github.com/yeban/rooter.sh
. $HOME/.zsh/rooter.sh/rooter.sh

. $HOME/.ec2/setup.sh
