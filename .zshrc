export PROMPT="%F{green}$ %f"

# ------------------------------
# Custom local files
# ------------------------------
if [[ -f ${HOME}/.zshrc.local ]]; then
  source ${HOME}/.zshrc.local
fi
