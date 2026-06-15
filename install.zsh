#!/bin/zsh

# dotfilesディレクトリの場所
DOT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "Create symlinks..."

for file in "$DOT_DIR"/.*
do
  filename=$(basename "$file")

  # 除外リストに含まれているかチェック
  if [[ ".git .gitignore .DS_Store .config .agents" =~ "${filename}" ]]; then
      continue
  fi

  # すでに存在する場合は削除
  if [ -e "$HOME/$filename" ]; then
    rm -rf "$HOME/$filename"
  fi

  # シンボリックリンクを作成
  ln -snf "$file" "$HOME/$filename"
  echo "link ~/$filename -> $file"
done

if [[ ! -d ${HOME}/.config ]]; then
  mkdir ${HOME}/.config
fi
for file in "$DOT_DIR"/.config/*
do
  filename=$(basename "$file")

  # すでに存在する場合は削除
  if [ -e "$HOME/.config$filename" ]; then
    rm -rf "$HOME/.config/$filename"
  fi

  # シンボリックリンクを作成
  ln -snf "$file" "$HOME/.config/$filename"
  echo "link ~/.config/$filename -> $file"
done

if [[ ! -d ${HOME}/.agents ]]; then
  mkdir ${HOME}/.agents
fi
for file in "$DOT_DIR"/.agents/*
do
  filename=$(basename "$file")

  # すでに存在する場合は削除
  if [ -e "$HOME/.agents/$filename" ]; then
    rm -rf "$HOME/.agents/$filename"
  fi

  # シンボリックリンクを作成
  ln -snf "$file" "$HOME/.agents/$filename"
  echo "link ~/.agents/$filename -> $file"
done

echo "Install brew packages..."

# brew bundle --file=$DOT_DIR/Brewfile

echo "Done!"