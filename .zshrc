export PROMPT="%F{green}$ %f"

eval "$(/opt/homebrew/bin/brew shellenv)"
eval "$(mise activate zsh)"

export PATH="${HOME}/.local/bin:$PATH"
export PATH="$HOME/.moon/bin:$PATH"

# ------------------------------
# Custom local files
# ------------------------------
if [[ -f ${HOME}/.zshrc.local ]]; then
  source ${HOME}/.zshrc.local
fi
