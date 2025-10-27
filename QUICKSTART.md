# 🚀 5分钟快速开始指南

> 欢迎！这个指南将帮助你在 5 分钟内开始使用这个 Rust 学习 Vault。

---

## ⚡ 立即开始（2 分钟）

### 1. 打开主索引
点击或创建链接：**[[00-Index/Rust-MOC]]**

这是你的学习中心，所有内容的入口。

### 2. 查看学习路线
打开：**[[00-Index/Learning-Roadmap]]**

了解完整的学习计划，从入门到精通。

### 3. 设置开发环境
如果还没有安装 Rust，查看：**[[00-Index/Setup-Guide]]**

---

## 📅 第一天该做什么？

### ✅ 任务清单

- [ ] **安装 Rust**
  ```bash
  # 访问 https://rustup.rs/
  # 或运行（macOS/Linux）：
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
  ```

- [ ] **创建第一个每日学习笔记**
  1. 在 `08-Daily-Learning/` 创建新笔记
  2. 命名：`2024-01-15.md`（今天的日期）
  3. 复制 `10-Templates/Daily-Learning-Template.md` 的内容
  4. 填写今日目标

- [ ] **写第一个 Rust 程序**
  ```bash
  cargo new hello_rust
  cd hello_rust
  cargo run
  ```

- [ ] **学习第一个核心概念**
  阅读：**[[01-Fundamentals/Ownership]]**
  
  这是 Rust 最重要的概念！

---

## 📚 第一周学习路径

### Day 1-2：环境搭建
- [ ] 安装 Rust 和配置 IDE
- [ ] 完成 "Hello, World!"
- [ ] 阅读 The Rust Book Chapter 1-2

### Day 3-4：基础语法
- [ ] 学习变量、数据类型、函数
- [ ] 完成猜数字游戏
- [ ] 创建概念笔记

### Day 5-7：所有权系统
- [ ] **重点学习** [[01-Fundamentals/Ownership]]
- [ ] 理解借用和引用
- [ ] 完成 Rustlings 前 10 个练习

---

## 🎯 如何使用这个 Vault？

### 学习新概念时

1. **创建概念笔记**
   - 在相应文件夹（如 `01-Fundamentals/`）创建笔记
   - 使用模板：`10-Templates/Concept-Template.md`
   - 记录：概念、代码、理解

2. **建立连接**
   ```markdown
   学习 [[Ownership]] 需要理解 [[Borrowing]]
   ```

3. **添加标签**
   ```markdown
   #rust #concept #ownership #fundamental
   ```

### 每日学习流程

```
1. 打开今日笔记（08-Daily-Learning/日期.md）
   ↓
2. 设定学习目标
   ↓
3. 学习新内容 → 创建/更新概念笔记
   ↓
4. 写代码练习 → 保存到 07-Code-Snippets/
   ↓
5. 遇到问题 → 记录到 09-Questions-and-Answers/
   ↓
6. 总结今日收获
```

### 保存代码片段

1. 在 `07-Code-Snippets/` 创建笔记
2. 使用模板：`10-Templates/Code-Snippet-Template.md`
3. 记录代码、用途、使用场景

---

## 🔑 Obsidian 快捷键

### 必知快捷键

| 快捷键 | 功能 |
|--------|------|
| `Ctrl/Cmd + N` | 创建新笔记 |
| `Ctrl/Cmd + O` | 快速打开笔记 |
| `Ctrl/Cmd + P` | 命令面板 |
| `Ctrl/Cmd + G` | 打开图谱视图 |
| `[[` | 创建链接 |
| `Ctrl/Cmd + E` | 切换编辑/预览 |
| `Ctrl/Cmd + F` | 当前笔记搜索 |
| `Ctrl/Cmd + Shift + F` | 全局搜索 |

### 提示

- **双击笔记标题**：编辑标题
- **拖拽笔记**：移动到文件夹
- **右键链接**：在新窗格打开

---

## 📂 重要文件夹

