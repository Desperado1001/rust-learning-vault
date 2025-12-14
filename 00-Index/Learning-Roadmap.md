---
tags: [rust, roadmap, learning-path, guide]
created: 2024-01-15
updated: 2024-01-15
---

# 🗺️ Rust 学习路线图

> 从零基础到精通 Rust 的完整学习路径

---

## 📋 总体规划

**预计总时长**: 3-6 个月（每天 1-2 小时）
**学习方式**: 理论学习 + 实战练习
**核心原则**: 循序渐进，不跳步，多动手

---

## 🎯 阶段划分

```
第一阶段：入门基础（2-3 周）
    ↓
第二阶段：核心概念（4-6 周）
    ↓
第三阶段：进阶特性（4-6 周）
    ↓
第四阶段：实战项目（4-8 周）
    ↓
第五阶段：深入精通（持续）
```

---

## 📚 第一阶段：入门基础（Week 1-3）

### 🎯 学习目标
- [x] 安装 Rust 开发环境
- [x] 理解基本语法
- [ ] 能够编写简单程序
- [ ] 完成 "Hello, World!" 到基本计算器

### 📖 学习内容

#### Week 1: 环境搭建与基础语法
**时间分配**: 7-10 小时

**Day 1-2: 环境搭建**
- [ ] 安装 Rust（rustup）
- [ ] 配置 IDE（VS Code + rust-analyzer）
- [ ] 学习 Cargo 基本命令
- [ ] 创建第一个项目：`cargo new hello_world`

**阅读材料**:
- The Rust Book Chapter 1: Getting Started
- 笔记：[[00-Index/Setup-Guide|环境设置指南]]

**Day 3-5: 基础语法**
- [ ] 变量与可变性 [[01-Fundamentals/Variables-and-Mutability]]
- [ ] 数据类型 [[01-Fundamentals/Data-Types]]
- [ ] 函数 [[01-Fundamentals/Functions]]
- [ ] 注释与文档

**练习**:
```rust
// 练习 1: 温度转换器
fn celsius_to_fahrenheit(c: f64) -> f64 {
    c * 9.0 / 5.0 + 32.0
}

// 练习 2: 斐波那契数列
fn fibonacci(n: u32) -> u32 {
    // 实现递归或迭代版本
}
```

**Day 6-7: 控制流**
- [ ] if/else 表达式 [[01-Fundamentals/Control-Flow]]
- [ ] 循环（loop, while, for）
- [ ] match 表达式 [[01-Fundamentals/Pattern-Matching]]

**小项目**: 猜数字游戏
- The Rust Book Chapter 2
- 实现完整的交互式猜数字游戏

---

#### Week 2: 复合数据类型
**时间分配**: 8-10 小时

**Day 1-3: 所有权系统（重点！）**
- [ ] 理解所有权三规则 [[01-Fundamentals/Ownership]]
- [ ] 引用与借用 [[01-Fundamentals/Borrowing]]
- [ ] Slice 类型

**阅读材料**:
- The Rust Book Chapter 4
- 反复阅读直到理解！

**关键练习**:
```rust
// 练习：理解所有权转移
fn main() {
    let s1 = String::from("hello");
    let len = calculate_length(&s1);
    println!("'{}' 的长度是 {}", s1, len);
}

fn calculate_length(s: &String) -> usize {
    s.len()
}
```

**Day 4-5: 结构体**
- [ ] 定义和实例化结构体 [[01-Fundamentals/Structs-and-Enums]]
- [ ] 方法语法（impl 块）
- [ ] 关联函数

**Day 6-7: 枚举与模式匹配**
- [ ] 枚举定义
- [ ] Option<T> 类型
- [ ] match 控制流
- [ ] if let 语法糖

**小项目**: 简单的任务管理器
- 使用结构体和枚举
- 实现增删改查功能

---

#### Week 3: 模块与错误处理
**时间分配**: 8-10 小时

**Day 1-3: 模块系统**
- [ ] 包、Crate、模块 [[01-Fundamentals/Modules-and-Crates]]
- [ ] use 关键字
- [ ] 私有性规则
- [ ] 文件系统组织

**Day 4-7: 错误处理**
- [ ] panic! 宏
- [ ] Result<T, E> 类型 [[02-Advanced-Concepts/Error-Handling]]
- [ ] ? 操作符
- [ ] 自定义错误类型

