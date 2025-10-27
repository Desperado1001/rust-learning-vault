---
tags: [rust, setup, guide, tools]
created: 2024-01-15
updated: 2024-01-15
---

# ⚙️ Rust 开发环境设置指南

> 从零开始搭建完整的 Rust 开发环境

---

## 📋 概览

本指南将帮助你：
- ✅ 安装 Rust 工具链
- ✅ 配置开发编辑器
- ✅ 安装必要的开发工具
- ✅ 验证环境是否正确设置

**预计时间**: 30-60 分钟

---

## 🦀 第一步：安装 Rust

### Windows 系统

#### 方法 1：使用 rustup-init.exe（推荐）

1. **下载安装器**
   - 访问 [https://rustup.rs/](https://rustup.rs/)
   - 下载 `rustup-init.exe`

2. **运行安装器**
   ```powershell
   # 双击运行 rustup-init.exe
   # 或在 PowerShell 中运行
   .\rustup-init.exe
   ```

3. **选择安装选项**
   - 默认选项通常是最好的
   - 按 `1` 然后回车继续默认安装

4. **安装 Visual Studio C++ Build Tools**（重要！）
   - Rust 在 Windows 上需要 MSVC 链接器
   - 访问 [Visual Studio 下载页面](https://visualstudio.microsoft.com/zh-hans/downloads/)
   - 下载 "Visual Studio 2022 生成工具"
   - 安装时选择 "使用 C++ 的桌面开发"

#### 方法 2：使用包管理器

```powershell
# 使用 Scoop
scoop install rustup

# 使用 Chocolatey
choco install rustup.install
```

---

### macOS 系统

1. **安装 Xcode Command Line Tools**（如果还没安装）
   ```bash
   xcode-select --install
   ```

2. **安装 Rust**
   ```bash
   curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
   ```

3. **按照提示完成安装**
   - 选择默认安装（按 1）

#### 使用 Homebrew（可选）
```bash
brew install rustup-init
rustup-init
```

---

### Linux 系统

1. **安装依赖**
   ```bash
   # Ubuntu/Debian
   sudo apt update
   sudo apt install build-essential curl

   # Fedora
   sudo dnf install curl gcc

   # Arch Linux
   sudo pacman -S curl gcc
   ```

2. **安装 Rust**
   ```bash
   curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
   ```

3. **配置环境变量**
   ```bash
   source $HOME/.cargo/env
   ```

---

## ✅ 验证安装

安装完成后，打开**新的**终端窗口，运行：

```bash
# 检查 Rust 编译器版本
rustc --version
# 输出示例: rustc 1.75.0 (82e1608df 2023-12-21)

# 检查 Cargo 版本
cargo --version
# 输出示例: cargo 1.75.0 (1d8b05cdd 2023-11-20)

# 检查 rustup 版本
rustup --version
# 输出示例: rustup 1.26.0 (5af9b9484 2023-04-05)
```

如果所有命令都正常输出版本号，恭喜！Rust 安装成功！🎉

---

## 🎨 第二步：配置开发编辑器

### 选项 1：Visual Studio Code（推荐）

**为什么选择 VS Code？**
- 免费开源
- 强大的 Rust 支持
- 丰富的插件生态
- 跨平台

#### 安装 VS Code
1. 下载：[https://code.visualstudio.com/](https://code.visualstudio.com/)
2. 安装并启动

#### 安装必要插件

**核心插件**：
1. **rust-analyzer** ⭐⭐⭐⭐⭐（必装！）
   - 代码补全
   - 类型提示
   - 错误检查
   - 重构支持
   
   ```
   扩展 ID: rust-lang.rust-analyzer
   ```

2. **Even Better TOML**
   - Cargo.toml 语法高亮
   
   ```
   扩展 ID: tamasfe.even-better-toml
   ```

3. **CodeLLDB**
   - 调试支持
   
   ```
   扩展 ID: vadimcn.vscode-lldb
   ```

4. **crates**
   - 管理 Cargo.toml 中的依赖版本
   
   ```
   扩展 ID: serayuzgur.crates
   ```

**可选插件**：
- **Error Lens** - 行内显示错误
- **Better Comments** - 注释增强
- **GitLens** - Git 增强

#### VS Code 配置

创建 `.vscode/settings.json`：

```json
{
  "rust-analyzer.checkOnSave.command": "clippy",
  "rust-analyzer.cargo.features": "all",
  "editor.formatOnSave": true,
  "[rust]": {
    "editor.defaultFormatter": "rust-lang.rust-analyzer"
  }
}
```

---

### 选项 2：RustRover（JetBrains 新 IDE）

**特点**：
- 专为 Rust 设计
- 强大的代码分析
- 内置调试器

**下载**：[https://www.jetbrains.com/rust/](https://www.jetbrains.com/rust/)

---

### 选项 3：其他编辑器

#### Vim/Neovim
```vim
" 安装 rust.vim
Plug 'rust-lang/rust.vim'

" 使用 coc-rust-analyzer
:CocInstall coc-rust-analyzer
```

#### Emacs
```elisp
;; 使用 rust-mode 和 lsp-mode
(use-package rust-mode)
(use-package lsp-mode)
```

#### Sublime Text
- 安装 Rust Enhanced 插件
- 安装 LSP 和 LSP-rust-analyzer

---

## 🛠️ 第三步：安装开发工具

### 1. rustfmt（代码格式化）

```bash
# 安装（通常已随 rustup 安装）
rustup component add rustfmt

# 使用
cargo fmt
```

**配置** `rustfmt.toml`：
```toml
max_width = 100
tab_spaces = 4
edition = "2021"
```

---

### 2. Clippy（代码检查）

```bash
# 安装
rustup component add clippy

# 使用
cargo clippy

# 更严格的检查
cargo clippy -- -D warnings
```

---

### 3. rust-src（标准库源码）

用于代码补全和跳转定义：

```bash
rustup component add rust-src
```

---

### 4. cargo-watch（自动编译）

```bash
# 安装
cargo install cargo-watch

# 使用：文件变化时自动运行
cargo watch -x run
cargo watch -x test
cargo watch -x check
```

---

### 5. cargo-edit（依赖管理）

```bash
# 安装
cargo install cargo-edit

# 使用
cargo add serde          # 添加依赖
cargo rm serde           # 移除依赖
cargo upgrade            # 升级依赖
```

---

### 6. cargo-expand（宏展开）

```bash
# 安装
cargo install cargo-expand

# 使用：查看宏展开后的代码
cargo expand
```

---

### 7. bacon（快速反馈）

```bash
# 安装
cargo install bacon

# 使用：实时显示编译错误
bacon
```

---

## 🎯 第四步：创建第一个项目

### 创建新项目

```bash
# 创建二进制项目（可执行程序）
cargo new hello_rust
cd hello_rust

# 或创建库项目
cargo new --lib my_library
```

### 项目结构

```
hello_rust/
├── Cargo.toml          # 项目配置文件
└── src/
    └── main.rs         # 主程序入口
```

### 编写代码

`src/main.rs`:
```rust
fn main() {
    println!("Hello, Rust! 🦀");
}
```

### 运行项目

```bash
# 编译并运行
cargo run

# 只编译
cargo build

# 发布版本（优化）
cargo build --release

# 检查代码（不生成可执行文件，更快）
cargo check
```

---

## 📚 常用 Cargo 命令

```bash
# 项目管理
cargo new <name>        # 创建新项目
cargo init              # 在当前目录初始化项目
cargo build             # 编译项目
cargo run               # 编译并运行
cargo test              # 运行测试
cargo bench             # 运行性能测试
cargo doc --open        # 生成并打开文档

# 代码质量
cargo check             # 快速检查编译错误
cargo fmt               # 格式化代码
cargo clippy            # 代码检查

# 依赖管理
cargo add <crate>       # 添加依赖（需要 cargo-edit）
cargo update            # 更新依赖
cargo tree              # 显示依赖树

# 清理
cargo clean             # 删除 target 目录
```

---

## 🔧 配置 Cargo

### 加速编译（国内用户）

创建 `~/.cargo/config.toml`（或 `~/.cargo/config`）：

```toml
# 使用国内镜像源
[source.crates-io]
replace-with = 'ustc'

[source.ustc]
registry = "https://mirrors.ustc.edu.cn/crates.io-index"

# 或使用字节跳动镜像
[source.rsproxy]
registry = "https://rsproxy.cn/crates.io-index"

# 或使用清华镜像
[source.tuna]
registry = "https://mirrors.tuna.tsinghua.edu.cn/git/crates.io-index.git"
```

### 优化编译速度

在项目的 `Cargo.toml` 中添加：

```toml
# 开发时使用快速编译
[profile.dev]
opt-level = 0
debug = true

# 发布时优化性能
[profile.release]
opt-level = 3
lto = true
codegen-units = 1

# 增量编译（默认开启）
[build]
incremental = true
```

---

## 🐛 调试配置

### VS Code 调试配置

创建 `.vscode/launch.json`：

```json
{
  "version": "0.2.0",
  "configurations": [
    {
      "type": "lldb",
      "request": "launch",
      "name": "Debug executable",
      "cargo": {
        "args": [
          "build",
          "--bin=${workspaceFolderBasename}",
          "--package=${workspaceFolderBasename}"
        ],
        "filter": {
          "name": "${workspaceFolderBasename}",
          "kind": "bin"
        }
      },
      "args": [],
      "cwd": "${workspaceFolder}"
    },
    {
      "type": "lldb",
      "request": "launch",
      "name": "Debug unit tests",
      "cargo": {
        "args": [
          "test",
          "--no-run",
          "--bin=${workspaceFolderBasename}",
          "--package=${workspaceFolderBasename}"
        ],
        "filter": {
          "name": "${workspaceFolderBasename}",
          "kind": "bin"
        }
      },
      "args": [],
      "cwd": "${workspaceFolder}"
    }
  ]
}
```

---

## ❓ 常见问题

### Q1: Windows 上提示找不到链接器

**问题**：
```
error: linker `link.exe` not found
```

**解决**：
安装 Visual Studio Build Tools，确保选择了 "使用 C++ 的桌面开发"

---

### Q2: 编译速度太慢

**解决方案**：
1. 使用 `cargo check` 代替 `cargo build`
2. 使用增量编译（默认开启）
3. 使用 `cargo-watch` 自动编译
4. 减少依赖项
5. 使用更快的链接器（如 lld 或 mold）

```toml
# 在 ~/.cargo/config.toml 中
[target.x86_64-pc-windows-msvc]
linker = "rust-lld.exe"

[target.x86_64-unknown-linux-gnu]
linker = "clang"
rustflags = ["-C", "link-arg=-fuse-ld=lld"]
```

---

### Q3: rust-analyzer 不工作

**解决方案**：
1. 重启 VS Code
2. 运行命令：`Rust Analyzer: Restart Server`
3. 确保项目根目录有 `Cargo.toml`
4. 更新 rust-analyzer：`rustup update`

---

### Q4: 如何更新 Rust？

```bash
# 更新到最新稳定版
rustup update

# 切换版本
rustup default stable      # 稳定版
rustup default nightly     # 每夜版
rustup default beta        # 测试版
```

---

### Q5: 如何卸载 Rust？

```bash
rustup self uninstall
```

---

## 🌐 镜像源选择（国内用户）

### 推荐镜像源

1. **字节跳动** - 速度快，稳定
   ```
   https://rsproxy.cn/
   ```

2. **中科大 USTC** - 老牌镜像
   ```
   https://mirrors.ustc.edu.cn/
   ```

3. **清华大学 TUNA**
   ```
   https://mirrors.tuna.tsinghua.edu.cn/
   ```

### 完整配置示例

`~/.cargo/config.toml`:
```toml
[source.crates-io]
replace-with = 'rsproxy'

[source.rsproxy]
registry = "https://rsproxy.cn/crates.io-index"

[registries.rsproxy]
index = "https://rsproxy.cn/crates.io-index"

[net]
git-fetch-with-cli = true
```

---

## ✅ 验证环境完整性

运行以下脚本验证所有工具：

```bash
#!/bin/bash

echo "🦀 检查 Rust 环境..."
echo ""

# 检查 rustc
if command -v rustc &> /dev/null; then
    echo "✅ rustc: $(rustc --version)"
else
    echo "❌ rustc 未安装"
fi

# 检查 cargo
if command -v cargo &> /dev/null; then
    echo "✅ cargo: $(cargo --version)"
else
    echo "❌ cargo 未安装"
fi

# 检查 rustup
if command -v rustup &> /dev/null; then
    echo "✅ rustup: $(rustup --version)"
else
    echo "❌ rustup 未安装"
fi

# 检查 rustfmt
if rustup component list | grep -q "rustfmt.*installed"; then
    echo "✅ rustfmt 已安装"
else
    echo "❌ rustfmt 未安装"
fi

# 检查 clippy
if rustup component list | grep -q "clippy.*installed"; then
    echo "✅ clippy 已安装"
else
    echo "❌ clippy 未安装"
fi

# 检查 rust-src
if rustup component list | grep -q "rust-src.*installed"; then
    echo "✅ rust-src 已安装"
else
    echo "❌ rust-src 未安装"
fi

echo ""
echo "环境检查完成！"
```

---

## 🎓 下一步

环境设置完成后：

1. 📖 开始学习：[[00-Index/Learning-Roadmap|学习路线图]]
2. 📝 创建第一个项目：[[06-Projects/CLI-Tool|CLI 工具项目]]
3. 🦀 阅读官方书：[The Rust Book](https://doc.rust-lang.org/book/)
4. 💪 开始练习：[Rustlings](https://github.com/rust-lang/rustlings)

---

## 🔗 相关资源

### 官方文档
- [Rust 官方网站](https://www.rust-lang.org/)
- [Rust 安装指南](https://www.rust-lang.org/tools/install)
- [Cargo Book](https://doc.rust-lang.org/cargo/)

### 工具文档
- [rust-analyzer 手册](https://rust-analyzer.github.io/)
- [Clippy 文档](https://doc.rust-lang.org/clippy/)
- [rustfmt 配置](https://rust-lang.github.io/rustfmt/)

### 社区
- [Rust 中文社区](https://rust.cc/)
- [Rust 用户论坛](https://users.rust-lang.org/)

---

**环境搭建完成！开始你的 Rust 之旅吧！** 🚀🦀

---

#rust #setup #tools #guide #getting-started