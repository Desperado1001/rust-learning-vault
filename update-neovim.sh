#!/bin/bash

# Neovim 更新脚本
echo "当前 Neovim 版本:"
nvim --version | head -n 1

echo "检查更新中..."

# 检测包管理器并更新
if command -v brew &> /dev/null; then
    echo "使用 Homebrew 更新..."
    brew update && brew upgrade neovim
elif command -v snap &> /dev/null; then
    echo "使用 Snap 更新..."
    sudo snap refresh neovim
elif command -v apt &> /dev/null; then
    echo "使用 APT 更新..."
    sudo apt update && sudo apt install neovim
else
    echo "未检测到支持的包管理器，请手动更新"
    exit 1
fi

echo "更新后的 Neovim 版本:"
nvim --version | head -n 1

echo "Neovim 更新完成！"