# Various fixes/magic
autoload -U promptinit && promptinit
autoload -Uz compinit
# Colors - arch wiki
autoload -Uz colors && colors
zmodload -i zsh/complist
# Compinstall and zsh-newuser-install
zstyle ':completion:*' completer _expand _complete _ignored _match _correct _approximate _prefix
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' menu select=1
zstyle ':completion:*' original true
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle :compinstall filename '/home/chameleon/.zshrc'

compinit
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory autocd PROMPT_SUBST
unsetopt beep extendedglob nomatch notify
# title: https://github.com/MrElendig/dotfiles-alice
case $TERM in
  termite|*xterm*|rxvt|rxvt-unicode|rxvt-256color|rxvt-unicode-256color|(dt|k|E)term)
    precmd () {
      print -Pn "\e]0;[%n@%M][%~]%#\a"
    }
    preexec () { print -Pn "\e]0;[%n@%M][%~]%# ($1)\a" }
    ;;
  screen|screen-256color)
    precmd () {
      print -Pn "\e]83;title \"$1\"\a"
      print -Pn "\e]0;$TERM - (%L) [%n@%M]%# [%~]\a"
    }
    preexec () {
      print -Pn "\e]83;title \"$1\"\a"
      print -Pn "\e]0;$TERM - (%L) [%n@%M]%# [%~] ($1)\a"
    }
    ;;
esac
# Keys - oh-my-zsh + modifications
# includes home and end :^)
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
  function zle-line-init() {
    echoti smkx
  }
  function zle-line-finish() {
    echoti rmkx
  }
  zle -N zle-line-init
  zle -N zle-line-finish
fi

bindkey -e                                            # Use emacs key bindings

bindkey '\ew' kill-region                             # [Esc-w] - Kill from the cursor to the mark
bindkey '^r' history-incremental-search-backward      # [Ctrl-r] - Search backward incrementally for a specified string. The string may begin with ^ to anchor the search to the beginning of the line.
# I don't like fuzzyfind so I've removed it
# [Up-Arrow] - history up
if [[ "${terminfo[kcuu1]}" != "" ]]; then
  bindkey "${terminfo[kcuu1]}" up-line-or-history
fi
# [Down-Arrow] - history down
if [[ "${terminfo[kcud1]}" != "" ]]; then
  bindkey "${terminfo[kcud1]}" down-line-or-history
fi

if [[ "${terminfo[khome]}" != "" ]]; then
  bindkey "${terminfo[khome]}" beginning-of-line      # [Home] - Go to beginning of line
fi
if [[ "${terminfo[kend]}" != "" ]]; then
  bindkey "${terminfo[kend]}"  end-of-line            # [End] - Go to end of line
fi

bindkey ' ' magic-space                               # [Space] - do history expansion

bindkey '^[[1;5C' forward-word                        # [Ctrl-RightArrow] - move forward one word
bindkey '^[[1;5D' backward-word                       # [Ctrl-LeftArrow] - move backward one word

bindkey "${terminfo[kbs]}" backward-delete-char                     # [Backspace] - delete backward
bindkey  '^[[3~' delete-char            # [Delete] - delete forward

# git prompt status - oh-my-zsh + modifcations
function git_prompt_status() {
  local INDEX STATUS
  INDEX=$(command git status --porcelain -b 2> /dev/null)
  STATUS=""
  echo "$INDEX" | command grep -E '^\?\? ' &> /dev/null && STATUS="%{$fg[blue]%}✈$STATUS"
  echo "$INDEX" | grep '^A  \|^M  ' &> /dev/null && STATUS="%{$fg[cyan]%}+$STATUS"
  echo "$INDEX" | grep '^ M \|^AM \|^ T ' &> /dev/null && STATUS="%{$fg[yellow]%}*$STATUS"
  echo "$INDEX" | grep '^R  ' &> /dev/null && STATUS="%{$fg[blue]%}→$STATUS"
  echo "$INDEX" | grep '^ D \|^D  \|^AD ' &> /dev/null && STATUS="%{$fg[red]%}✗$STATUS"
  echo "$INDEX" | grep '^UU ' &> /dev/null && STATUS="%{$fg[magenta]%}x$STATUS"
  echo $STATUS
}
hashcode() {
	local hash=0
	local str="$1"X
	set --
	while [ -n "$str" ]; do
		next_str=${str#?}
		ch=${str%"$next_str"}
		set -- "$@" "'$ch"
		str=$next_str
	done
	for n in $(printf '%d ' "$@"); do
		hash=$(( (hash * 173 + n) % 256 ))
	done
	printf %s "$hash"
}
hieroglyph() {
	case "$1" in
		osiris )
			printf %s "𓊨𓁹𓁚";;
		thoth )
			printf %s "𓅝𓏏𓏭𓁚";;
		anubis )
			printf %s "𓇋𓈖𓅱𓁢";;
		* )
			printf %s "$1";;
	esac
}
# Prompt \nuser@host:dir\nHH:MM $? <git> %
# colorful, truncates nicely, visual sign of root access
# because of the truncation, it can handle terminals as narrow as 42
zshhost=$(hieroglyph "$(hostname)")
zshhostc=$(hashcode "$(hostname)")
function mygit() {
    ref=$(command git symbolic-ref HEAD 2> /dev/null)
    [ -z "$ref" ] && echo "" && return
    git_prompt_short_sha=$(command git rev-parse --short HEAD 2> /dev/null)
    echo "%{%f%}${ref#refs/heads/} ${git_prompt_short_sha}$( git_prompt_status )%{%f$reset_color%}"
}
PS1=$'\n%5>>%{%(!.$fg[red].$fg[green])%}%n%<<%{$fg[yellow]%}@%{\033[38;5;${zshhostc}m%}${zshhost}%{$fg[yellow]%}:%{%f%B%}%30<…<%~%>>%{%b%} %# '
PS2="%{$fg[yellow]%}%_ %{%B$fg[blue]%b%}>%{$reset_color%}"
RPROMPT=$'%(?..%{$fg_bold[magenta]%}%?%{$reset_color%} )$(mygit)'
# Nice aliases and functions
stty -ixon
pastebin () {
    if [ "$*" ]; then
        local prompt="$(PS1="$PS1" bash -i <<<$'\nexit' 2>&1 | head -n1)"
        ( echo "$(sed 's/\o033\[[0-9]*;[0-9]*m//g'  <<<"$prompt")$@"; exec $@; )
    else
        cat
    fi | curl -F 'sprunge=<-' http://sprunge.us
}
uguu(){
	curl -i -F name="$1" -F file=@"$1" https://uguu.se/api.php?d=upload-tool
	printf "\n"
}
alias ls="ls --color"
alias l="ls -l"
alias lh="ls -lh"
alias adb="sudo adb"
export GTK2_RC_FILES=/usr/share/themes/Arc-Dark/gtk-2.0/gtkrc
export GTK_THEME=Arc-Dark
if [ -f ~/.zshrc-local ]; then source ~/.zshrc-local; fi #put machine-specific path, aliases etc. here
