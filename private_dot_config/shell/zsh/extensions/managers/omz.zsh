# ~/.config/shell/zsh/extensions/managers/omz.zsh

# =========================================================
# Oh my zsh manager
# =========================================================

# Install
installFromGit ohmyzsh/ohmyzsh ${ZSH_MANAGERS_DIR}

# Custom path
ZSH="${ZSH_MANAGERS_DIR}/ohmyzsh"
ZSH_CUSTOM_DIR="${ZSH}/custom"
ZSH_CUSTOM_PLUGINS_DIR="${ZSH_CUSTOM_DIR}/plugins"
ZSH_CUSTOM_THEMES_DIR="${ZSH_CUSTOM_DIR}/themes"

# =========================================================
# Plugins
# =========================================================

# Plugin list
plugins=(
	git
	z
)

# Install
installPlugins() {
    local git_repo=$1
    local project=$(echo ${git_repo} | cut -d '/' -f 2)
    installFromGit "${git_repo}" "${ZSH_PLUGINS_DIR}" "--depth=1"
    plugins+=("${project}")
    if [[ ! -L "${ZSH_CUSTOM_PLUGINS_DIR}/${project}" ]]; then
        echo -e "\033[ACreating symlink for ${project}..."
        ln -sf "${ZSH_PLUGINS_DIR}/${project}" "${ZSH_CUSTOM_PLUGINS_DIR}/${project}"
        echo
    fi
}

source "$ZEXTENSIONSDIR/plugins.zsh" 

for plugin in ${ZSH_PLUGINS[@]}; do
    installPlugins "${plugin}"
done

# Debug message for plugins
# echo "Plugins: ${plugins[@]}"

# =========================================================
# Themes
# =========================================================

# Install
installThemes() {
    local git_repo=$1
    local project=$(echo ${git_repo} | cut -d '/' -f 2)
    installFromGit "${git_repo}" "${ZSH_THEMES_DIR}" "--depth=1"
    if [[ ! -L "${ZSH_CUSTOM_THEMES_DIR}/${project}" ]]; then
        echo -e "\033[ACreating symlink for ${project}..."
        ln -sf "${ZSH_THEMES_DIR}/${project}" "${ZSH_CUSTOM_THEMES_DIR}/${project}"
        echo
    fi
}

source "$ZEXTENSIONSDIR/themes.zsh" 

for theme in ${ZSH_THEMES[@]}; do
    installThemes "${theme}"
done

# Set theme
ZSH_THEME="powerlevel10k/powerlevel10k"

# =========================================================
# Others
# =========================================================

# Reassign compdump path
export ZSH_COMPDUMP="$ZSH_CACHE_HOME/zcompdump"

# Apply to OMZ
source $ZSH/oh-my-zsh.sh
