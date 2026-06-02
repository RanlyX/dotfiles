# =========================================================
# Plugins
# =========================================================

ZPLUGINDIR="${ZSH_DATA_HOME}/plugins"
ZMANAGERDIR="${ZSH_DATA_HOME}/managers"
ZTHEMEDIR="${ZSH_DATA_HOME}/themes"

if [[ ! -d "${ZPLUGINDIR}" ]]; then
    mkdir -p "${ZPLUGINDIR}"
fi

# getAuthorProject() {
#     local git_repo=$1
#     echo ${git_repo} | cut -d '/' -f 1
#     echo ${git_repo} | cut -d '/' -f 2
# }

installFromGit() {
    local git_repo=$1
    local install_dir=$2
    local author=$(echo ${git_repo} | cut -d '/' -f 1)
    local project=$(echo ${git_repo} | cut -d '/' -f 2)
    if [[ ! -d "${install_dir}" ]]; then
        mkdir -p "${install_dir}"
    fi
    local git_dir="${install_dir}/${project}"
    if [[ ! -d "${git_dir}" ]]; then
        echo "Installing ${git_dir}..."
        git clone "https://github.com/${git_repo}" "${git_dir}" \
        || { echo "ERROR: failed to install ${git_dir}" >&2; return 1; }
    fi
}

source "${ZDOTDIR}/plugins/omz.zsh"

# _zplugin_load() {
#   local plugin_path="${ZPLUGINDIR}/${2}"
#   if [[ ! -d "$plugin_path" ]]; then
#     mkdir -p "$ZPLUGINDIR"
#     echo "Installing ${2}..."
#     git clone --depth=1 "https://github.com/${1}/${2}" "$plugin_path" \
#       || { echo "ERROR: failed to install ${2}" >&2; return 1; }
#   fi
#   source "${plugin_path}/${2}.plugin.zsh"
# }

# initZinit() {
#     ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
    
#     if [ ! -d "$ZINIT_HOME" ]; then
#         mkdir -p "$ZINIT_HOME"
#         git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
#     fi
    
#     source "${ZINIT_HOME}/zinit.zsh"
    
#     zinit ice depth=1; 
    
#     zinit light romkatv/powerlevel10k
#     zinit light zsh-users/zsh-autosuggestions
#     zinit light zdharma-continuum/fast-syntax-highlighting
#     zinit light zsh-users/zsh-history-substring-search
# }

# initOhMyZsh() {
#     downloadManager "ohmyzsh/ohmyzsh" "oh-my-zsh"
#     _zplugin_load "zsh-users" "zsh-autosuggestions"
#     _zplugin_load "zdharma-continuum" "fast-syntax-highlighting"
#     _zplugin_load "zsh-users" "zsh-history-substring-search"
# }

# if [ -n "$ZMANAGER" ]; then
#     case $ZMANAGER in
# 	"omz")
#         initOhMyZsh
# 	    ;;
#     "zi")
# 	    ;;
# 	"zinit")
#         initZinit
# 	    ;;
#     esac
# fi
