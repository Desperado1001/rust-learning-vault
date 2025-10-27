---
tags: [rust, index, moc, start-here]
created: 2024-01-15
updated: 2024-01-15
---

# 🦀 Rust 学习知识地图

> 欢迎来到我的 Rust 学习中心！这里是所有笔记的索引入口。

## 🎯 当前学习阶段

**阶段**: 🌱 入门阶段 → 基础概念
**进度**: 开始学习
**当前专注**: 设置学习环境，理解基本概念

---

## 📚 知识体系

### 🔰 基础概念（Fundamentals）

**核心三要素** ⭐⭐⭐
- [[01-Fundamentals/Ownership|Ownership]] - 所有权系统（Rust 最重要的特性）
- [[01-Fundamentals/Borrowing|Borrowing]] - 借用规则
- [[01-Fundamentals/Lifetimes|Lifetimes]] - 生命周期

**语言基础**
- [[01-Fundamentals/Variables-and-Mutability|Variables and Mutability]] - 变量与可变性
- [[01-Fundamentals/Data-Types|Data Types]] - 数据类型
- [[01-Fundamentals/Functions|Functions]] - 函数
- [[01-Fundamentals/Control-Flow|Control Flow]] - 控制流
- [[01-Fundamentals/Pattern-Matching|Pattern Matching]] - 模式匹配
- [[01-Fundamentals/Structs-and-Enums|Structs and Enums]] - 结构体与枚举
- [[01-Fundamentals/Modules-and-Crates|Modules and Crates]] - 模块与包管理

---

### 🚀 进阶概念（Advanced Concepts）

- [[02-Advanced-Concepts/Traits|Traits]] - 特质系统
- [[02-Advanced-Concepts/Generics|Generics]] - 泛型编程
- [[02-Advanced-Concepts/Smart-Pointers|Smart Pointers]] - 智能指针（Box, Rc, Arc, RefCell）
- [[02-Advanced-Concepts/Concurrency|Concurrency]] - 并发编程
- [[02-Advanced-Concepts/Async-Await|Async/Await]] - 异步编程
- [[02-Advanced-Concepts/Macros|Macros]] - 宏编程
- [[02-Advanced-Concepts/Unsafe-Rust|Unsafe Rust]] - 不安全代码
- [[02-Advanced-Concepts/Error-Handling|Error Handling]] - 错误处理

---

### 📦 标准库（Standard Library）

**集合类型**
- [[03-Standard-Library/Collections/Vec|Vec]] - 动态数组
- [[03-Standard-Library/Collections/HashMap|HashMap]] - 哈希表
- [[03-Standard-Library/Collections/String|String]] - 字符串
- [[03-Standard-Library/Collections/HashSet|HashSet]] - 哈希集合

**实用工具**
- [[03-Standard-Library/Option-and-Result|Option and Result]] - 选项与结果类型
- [[03-Standard-Library/Iterators|Iterators]] - 迭代器
- [[03-Standard-Library/IO|File I/O]] - 文件输入输出
- [[03-Standard-Library/Closures|Closures]] - 闭包

---

### 🛠️ 生态系统（Ecosystem）

**工具链**
- [[04-Ecosystem/Cargo|Cargo]] - 包管理器与构建工具
- [[04-Ecosystem/Rustfmt-and-Clippy|Rustfmt & Clippy]] - 代码格式化和检查
- [[04-Ecosystem/Testing|Testing]] - 测试框架

**重要 Crates**
- [[04-Ecosystem/Crates/Serde|Serde]] - 序列化/反序列化
- [[04-Ecosystem/Crates/Tokio|Tokio]] - 异步运行时
- [[04-Ecosystem/Crates/Actix-Web|Actix-Web]] - Web 框架
- [[04-Ecosystem/Crates/Diesel|Diesel]] - ORM 数据库工具
- [[04-Ecosystem/Crates/Clap|Clap]] - 命令行参数解析

---

### 🎨 设计模式与最佳实践

**设计模式**
- [[05-Patterns-and-Practices/Design-Patterns/Builder-Pattern|Builder Pattern]] - 构建者模式
- [[05-Patterns-and-Practices/Design-Patterns/Type-State-Pattern|Type State Pattern]] - 类型状态模式
- [[05-Patterns-and-Practices/Design-Patterns/RAII-Pattern|RAII Pattern]] - 资源获取即初始化
- [[05-Patterns-and-Practices/Design-Patterns/Newtype-Pattern|Newtype Pattern]] - 新类型模式

**最佳实践**
- [[05-Patterns-and-Practices/API-Design|API Design]] - API 设计
- [[05-Patterns-and-Practices/Performance-Tips|Performance Tips]] - 性能优化
- [[05-Patterns-and-Practices/Common-Pitfalls|Common Pitfalls]] - 常见陷阱
- [[05-Patterns-and-Practices/Idiomatic-Rust|Idiomatic Rust]] - 惯用 Rust 代码

---

### 💻 实战项目（Projects）

