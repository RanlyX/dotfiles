# ~/.config/shell/zsh/extensions/extensions.sh

# =========================================================
# Extensions
# =========================================================

# Install from git repository
installFromGit() {
    local git_repo=$1
    local install_dir=$2
    shift
    shift
    local clone_args=$@
    local author=$(echo ${git_repo} | cut -d '/' -f 1)
    local project=$(echo ${git_repo} | cut -d '/' -f 2)
    if [[ ! -d "${install_dir}" ]]; then
        mkdir -p "${install_dir}"
    fi
    local git_dir="${install_dir}/${project}"
    if [[ ! -d "${git_dir}" ]]; then
        echo "Installing ${project}..."
        git clone ${clone_args} "https://github.com/${git_repo}" "${git_dir}" \
	&& echo \
        || { echo "ERROR: failed to install ${git_dir}" >&2; return 1; }
    fi
}

# Zsh manager config
ZMANAGER="omz"

case ${ZMANAGER} in
    "omz")
        source "${ZMANAGERSDIR}/omz.zsh"
        ;;
    *)
        ;;
esac
