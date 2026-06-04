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

# Plugins
source "$ZEXTENSIONSDIR/plugins.zsh" 
for plugin in ${ZSH_PLUGINS[@]}; do
    zinit light "${plugin}"
done

# OMZ plugins
for plugin in ${OMZ_PLUGINS[@]}; do
    zinit snippet OMZ::"${plugin}"
done

# Themes
source "$ZEXTENSIONSDIR/themes.zsh" 
for theme in ${ZSH_THEMES[@]}; do
    zinit ice depth=1
    zinit light romkatv/powerlevel10k
done

# key binding
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down