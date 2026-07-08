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
# Prompt — simple, no starship: blue directory, green/red ❯
setopt prompt_subst
PROMPT='%F{blue}%~%f %(?.%F{green}.%F{red})❯%f '
command -v direnv >/dev/null && eval "$(direnv hook zsh)"

# Aliases
alias ls='eza -lh --group-directories-first --icons=auto'
alias claude='claude --dangerously-skip-permissions'

# Completion
autoload -Uz compinit && compinit

# fzf — Ctrl+R history, Ctrl+T files, Alt+C dirs (active once fzf is installed)
[[ -f /usr/share/fzf/key-bindings.zsh ]] && source /usr/share/fzf/key-bindings.zsh
[[ -f /usr/share/fzf/completion.zsh   ]] && source /usr/share/fzf/completion.zsh

# zoxide — smarter cd (active once installed)
command -v zoxide >/dev/null && eval "$(zoxide init zsh --cmd cd)"

# Keybinds: Ctrl+←/→ jump by word, Ctrl+Backspace/Del delete by word
bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word
bindkey '^H' backward-kill-word
bindkey '^[[3;5~' kill-word

# Inline suggestions & syntax highlighting (active once installed)
[[ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]] \
    && source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
[[ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]] \
    && source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Greeter — only in top-level shells
[[ $SHLVL -eq 1 ]] && command -v fastfetch >/dev/null && fastfetch
export PATH="$HOME/.local/bin:$PATH"
