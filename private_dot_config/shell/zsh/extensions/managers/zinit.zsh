# ~/.config/shell/zsh/extensions/managers/zinit.zsh

### Added by Zinit's installer
if [[ ! -f $ZSH_MANAGERS_DIR/zinit/zinit.zsh ]]; then
    installFromGit zdharma-continuum/zinit ${ZSH_MANAGERS_DIR}
fi

source "$ZSH_MANAGERS_DIR/zinit/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk

# Powerlevel10k
zinit ice depth=1; zinit light romkatv/powerlevel10k

# Plugins
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-history-substring-search
zinit light zdharma-continuum/fast-syntax-highlighting

# Oh My Zsh 功能
zinit snippet OMZ::lib/completion.zsh
zinit snippet OMZ::lib/history.zsh
zinit snippet OMZ::lib/key-bindings.zsh
zinit snippet OMZ::lib/theme-and-appearance.zsh

# key binding
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down