**阶段评估**:
- [ ] 完成 Rustlings 前 30 个练习
- [ ] 能够独立编写 100 行以上的程序
- [ ] 理解所有权和借用的基本概念

---

## 🚀 第二阶段：核心概念深化（Week 4-9）

### 🎯 学习目标
- [ ] 深入理解所有权系统
- [ ] 掌握生命周期
- [ ] 熟练使用泛型和 trait
- [ ] 理解闭包和迭代器

### 📖 学习内容

#### Week 4-5: 集合与字符串
**时间分配**: 10-12 小时

**集合类型**:
- [ ] Vector [[03-Standard-Library/Collections/Vec]]
- [ ] String [[03-Standard-Library/Collections/String]]
- [ ] HashMap [[03-Standard-Library/Collections/HashMap]]
- [ ] HashSet [[03-Standard-Library/Collections/HashSet]]

**练习项目**: 文本分析器
- 统计单词频率
- 查找最常见的单词
- 使用 HashMap

---

#### Week 6-7: 泛型、Trait 和生命周期
**时间分配**: 12-15 小时

**Week 6: 泛型和 Trait**
- [ ] 泛型函数和结构体 [[02-Advanced-Concepts/Generics]]
- [ ] Trait 定义和实现 [[02-Advanced-Concepts/Traits]]
- [ ] Trait Bound
- [ ] Trait Object

**The Rust Book Chapter 10**

**Week 7: 生命周期（难点！）**
- [ ] 生命周期标注 [[01-Fundamentals/Lifetimes]]
- [ ] 函数中的生命周期
- [ ] 结构体中的生命周期
- [ ] 生命周期省略规则

**重点理解**:
```rust
// 生命周期标注示例
fn longest<'a>(x: &'a str, y: &'a str) -> &'a str {
    if x.len() > y.len() {
        x
    } else {
        y
    }
}
```

---

#### Week 8: 闭包和迭代器
**时间分配**: 10-12 小时

**闭包**:
- [ ] 闭包定义和使用 [[03-Standard-Library/Closures]]
- [ ] 闭包类型推断
- [ ] Fn、FnMut、FnOnce trait

**迭代器**:
- [ ] Iterator trait [[03-Standard-Library/Iterators]]
- [ ] 迭代器适配器（map, filter, collect）
- [ ] 自定义迭代器

**练习**: 使用迭代器重写之前的项目

---

#### Week 9: 智能指针
**时间分配**: 10-12 小时

- [ ] Box<T> [[02-Advanced-Concepts/Smart-Pointers]]
- [ ] Rc<T> 和 Arc<T>
- [ ] RefCell<T>
- [ ] 循环引用和 Weak<T>

**The Rust Book Chapter 15**

**小项目**: 实现简单的链表或树结构

**阶段评估**:
- [ ] 完成 Rustlings 前 60 个练习
- [ ] 能够解释生命周期的工作原理
- [ ] 能够使用泛型和 trait 编写可复用代码

---

## 💎 第三阶段：进阶特性（Week 10-15）

### 🎯 学习目标
- [ ] 掌握并发编程
- [ ] 理解异步编程
- [ ] 学会使用宏
- [ ] 了解 unsafe Rust

### 📖 学习内容

#### Week 10-11: 并发编程
**时间分配**: 12-15 小时

**Week 10: 线程基础**
- [ ] 线程创建 [[02-Advanced-Concepts/Concurrency]]
- [ ] 消息传递（channel）
- [ ] 共享状态（Mutex, Arc）

**Week 11: 并发模式**
- [ ] Send 和 Sync trait
- [ ] 并发安全设计
- [ ] 避免数据竞争

**The Rust Book Chapter 16**

**项目**: 多线程 Web 服务器

---

#### Week 12-13: 异步编程
**时间分配**: 12-15 小时

- [ ] async/await 语法 [[02-Advanced-Concepts/Async-Await]]
- [ ] Future trait
- [ ] Tokio 运行时 [[04-Ecosystem/Crates/Tokio]]
- [ ] 异步错误处理

