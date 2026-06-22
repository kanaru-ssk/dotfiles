#!/usr/bin/env zsh

# dotfiles を $HOME にシンボリックリンクし、Homebrew パッケージを導入する。

set -e
setopt null_glob

readonly DOT_DIR="${0:A:h}"
readonly BACKUP_DIR="$HOME/.dotfiles_backup/$(date +%Y%m%d%H%M%S)"

# シンボリックリンクの対象から外す名前(ファイル名・ディレクトリ名)
readonly EXCLUDES=(.git .DS_Store)

# 相対パスのいずれかのセグメントが EXCLUDES に一致したら除外
is_excluded() {
  local part
  for part in ${(s:/:)1}; do
    (( ${EXCLUDES[(Ie)$part]} )) && return 0
  done
  return 1
}

# $1: リンク元(実体) $2: リンク先
link_item() {
  local src="$1" dest="$2"

  # 既に正しいリンク(同じ実体を指すシンボリックリンク)が張られていれば何もしない。
  if [[ -L "$dest" && "$(readlink "$dest")" == "$src" ]]; then
    echo "  skip    $dest"
    return
  fi

  if [[ -e "$dest" || -L "$dest" ]]; then
    # $HOME からの相対パスを保ったまま退避し、basename 衝突による上書きを防ぐ
    local backup="$BACKUP_DIR/${dest#$HOME/}"
    mkdir -p "$(dirname "$backup")"
    mv "$dest" "$backup"
    echo "  backup  $dest -> $backup"
  fi

  ln -sfn "$src" "$dest"
  echo "  link    $dest -> $src"
}

echo "==> Linking dotfiles to $HOME"
for src in "$DOT_DIR"/.*(.D) "$DOT_DIR"/.*/**/*(.D); do
  rel="${src#$DOT_DIR/}"
  is_excluded "$rel" && continue
  dest="$HOME/$rel"
  mkdir -p "$(dirname "$dest")"
  link_item "$src" "$dest"
done

echo "==> Installing Homebrew packages"
brew bundle --file="$DOT_DIR/Brewfile"

echo "Done!"
