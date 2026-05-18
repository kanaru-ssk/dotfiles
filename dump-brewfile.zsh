#!/bin/zsh

# dotfilesディレクトリの場所
DOT_DIR="$(cd "$(dirname "$0")" && pwd)"

brew bundle dump --file=$DOT_DIR/Brewfile --force --no-go --no-npm