**学习资源**:
- [Async Book](https://rust-lang.github.io/async-book/)
- Tokio 官方教程

**项目**: 异步 HTTP 客户端

---

#### Week 14: 宏编程
**时间分配**: 10-12 小时

- [ ] 声明宏（macro_rules!）[[02-Advanced-Concepts/Macros]]
- [ ] 过程宏基础
- [ ] 常用宏模式

**The Rust Book Chapter 19.6**

---

#### Week 15: Unsafe Rust
**时间分配**: 8-10 小时

- [ ] 何时需要 unsafe [[02-Advanced-Concepts/Unsafe-Rust]]
- [ ] 原始指针
- [ ] unsafe 函数和 trait
- [ ] FFI 基础

**The Rust Book Chapter 19.1**

**重要**: 只在必要时使用 unsafe！

**阶段评估**:
- [ ] 完成 Rustlings 所有练习
- [ ] 能够编写并发程序
- [ ] 理解异步编程模型
- [ ] 能够阅读和理解中等复杂度的 Rust 代码

---

## 🛠️ 第四阶段：实战项目（Week 16-23）

### 🎯 学习目标
- [ ] 完成至少 3 个完整项目
- [ ] 熟悉 Rust 生态系统
- [ ] 学会测试和文档编写
- [ ] 掌握性能优化技巧

### 📖 学习内容

#### Week 16-17: 生态系统探索
**时间分配**: 10-12 小时

**重要 Crates 学习**:
- [ ] Serde（序列化）[[04-Ecosystem/Crates/Serde]]
- [ ] Clap（CLI 参数）[[04-Ecosystem/Crates/Clap]]
- [ ] Reqwest（HTTP 客户端）
- [ ] Anyhow/Thiserror（错误处理）

**测试与文档**:
- [ ] 单元测试 [[04-Ecosystem/Testing]]
- [ ] 集成测试
- [ ] 文档注释
- [ ] 示例代码

---

#### Week 18-19: 项目 1 - CLI 工具
**项目**: 功能完整的命令行工具

**推荐项目**:
- [ ] 文件搜索工具（类似 grep）
- [ ] JSON 处理工具
- [ ] 待办事项管理器
- [ ] Markdown 转换器

**技能要点**:
- 命令行参数解析（clap）
- 文件 I/O
- 错误处理
- 用户交互

**参考**: [[06-Projects/CLI-Tool]]

---

#### Week 20-21: 项目 2 - Web 应用
**项目**: Web 服务器或 API

**推荐框架**:
- Actix-Web [[04-Ecosystem/Crates/Actix-Web]]
- Axum
- Rocket

**功能要求**:
- [ ] RESTful API 设计
- [ ] 数据库集成（Diesel/SQLx）
- [ ] 路由和中间件
- [ ] JSON 序列化
- [ ] 错误处理

**参考**: [[06-Projects/Web-Server]]

---

#### Week 22-23: 项目 3 - 自选方向

**后端方向**:
- 完整的 Web API + 数据库
- 微服务架构
- GraphQL 服务

**系统编程方向**:
- 文件系统工具
- 网络代理
- 简易数据库

**异步方向**:
- 聊天服务器 [[06-Projects/Async-Chat-App]]
- 爬虫框架
- 异步任务队列

**游戏/GUI 方向**:
- 游戏引擎（Bevy）
- GUI 应用（egui, iced）

**阶段评估**:
- [ ] 完成 3 个以上完整项目
- [ ] 代码有良好的测试覆盖
- [ ] 代码符合 Rust 惯用法
- [ ] 能够独立设计和实现中型项目

---

## 🌟 第五阶段：深入精通（持续学习）

### 🎯 学习目标
- [ ] 深入理解编译器和类型系统
- [ ] 掌握高级设计模式
- [ ] 性能优化和调优
- [ ] 参与开源贡献

### 📖 学习方向

#### 深入主题

**编译器内部**:
- [ ] 理解借用检查器
- [ ] 类型系统深入
- [ ] 宏展开过程

**高级模式**:
- [ ] 类型状态模式 [[05-Patterns-and-Practices/Design-Patterns/Type-State-Pattern]]
- [ ] Newtype 模式 [[05-Patterns-and-Practices/Design-Patterns/Newtype-Pattern]]
- [ ] RAII 模式 [[05-Patterns-and-Practices/Design-Patterns/RAII-Pattern]]
- [ ] 零成本抽象

**性能优化**:
- [ ] Profiling 工具 [[05-Patterns-and-Practices/Performance-Tips]]
- [ ] 内存布局优化
- [ ] 并发性能调优
- [ ] SIMD 和底层优化

**开源贡献**:
- [ ] 阅读知名项目源码
- [ ] 提交 PR 修复 bug
- [ ] 实现新功能
- [ ] 编写技术博客

---

## 📊 学习资源汇总

### 📚 必读书籍
1. **The Rust Programming Language** (The Rust Book) ⭐⭐⭐⭐⭐
2. **Rust by Example** ⭐⭐⭐⭐⭐
3. **Programming Rust** by O'Reilly ⭐⭐⭐⭐
4. **Rust for Rustaceans** by Jon Gjengset ⭐⭐⭐⭐

### 🎥 视频教程
- [Rust 官方 YouTube](https://www.youtube.com/c/RustVideos)
- [Jon Gjengset - Crust of Rust 系列](https://www.youtube.com/c/JonGjengset)
- [Let's Get Rusty](https://www.youtube.com/c/LetsGetRusty)

### 🏋️ 练习平台
- [Rustlings](https://github.com/rust-lang/rustlings) - 交互式练习
- [Exercism Rust Track](https://exercism.org/tracks/rust) - 编程练习
- [LeetCode](https://leetcode.com/) - 算法题（用 Rust 解）

### 🌐 社区资源
- [Rust 官方论坛](https://users.rust-lang.org/)
- [r/rust Reddit](https://www.reddit.com/r/rust/)
- [This Week in Rust](https://this-week-in-rust.org/) - 周刊

---

## ✅ 里程碑检查清单

### 第一个月
- [ ] 完成 The Rust Book 前 10 章
- [ ] 完成 Rustlings 前 40 个练习
- [ ] 理解所有权、借用、生命周期
- [ ] 编写至少 5 个小程序

### 第二个月
- [ ] 完成 The Rust Book
- [ ] 完成 Rustlings 全部练习
- [ ] 掌握泛型、trait、迭代器
- [ ] 完成 1 个中型项目

### 第三个月
- [ ] 学会并发和异步编程
- [ ] 完成 2-3 个完整项目
- [ ] 能够阅读中等难度的开源项目
- [ ] 开始参与开源贡献

---

## 💡 学习建议

### ✅ DO（推荐做法）

1. **每天坚持**
   - 每天至少 1 小时
   - 宁可少而精，不要三天打鱼

2. **动手实践**
   - 不要只看不写
   - 每个概念都要敲代码验证
   - 编译错误是最好的老师

3. **理解而非记忆**
   - 理解所有权的"为什么"
   - 不要死记硬背语法

4. **循序渐进**
   - 不要跳过基础
   - 所有权是必须攻克的关卡

5. **记录笔记**
   - 使用本 Obsidian vault
   - 建立知识连接
   - 定期复习

### ❌ DON'T（避免的坑）

1. **不要急于求成**
   - Rust 学习曲线陡峭是正常的
   - 不要因为编译错误而气馁

2. **不要只看不练**
   - 看懂 ≠ 会写
   - 必须动手实践

3. **不要跳过所有权**
   - 这是 Rust 的核心
   - 后面所有内容都基于此

4. **不要孤军奋战**
   - 加入社区
   - 问问题、分享经验

5. **不要过早优化**
   - 先让代码跑起来
   - 再考虑性能

---

## 🎯 进度追踪

### 当前阶段
- **阶段**: 第一阶段 - 入门基础
- **周数**: Week 1
- **进度**: 0%

### 学习统计
- **开始日期**: 2024-01-15
- **学习天数**: 0
- **完成项目数**: 0
- **代码行数**: 0

### 下一步行动
- [ ] 安装 Rust 环境
- [ ] 创建第一个 Hello World
- [ ] 阅读 The Rust Book Chapter 1

---

## 🔗 相关笔记

- [[00-Index/Rust-MOC|Rust 知识地图]]
- [[00-Index/Setup-Guide|环境设置指南]]
- [[10-Templates/Daily-Learning-Template|每日学习模板]]

---

**记住**: Rust 很难，但值得！坚持下去，你会爱上它的！🦀💪

---

#rust #roadmap #learning-path #guide