- [[06-Projects/CLI-Tool|CLI Tool]] - 命令行工具项目
- [[06-Projects/Web-Server|Web Server]] - Web 服务器项目
- [[06-Projects/Async-Chat-App|Async Chat App]] - 异步聊天应用
- [[06-Projects/Mini-Database|Mini Database]] - 简易数据库

---

## 🔗 重要连接

### 与其他语言对比
- [[09-Questions-and-Answers/Rust-vs-Cpp|Rust vs C++]]
- [[09-Questions-and-Answers/Rust-vs-Go|Rust vs Go]]
- [[09-Questions-and-Answers/From-JavaScript-to-Rust|From JavaScript to Rust]]
- [[09-Questions-and-Answers/From-Python-to-Rust|From Python to Rust]]

### 常见问题（FAQ）
- [[09-Questions-and-Answers/Why-No-Null|Why No Null?]] - 为什么没有 null？
- [[09-Questions-and-Answers/Why-No-Inheritance|Why No Inheritance?]] - 为什么没有继承？
- [[09-Questions-and-Answers/When-To-Clone|When To Clone?]] - 什么时候应该克隆？
- [[09-Questions-and-Answers/String-vs-str|String vs &str]] - 字符串类型的区别

---

## 📖 学习资源

### 官方资源
- [The Rust Book](https://doc.rust-lang.org/book/) - 官方入门书（必读）
- [Rust by Example](https://doc.rust-lang.org/rust-by-example/) - 通过示例学习
- [Rustlings](https://github.com/rust-lang/rustlings) - 交互式练习
- [Rust API 文档](https://doc.rust-lang.org/std/) - 标准库文档

### 学习笔记
- [[00-Index/The-Rust-Book-Notes|The Rust Book 笔记]]
- [[00-Index/Rust-By-Example-Notes|Rust by Example 笔记]]
- [[00-Index/Rustlings-Progress|Rustlings 练习进度]]

### 推荐视频
- [Rust 官方 YouTube 频道](https://www.youtube.com/c/RustVideos)
- [Jon Gjengset - Rust 深入讲解](https://www.youtube.com/c/JonGjengset)

### 社区
- [Rust 官方论坛](https://users.rust-lang.org/)
- [r/rust Reddit](https://www.reddit.com/r/rust/)
- [Rust 中文社区](https://rust.cc/)

---

## 🎯 学习计划

### 本周目标
- [ ] 阅读 The Rust Book Chapter 1-3
- [ ] 完成 Rustlings 前 10 个练习
- [ ] 创建第一个 "Hello, World!" 程序
- [ ] 理解变量与可变性概念

### 本月目标
- [ ] 完成 The Rust Book 基础部分（Chapter 1-10）
- [ ] 掌握所有权、借用、生命周期核心概念
- [ ] 构建第一个 CLI 工具项目
- [ ] 每天至少学习 1 小时

### 长期目标
- [ ] 完整读完 The Rust Book
- [ ] 完成至少 3 个实战项目
- [ ] 能够用 Rust 开发 Web 应用
- [ ] 贡献开源 Rust 项目

---

## 📊 学习统计

**总笔记数**: 0（刚开始！）
**已掌握概念**: 0
**正在学习**: 0
**待学习**: 无限可能 🚀

**最近更新**: 初始化 Vault

---

## 🔥 快速开始指南

### 新手必读
1. 📖 从 [[00-Index/Learning-Roadmap|学习路线图]] 开始
2. ⚙️ 查看 [[00-Index/Setup-Guide|环境设置指南]]
3. 📝 使用 [[10-Templates/Daily-Learning-Template|每日学习模板]] 记录进度
4. 💡 有疑问？查看 [[09-Questions-and-Answers/FAQ|FAQ]]

### 每日流程
1. 打开 [[08-Daily-Learning/今天的日期]] 创建每日笔记
2. 设定今日学习目标
3. 学习新概念，创建概念笔记
4. 完成代码练习，保存到 [[07-Code-Snippets/代码片段]]
5. 总结今日收获

---

## 📌 重要提醒

> 💡 **学习 Rust 的建议**：
> - Rust 的学习曲线较陡，但坚持就是胜利！
> - 多写代码，多编译，编译器是最好的老师
> - 所有权系统一开始会很困扰，这很正常
> - 加入社区，不要独自战斗
> - 享受 Rust 带来的"如果编译通过，就大概率正确"的安全感

---

## 🌟 灵感与动力

**为什么学习 Rust？**
- ⚡ 性能接近 C/C++
- 🛡️ 内存安全，无数据竞争
- 🔧 现代化的工具链
- 🌍 活跃的社区
- 💼 职业发展前景好

**学习进度追踪**
- 开始日期: 2024-01-15
- 当前天数: Day 1
- 连续学习天数: 1 🔥

---

**最后更新**: 2024-01-15
**下次复习**: 每周日晚上回顾本周学习内容

---

#rust #index #learning-path #start-here