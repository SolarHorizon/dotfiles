#!/bin/zsh

# aliases
alias ls='ls --color=auto'
alias la='ls -a'
alias ll='ls -l'

alias vi='nvim'
alias vim='nvim'

alias rrc='source /home/matt/.zshrc'
alias erc='vi /home/matt/.zshrc'

# completion
autoload -Uz compinit && compinit

zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:warnings' format '%F{yellow}%BNo matches for %d%b'

# correction
setopt correctall

# history
export HISTSIZE=2000
export HISTFILE="$HOME/.cache/zhistory"
export SAVEHIST=$HISTSIZE

setopt hist_ignore_space

# globbing
# setopt extendedglob

# autosuggestions
SUGGESTIONS_PATH="${HOME}/.local/src/zsh-autosuggestions/zsh-autosuggestions.zsh"

if [[ -f "${SUGGESTIONS_PATH}" ]]; then
	source "${SUGGESTIONS_PATH}"
fi

# prompt
eval "$(starship init zsh)"

