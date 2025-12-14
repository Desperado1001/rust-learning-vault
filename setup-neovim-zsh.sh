#!/bin/bash

# Neovim 0.12+ ZSH 配置脚本
# 自动将 Neovim 0.12+ 配置添加到 .zshrc

echo "🔧 配置 ZSH 以使用 Neovim 0.12+..."

# 创建备份
cp ~/.zshrc ~/.zshrc.backup.$(date +%Y%m%d_%H%M%S)
echo "✅ 已备份 .zshrc 到 ~/.zshrc.backup.$(date +%Y%m%d_%H%M%S)"

# 检查是否已经存在 Neovim PATH 配置
if grep -q "neovim-nightly" ~/.zshrc; then
    echo "⚠️  发现已存在的 neovim-nightly 配置，正在移除..."
    # 移除旧的配置
    sed -i '' '/neovim-nightly/d' ~/.zshrc
    sed -i '' '/Neovim 0.12+/,$d' ~/.zshrc
fi

# 添加 Neovim 配置到 .zshrc 末尾
cat >> ~/.zshrc << 'EOF'

# ===================================================
# Neovim 0.12+ 配置 - 由 setup-neovim-zsh.sh 添加
# ===================================================

# 设置 Neovim 0.12+ 路径
export PATH="$HOME/neovim-nightly/bin:$PATH"

# 设置默认编辑器
export EDITOR="nvim"

# Neovim 相关别名
alias nvim012="$HOME/neovim-nightly/bin/nvim"
alias nvim-version='nvim --version | head -n 1'
alias nvim-config='cd ~/.config/nvim'
alias vim='nvim'  # 使用 nvim 替代 vim

# 检查 Neovim 版本和状态的函数
function nvim-info() {
    echo "🚀 Neovim 信息:"
    echo "📍 路径: $(which nvim 2>/dev/null || echo '未找到 nvim')"
    if command -v nvim &> /dev/null; then
        echo "📋 版本: $(nvim --version | head -n 1)"
        echo "🔧 版本类型: $(nvim --version | grep 'Build type' || echo '未知')"
    else
        echo "❌ Neovim 未安装或不在 PATH 中"
    fi
    echo "📁 配置: ~/.config/nvim"
    echo "🔧 插件: ~/.local/share/nvim/lazy"
}

# 检查 Neovim 健康状态
function nvim-health() {
    if command -v nvim &> /dev/null; then
        echo "🏥 检查 Neovim 健康状态..."
        nvim --headless -c "checkhealth" -c "qa" 2>&1 | head -20
    else
        echo "❌ Neovim 未安装"
    fi
}

# 启动 Neovim 时的欢迎信息
function nvim-welcome() {
    echo "🎉 欢迎使用 Neovim $(nvim --version | head -n 1 | cut -d' ' -f2)!"
    echo "💡 输入 nvim-info 查看详细信息"
    echo "💡 输入 nvim-health 检查健康状态"
}

# 在终端启动时显示 Neovim 信息（可选）
# nvim-welcome

echo "✅ Neovim 0.12+ 配置已添加到 .zshrc"
echo "💡 重新启动终端或运行 'source ~/.zshrc' 以应用配置"
EOF

echo "🎉 配置完成！重新启动终端以应用更改。"
echo "💡 然后可以使用以下命令："
echo "   nvim-info     - 查看 Neovim 信息"
echo "   nvim-health   - 检查健康状态"
echo "   nvim-version  - 查看版本"