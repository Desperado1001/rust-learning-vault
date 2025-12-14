#!/bin/bash

# Neovim 0.12+ 启动脚本
# 使用方法: source use-neovim-012.sh 或者 ./use-neovim-012.sh

echo "🚀 切换到 Neovim 0.12+ 开发版..."

# 设置 PATH 环境变量
export PATH="$HOME/neovim-nightly/bin:$PATH"

# 刷新命令哈希
hash -r

echo "✅ Neovim 0.12+ 已激活"
echo "📋 版本信息:"
nvim --version | head -n 1

echo ""
echo "💡 使用提示:"
echo "   nvim              # 启动 Neovim"
echo "   nvim --version    # 查看版本"
echo "   nvim --headless   # 无头模式"
echo ""
echo "🔄 如需切换回系统版本，请重新打开终端"

# 如果参数包含启动命令，则执行
if [ "$1" = "start" ]; then
    echo "🎯 启动 Neovim 0.12+..."
    nvim
fi