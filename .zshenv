eval "$(/opt/homebrew/bin/brew shellenv)"
eval "$(mise activate zsh)"

export PATH="${HOME}/.local/bin:$PATH"
export PATH="/Users/kanaru/.antigravity/antigravity/bin:$PATH"

# ------------------------------
# Custom local files
# ------------------------------
if [[ -f ${HOME}/.zshenv.local ]]; then
  source ${HOME}/.zshenv.local
fi