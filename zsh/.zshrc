# terminal theme
eval "$(starship init zsh)"
export STARSHIP_CONFIG=~/.config/starship/config.toml

# ALT + arrow should move the cursor
bindkey "^[[1;3C" forward-word
bindkey "^[[1;3D" backward-word

# neovim
alias vi='nvim'
alias vim='nvim'
export alias EDITOR='nvim'

# nvims fzf addon should use ripgrep
# and allow multiple file selection
if type rg &> /dev/null; then
  export FZF_DEFAULT_COMMAND='rg --files'
  export FZF_DEFAULT_OPTS='-m --height 50% --border'
fi

alias l='ls -la --color=auto'
