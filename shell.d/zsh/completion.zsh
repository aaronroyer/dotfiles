autoload -U compinit
compinit # Completions in ~/.zsh/functions

# Case-insensitive (uppercase from lowercase) completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

which npm &> /dev/null && source <(npm completion)
