# History
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt append_history
setopt inc_append_history
setopt hist_ignore_all_dups

# Paths
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.local/go/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"
export PATH="$HOME/.npm-global/bin:$PATH"
export PATH="$PATH:$HOME/.dotnet/tools"

# TeX Live
export PATH=/usr/local/texlive/2025/bin/x86_64-linux:$PATH
export MANPATH=/usr/local/texlive/2025/texmf-dist/doc/man:$MANPATH
export INFOPATH=/usr/local/texlive/2025/texmf-dist/doc/info:$INFOPATH

# Tools
export SUDO_EDITOR=nvim
export EDITOR=nvim
# Prompt — schlicht, ohne Starship: blaues Verzeichnis, grünes/rotes ❯
setopt prompt_subst
PROMPT='%F{blue}%~%f %(?.%F{green}.%F{red})❯%f '
command -v direnv >/dev/null && eval "$(direnv hook zsh)"

# Aliases
alias ls='eza -lh --group-directories-first --icons=auto'
alias claude='claude --dangerously-skip-permissions'

# Completion
autoload -Uz compinit && compinit

# fzf — Ctrl+R history, Ctrl+T files, Alt+C dirs (aktiv sobald fzf installiert ist)
[[ -f /usr/share/fzf/key-bindings.zsh ]] && source /usr/share/fzf/key-bindings.zsh
[[ -f /usr/share/fzf/completion.zsh   ]] && source /usr/share/fzf/completion.zsh

# zoxide — smarter cd (aktiv sobald installiert)
command -v zoxide >/dev/null && eval "$(zoxide init zsh --cmd cd)"

# Keybinds: Ctrl+←/→ wortweise springen, Ctrl+Backspace/Entf wortweise löschen
bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word
bindkey '^H' backward-kill-word
bindkey '^[[3;5~' kill-word

# Inline-Vorschläge & Syntax-Highlighting (aktiv sobald installiert)
[[ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]] \
    && source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
[[ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]] \
    && source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Greeter — nur in Top-Level-Shells
[[ $SHLVL -eq 1 ]] && command -v fastfetch >/dev/null && fastfetch
export PATH="$HOME/.local/bin:$PATH"
