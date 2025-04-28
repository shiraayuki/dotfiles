eval "$(starship init zsh)"

export PATH=$PATH:/usr/local/go/bin

# set the history file location
HISTFILE=~/.zsh_history

# ensure history is saved at session end
SAVEHIST=10000

# keep history across multiple sessions
HISTSIZE=10000
SAVEHIST=10000

# append to the history file (not override)
setopt append_history

# share history between all zsh sessions
setopt inc_append_history

# avoid duplicates in history
setopt hist_ignore_all_dups