```
🌟 必看：
├── 00-Index/              # 从这里开始！
│   ├── Rust-MOC.md        # ⭐ 主索引
│   ├── Learning-Roadmap.md
│   └── Setup-Guide.md

📝 学习：
├── 01-Fundamentals/       # 基础概念
├── 02-Advanced-Concepts/  # 进阶概念
├── 03-Standard-Library/   # 标准库

💻 实践：
├── 06-Projects/           # 实战项目
├── 07-Code-Snippets/      # 代码片段
├── 08-Daily-Learning/     # 每日笔记

🛠️ 工具：
└── 10-Templates/          # 模板文件
```

---

## 💡 学习建议

### ✅ 做这些

1. **每天学习 1-2 小时**
   - 保持连续性比单次长时间更有效

2. **多写代码**
   - 不要只看不写
   - 编译器是最好的老师

3. **记录笔记**
   - 用自己的话重写概念
   - 建立知识连接

4. **定期复习**
   - 查看笔记中的"复习记录"
   - 使用间隔重复

### ❌ 避免这些

1. **不要跳过基础**
   - 特别是所有权系统
   - 这是 Rust 的核心

2. **不要畏惧编译错误**
   - 错误信息很详细
   - 这是学习的机会

3. **不要孤军奋战**
   - 加入 Rust 社区
   - 提问、讨论、分享

---

## 🎓 推荐学习资源

### 官方资源（必读）

1. **[The Rust Book](https://doc.rust-lang.org/book/)**
   - 官方入门教程
   - 从头到尾完整阅读

2. **[Rust by Example](https://doc.rust-lang.org/rust-by-example/)**
   - 通过示例学习
   - 边看边练

3. **[Rustlings](https://github.com/rust-lang/rustlings)**
   - 交互式练习
   - 强烈推荐！

### 视频教程

- [Let's Get Rusty](https://www.youtube.com/c/LetsGetRusty)
- [Jon Gjengset](https://www.youtube.com/c/JonGjengset)

### 社区

- [Rust 中文社区](https://rust.cc/)
- [r/rust Reddit](https://www.reddit.com/r/rust/)
- [Rust 用户论坛](https://users.rust-lang.org/)

---

## 🚦 现在开始！

### 立即行动（按顺序）

1. ✅ **打开** [[00-Index/Rust-MOC]]
2. ✅ **阅读** [[00-Index/Learning-Roadmap]]
3. ✅ **设置环境** [[00-Index/Setup-Guide]]
4. ✅ **创建今日笔记** `08-Daily-Learning/今天.md`
5. ✅ **学习第一个概念** [[01-Fundamentals/Ownership]]

---

## 📊 进度追踪

### 本周目标

- [ ] 安装 Rust 环境
- [ ] 完成 Hello World
- [ ] 学习基础语法
- [ ] 理解所有权概念
- [ ] 完成 Rustlings 前 10 题

### 第一个月目标

- [ ] 完成 The Rust Book 前 10 章
- [ ] 完成 Rustlings 前 40 题
- [ ] 创建至少 10 个概念笔记
- [ ] 编写 5 个以上的小程序

---

## ❓ 需要帮助？

### 常见问题

**Q: 编译错误太多，很挫败？**
A: 这很正常！Rust 编译器严格但友好。仔细阅读错误信息，它会告诉你如何修复。

**Q: 所有权太难理解？**
A: 这是 Rust 最难的部分。多看几遍，多写代码，会突然开窍的！

**Q: 不知道从哪里开始？**
A: 从 [[00-Index/Rust-MOC]] 开始，按照 [[00-Index/Learning-Roadmap]] 一步步来。

### 获取帮助

- 查看 [[09-Questions-and-Answers/FAQ]]
- 搜索这个 Vault（Ctrl/Cmd + Shift + F）
- 在 Rust 论坛提问
- 加入 Discord/Telegram 群组

---

## 🎉 最后的话

**学习 Rust 是一段旅程**：
- 🐢 一开始会慢，这很正常
- 💪 坚持就是胜利
- 🎯 编译通过的代码通常是正确的
- 🦀 Rust 社区非常友好，别害怕提问

**记住**：每个 Rust 开发者都经历过与编译器"斗争"的阶段。你不是一个人！

---

**现在，打开 [[00-Index/Rust-MOC]]，开始你的 Rust 学习之旅吧！** 🚀🦀

---

#rust #quickstart #guide #getting-started

*最后更新: 2024-01-15*