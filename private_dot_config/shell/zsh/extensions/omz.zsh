# 

installFromGit ohmyzsh/ohmyzsh ${ZMANAGERDIR}

export ZSH="${ZMANAGERDIR}/ohmyzsh"
export ZSH_CUSTOM="${ZSH}/custom"
export ZSH_PLUGINS="${ZSH_CUSTOM}/plugins"
export ZSH_THEMES="${ZSH_CUSTOM}/themes"

installPlugins() {
    local git_repo=$1
    local project=$(echo ${git_repo} | cut -d '/' -f 2)
    installFromGit "${git_repo}" "${ZPLUGINDIR}" "--depth=1"
    plugins+=("${project}")
    if [[ ! -L "${ZSH_PLUGINS}/${project}" ]]; then
        echo "Creating symlink for ${project}..."
        ln -sf "${ZPLUGINDIR}/${project}" "${ZSH_PLUGINS}/${project}"
    fi
}


plugins=(
	git
	z
)

installPlugins "zsh-users/zsh-autosuggestions"
installPlugins "zdharma-continuum/fast-syntax-highlighting" 
installPlugins "zsh-users/zsh-history-substring-search" 

# echo "Plugins: ${plugins[@]}"

installThemes() {
    local git_repo=$1
    local project=$(echo ${git_repo} | cut -d '/' -f 2)
    installFromGit "${git_repo}" "${ZTHEMEDIR}" "--depth=1"
    if [[ ! -L "${ZSH_THEMES}/${project}" ]]; then
        echo "Creating symlink for ${project}..."
        ln -sf "${ZTHEMEDIR}/${project}" "${ZSH_THEMES}/${project}"
    fi
}

installThemes "romkatv/powerlevel10k"
ZSH_THEME="powerlevel10k/powerlevel10k"

export ZSH_COMPDUMP="$ZSH_CACHE_HOME/zcompdump"
source $ZSH/oh-my-zsh.sh
