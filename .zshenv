eval "$(/opt/homebrew/bin/brew shellenv)"
eval "$(mise activate zsh)"

export DOCKER_HOST=unix://${HOME}/.docker/run/docker.sock
export PATH="${HOME}/.local/bin:$PATH"

# ------------------------------
# Custom local files
# ------------------------------
if [[ -f ${HOME}/.zshenv.local ]]; then
  source ${HOME}/.zshenv.local
fi
