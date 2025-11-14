# 如何安装 Rustup

Rustup 是 Rust 编程语言的官方工具链管理器，它让你能够安装、管理和切换不同版本的 Rust 编译器和工具链。对于解决你当前遇到的 Tauri 开发中的链接错误问题，安装 rustup 是一个非常好的解决方案。

## Windows 上安装 Rustup 的详细步骤

### 方法一：使用官方安装程序（推荐）

1. **下载安装程序**：
    
    - 访问 Rust 官方网站的下载页面：https://www.rust-lang.org/tools/install
    - 页面会自动检测你的操作系统并提供相应的下载选项
    - 点击下载 Windows 版本的安装程序（rustup-init.exe）
2. **运行安装程序**：
    
    - 双击下载的 rustup-init.exe 文件
    - 这会打开一个命令行窗口，显示安装选项
3. **选择安装选项**：
    
    - 对于初次使用，建议选择默认安装选项（输入 1 并按 Enter）
    - 默认情况下，rustup 会安装最新的稳定版 Rust，以及 MSVC 工具链（这对于 Tauri 开发非常重要）
4. **等待安装完成**：
    
    - 安装程序会下载并安装 Rust 编译器、标准库和其他工具
    - 安装完成后，它会告诉你 Rust 已成功安装
5. **重启命令行或终端**：
    
    - 关闭并重新打开命令提示符或 PowerShell，使环境变量更改生效

### 方法二：使用 PowerShell 脚本安装

如果你更喜欢使用命令行，可以通过 PowerShell 使用以下命令安装：

1. **打开 PowerShell**（以管理员身份运行会更好）
    
2. **执行以下命令**：
    
    ```powershell
    Invoke-WebRequest https://static.rust-lang.org/rustup/dist/x86_64-pc-windows-msvc/rustup-init.exe -OutFile rustup-init.exe
    .\rustup-init.exe
    ```
    
3. **按照屏幕上的提示进行操作**，与方法一的步骤 3-5 相同
    

## 验证安装

安装完成后，重新打开命令提示符或 PowerShell，然后运行以下命令来验证 rustup 是否正确安装：

```
rustup --version
rustc --version
cargo --version
```

这些命令应该都能显示相应的版本信息，说明 Rust 工具链已经安装成功。

## 解决 Tauri 的链接问题

安装完 rustup 后，你可以切换到 MSVC 工具链，这将解决你之前遇到的链接错误：

```
rustup default stable-msvc
rustup target add x86_64-pc-windows-msvc
```

然后在你的 Tauri 项目目录中，清理并重新构建项目：

```
cargo clean
cargo tauri dev
```

## 为什么需要 Rustup？

Rustup 不仅可以帮助你安装 Rust，还允许你：

- 轻松切换不同的 Rust 版本（稳定版、测试版、每夜版）
- 安装不同的目标平台编译支持
- 管理 Rust 组件（如 rustfmt、clippy）
- 保持 Rust 更新到最新版本

对于 Windows 上的 Tauri 开发，Rustup 特别有用，因为它可以帮助你正确设置 MSVC 工具链，这对避免你目前遇到的链接错误至关重要。

需要帮助解决安装过程中的任何问题吗？