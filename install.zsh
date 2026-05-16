#!/bin/zsh

# dotfilesディレクトリの場所
DOT_DIR="$(cd "$(dirname "$0")" && pwd)"

# リンクを貼りたくないファイルを除外リストに入れる
EXCLUSIONS=( ".git" ".gitignore" ".DS_Store" )

for file in "$DOT_DIR"/.*
do
  filename=$(basename "$file")

  # 除外リストに含まれているかチェック
  if [[ "${EXCLUSIONS[@]}" =~ "${filename}" ]]; then
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

echo "Done!"