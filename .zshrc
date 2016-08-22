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

bindkey '^?' backward-delete-char                     # [Backspace] - delete backward
if [[ "${terminfo[kdch1]}" != "" ]]; then
  bindkey "${terminfo[kdch1]}" delete-char            # [Delete] - delete forward
else
  bindkey "^[[3~" delete-char
  bindkey "^[3;5~" delete-char
  bindkey "\e[3~" delete-char
fi
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

# Prompt - user, host, full path, and time/date; modified from rkj-repos (oh-my-zsh)
# on two lines for easier vgrepping; uses proper zsh colours; easy to change frame and name colour; returns %/# to the prompt
if [ "$(whoami)" = "root" ]; then P_F="$fg_bold[red]"; else; P_F="$fg_bold[blue]"; fi #frame color
if [ "$(whoami)" = "root" ]; then P_N="$fg_no_bold[red]"; else; P_N="$fg_no_bold[green]"; fi #name color
function mygit() {
    ref=$(command git symbolic-ref HEAD 2> /dev/null) 
    [ -z "$ref" ] && echo "" && return
    git_prompt_short_sha=$(command git rev-parse --short HEAD 2> /dev/null)
    echo "%{$reset_color%}git: (${ref#refs/heads/} ${git_prompt_short_sha}$( git_prompt_status )%{$reset_color%})"
}
# alternate prompt with git - removed hg as I don't use it.
PROMPT=$'\n%{'"$P_F"$'%}┌─[%{'"$P_N"$'%}%n%{$fg_no_bold[yellow]%}@%{$fg_no_bold[cyan]%}%m%{'"$P_F"$'%}]─[%{$reset_color%}%~%{'"$P_F"$'%}]─[%{$fg_no_bold[yellow]%}'%D{"%Y-%m-%d %I:%M:%S %p"}$'%{'"$P_F"$'%}]%{$reset_color%}%b
%{'"$P_F"'%}└─[%{$fg_bold[magenta]%}%?%{'"$P_F"$'%}] <$(mygit)%{'"$P_F"$'%}>%{$reset_color%}%b %# '
PS2=$' $fg[blue]%}%B>%{$reset_color%}%b '
# Nice aliases
alias ls="ls --color"
alias l="ls -l"
alias lh="ls -lh"
source ~/.zshrc-local #put machine-specific path, aliases etc. here
