# 🦀 Rust 学习 Obsidian Vault

> 一个完整的 Rust 学习知识管理系统，帮助你系统化学习和掌握 Rust 编程语言

---

## 📖 简介

这是一个基于 Obsidian 构建的 Rust 学习知识库，采用**知识积累工作流**，帮助你：

- ✅ 系统化学习 Rust 语言
- ✅ 建立概念之间的连接
- ✅ 追踪学习进度
- ✅ 积累代码片段
- ✅ 记录问题和解决方案
- ✅ 复习和巩固知识

---

## 🚀 快速开始

### 1. 安装 Obsidian

如果你还没有安装 Obsidian：
- 访问 [https://obsidian.md/](https://obsidian.md/)
- 下载并安装适合你系统的版本

### 2. 打开这个 Vault

1. 启动 Obsidian
2. 选择 "Open folder as vault"
3. 选择这个 `rust_vault` 文件夹

### 3. 从这里开始 ⭐

打开这些文件开始你的 Rust 学习之旅：

1. **[[00-Index/Rust-MOC]]** - 📚 主知识地图（从这里开始！）
2. **[[00-Index/Learning-Roadmap]]** - 🗺️ 完整学习路线图
3. **[[00-Index/Setup-Guide]]** - ⚙️ Rust 环境设置指南

---

## 📁 文件夹结构

```
rust_vault/
├── 00-Index/                      # 索引和指南
│   ├── Rust-MOC.md                # 🌟 主知识地图（START HERE）
│   ├── Learning-Roadmap.md        # 学习路线图
│   └── Setup-Guide.md             # 环境设置指南
│
├── 01-Fundamentals/               # 基础概念
│   ├── Ownership.md               # 所有权（已创建示例）
│   ├── Borrowing.md
│   ├── Lifetimes.md
│   └── ...
│
├── 02-Advanced-Concepts/          # 进阶概念
│   ├── Traits.md
│   ├── Generics.md
│   ├── Smart-Pointers.md
│   └── ...
│
├── 03-Standard-Library/           # 标准库
│   ├── Collections/               # 集合类型
│   │   ├── Vec.md
│   │   ├── HashMap.md
│   │   └── ...
│   └── ...
│
├── 04-Ecosystem/                  # 生态系统
│   ├── Cargo.md
│   └── Crates/                    # 重要的 crate
│       ├── Serde.md
│       ├── Tokio.md
│       └── ...
│
├── 05-Patterns-and-Practices/     # 模式与实践
│   ├── Design-Patterns/
│   └── ...
│
├── 06-Projects/                   # 实战项目
│   ├── CLI-Tool.md
│   ├── Web-Server.md
│   └── ...
│
├── 07-Code-Snippets/              # 代码片段库
│   └── (按需创建代码片段)
│
├── 08-Daily-Learning/             # 每日学习日志
│   └── (按日期创建学习笔记)
│
├── 09-Questions-and-Answers/      # 疑难问题
│   └── (记录遇到的问题和解决方案)
│
└── 10-Templates/                  # 模板文件 ⭐
    ├── Concept-Template.md        # 概念笔记模板
    ├── Daily-Learning-Template.md # 每日学习模板
    └── Code-Snippet-Template.md   # 代码片段模板
```

---

## 💡 使用方法

### 日常学习流程

#### 1. **创建每日学习笔记**
```
1. 按 Ctrl/Cmd + N 创建新笔记
2. 保存到 08-Daily-Learning/ 文件夹
3. 命名格式：2024-01-15.md
4. 复制 [[10-Templates/Daily-Learning-Template]] 的内容
5. 填写今日学习内容
```

#### 2. **学习新概念时**
```
1. 在相应文件夹创建笔记（如 01-Fundamentals/）
2. 使用 [[10-Templates/Concept-Template]] 模板
3. 记录概念、代码示例、理解
4. 使用 [[双链]] 连接相关概念
5. 添加标签便于搜索
```

#### 3. **保存有用的代码片段**
```
1. 在 07-Code-Snippets/ 创建笔记
2. 使用 [[10-Templates/Code-Snippet-Template]]
3. 记录代码、用途、使用场景
4. 链接到相关概念笔记
```

#### 4. **遇到问题时**
```
1. 在 09-Questions-and-Answers/ 记录问题
2. 记录问题描述、尝试的解决方案
3. 记录最终解决方案
4. 链接到相关概念
```

---

## 🎯 核心功能

### 1. 双向链接 [[]]
使用 `[[笔记名称]]` 创建链接，建立知识网络：
```markdown
学习 [[Ownership]] 时，需要理解 [[Borrowing]] 和 [[Lifetimes]]
```

### 2. 标签系统 #
使用标签分类和筛选笔记：
```markdown
#rust #concept #ownership #fundamental
```

### 3. 图谱视图
- 按 Ctrl/Cmd + G 打开图谱视图
- 可视化笔记之间的连接关系
- 发现知识盲区

### 4. 搜索功能
- Ctrl/Cmd + Shift + F：全局搜索
- 搜索标签：`tag:#rust`
- 搜索路径：`path:01-Fundamentals`

---

## 📝 推荐的 Obsidian 插件

### 核心插件（内置，需启用）
- [x] Daily notes - 每日笔记
- [x] Templates - 模板系统
- [x] Graph view - 图谱视图
- [x] Backlinks - 反向链接

### 社区插件（推荐安装）

**基础增强**：
- **Calendar** - 日历视图，快速访问每日笔记
- **Dataview** - 数据查询，动态展示笔记
- **Templater** - 高级模板功能

**任务管理**：
- **Tasks** - 强大的任务管理
- **Kanban** - 看板式任务管理

**代码增强**：
- **Editor Syntax Highlight** - 更好的代码高亮
- **Code Block Enhancer** - 代码块增强

**其他实用**：
- **Excalidraw** - 画图工具
- **Obsidian Git** - Git 同步（如果需要版本控制）

---

## 🎨 使用技巧

### 1. 利用模板快速创建笔记
- 设置快捷键快速插入模板
- Settings → Templates → Template folder location: `10-Templates`

### 2. 建立知识连接
- 每个新概念至少链接 3 个相关概念
- 定期查看图谱，发现孤立笔记

### 3. 定期复习
- 使用复习记录追踪复习时间
- 采用间隔重复：1 天、3 天、7 天、30 天

### 4. 标签规范
建议使用的标签：
- **类型**：`#concept`, `#snippet`, `#project`, `#question`
- **难度**：`#easy`, `#medium`, `#hard`
- **状态**：`#learning`, `#understood`, `#mastered`
- **主题**：`#ownership`, `#concurrency`, `#async`

### 5. 项目管理
- 为每个实战项目创建笔记
- 记录项目需求、设计、实现、问题
- 链接用到的所有概念

---

## 📊 学习进度追踪

### 方法 1：使用 Dataview（需要插件）

在笔记中插入：
````markdown
```dataview
TABLE difficulty, status
FROM #concept
WHERE contains(file.folder, "01-Fundamentals")
SORT status DESC
```
````

### 方法 2：手动清单
在 [[00-Index/Rust-MOC]] 中维护学习清单

---

## 🔄 备份建议

**重要！定期备份你的学习成果！**

### 方法 1：使用 Git（推荐）
```bash
cd rust_vault
git init
git add .
git commit -m "Initial commit"
git remote add origin <your-repo-url>
git push -u origin main
```

### 方法 2：云同步
- 使用 Obsidian Sync（官方付费服务）
- 或将 vault 放在 OneDrive/Dropbox/iCloud

### 方法 3：定期压缩
```bash
# 定期创建备份
zip -r rust_vault_backup_$(date +%Y%m%d).zip rust_vault/
```

---

## 🎓 学习资源

### 必读资源（已内置到 Vault）
- [[00-Index/Learning-Roadmap|学习路线图]] - 完整的学习路径
- [[00-Index/Setup-Guide|环境设置指南]] - 搭建开发环境

### 外部资源
- [The Rust Book](https://doc.rust-lang.org/book/) - 官方入门书
- [Rust by Example](https://doc.rust-lang.org/rust-by-example/)
- [Rustlings](https://github.com/rust-lang/rustlings) - 交互式练习
- [Rust 标准库文档](https://doc.rust-lang.org/std/)

---

## ❓ 常见问题

### Q: 我是 Obsidian 新手，从哪里开始？
**A**: 
1. 先打开 [[00-Index/Rust-MOC]]，这是你的起点
2. 阅读 [[00-Index/Learning-Roadmap]] 了解学习计划
3. 创建第一个每日笔记，开始记录学习

### Q: 如何使用模板？
**A**:
1. 创建新笔记
2. 打开对应的模板文件（在 10-Templates/）
3. 复制模板内容到新笔记
4. 填写你的内容

### Q: 笔记太多了，如何组织？
**A**:
- 使用文件夹分类
- 使用标签筛选
- 使用 MOC（Map of Content）索引
- 定期清理不需要的笔记

### Q: 我可以修改文件夹结构吗？
**A**: 
当然可以！这个结构只是建议。根据你的需求自由调整。

---

## 🤝 贡献

这个 Vault 是为你的学习设计的，欢迎：
- 添加新的概念笔记
- 改进模板
- 分享你的学习心得
- 创建更多代码示例

---

## 📜 许可

这个 Vault 结构和模板可以自由使用、修改和分享。

---

## 🌟 开始学习！

**下一步行动**：
1. ✅ 打开 [[00-Index/Rust-MOC]]
2. ✅ 阅读 [[00-Index/Learning-Roadmap]]
3. ✅ 按照 [[00-Index/Setup-Guide]] 设置环境
4. ✅ 创建你的第一个每日笔记
5. ✅ 开始学习第一个概念 [[01-Fundamentals/Ownership]]

---

**祝你学习愉快！Remember: The Rust compiler is your friend! 🦀💪**

---

*最后更新: 2024-01-15*
*版本: 1.0.0*