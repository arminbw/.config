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


