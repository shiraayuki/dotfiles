eval "$(starship init zsh)"

export PATH=$PATH:/usr/local/go/bin

export PATH=$PATH:/home/nwegerer/Android/Sdk/platform-tools

export JAVA_HOME=/usr/lib/jvm/java-24-openjdk
export PATH=$JAVA_HOME/bin:$PATH

bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word

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

export PGPORT=5433

# TeX Live 2025 
export PATH=/usr/local/texlive/2025/bin/x86_64-linux:$PATH 
export MANPATH=/usr/local/texlive/2025/texmf-dist/doc/man:$MANPATH
export INFOPATH=/usr/local/texlive/2025/texmf-dist/doc/info:$INFOPATH
export PATH="$HOME/.npm-global/bin:$PATH"
export PATH="$HOME/.local/go/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"
eval "$(direnv hook zsh)"
