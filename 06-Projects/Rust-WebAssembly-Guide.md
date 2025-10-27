---
tags: [rust, webassembly, wasm, web, frontend, tutorial]
created: 2024-01-15
updated: 2024-01-15
difficulty: ⭐⭐⭐⭐
---

# 🌐 Rust + WebAssembly 完整学习指南

> 使用 Rust 构建高性能 Web 应用的完整路径

---

## 📋 目录

- [WebAssembly 简介](#webassembly-简介)
- [为什么选择 Rust + WASM](#为什么选择-rust--wasm)
- [核心工具链](#核心工具链)
- [快速开始](#快速开始)
- [Web 框架](#web-框架)
- [实战项目](#实战项目)
- [性能优化](#性能优化)
- [最佳实践](#最佳实践)
- [学习路线](#学习路线)

---

## 🎯 WebAssembly 简介

### 什么是 WebAssembly？

WebAssembly (缩写为 Wasm) 是一种**二进制指令格式**，为堆栈式虚拟机设计，使代码能在浏览器中以接近原生的速度执行。

```
传统 Web 应用:
JavaScript → 浏览器解释执行 → 性能瓶颈

使用 WebAssembly:
Rust/C++/Go → 编译为 WASM → 浏览器原生执行 → 接近原生性能
```

### 核心特性

**1. 高性能**
- 接近原生代码的执行速度
- 二进制格式，解析快速
- 可预测的性能

**2. 安全性**
- 在沙箱环境中运行
- 内存隔离
- 无法直接访问系统资源

**3. 跨平台**
- 所有现代浏览器支持
- 统一的标准规范
- 一次编译，到处运行

**4. 语言无关**
- 支持多种编程语言
- Rust、C、C++、Go、AssemblyScript 等
- Rust 是最受欢迎的 WASM 语言

### 应用场景

```
✅ 性能密集型应用
├─ 图像/视频处理
├─ 游戏引擎
├─ 音频处理
└─ 科学计算

✅ 现有代码移植
├─ C/C++ 库移植到 Web
├─ 游戏引擎（Unity, Unreal）
├─ 桌面应用 Web 化
└─ 算法库复用

✅ 特殊功能
├─ 加密算法
├─ 压缩/解压缩
├─ PDF 渲染
└─ 3D 图形渲染
```

---

## 💎 为什么选择 Rust + WASM

### Rust 是 WASM 的最佳拍档

**1. 零成本抽象**
```rust
// Rust 的抽象在编译后没有运行时开销
let sum: u32 = (1..1000).filter(|x| x % 2 == 0).sum();
// 编译后性能接近手写循环
```

**2. 无垃圾回收**
```rust
// 所有权系统在编译时管理内存
// WASM 二进制文件不包含 GC 运行时
// 更小的体积，更可预测的性能
```

**3. 内存安全**
```rust
// 编译时防止：
// - Use-after-free
// - Buffer overflow
// - Data races
// 生成的 WASM 代码更安全
```

**4. 出色的工具链**
```bash
# 一流的 WASM 支持
rustup target add wasm32-unknown-unknown
cargo build --target wasm32-unknown-unknown
```

### 性能对比

```
性能基准测试（相对于纯 JavaScript）:

图像处理: Rust WASM 快 2-10 倍
科学计算: Rust WASM 快 5-20 倍
游戏逻辑: Rust WASM 快 3-8 倍
加密算法: Rust WASM 快 10-30 倍
```

### 生态系统优势

```
✅ 官方支持
├─ Rust 官方维护 WASM 工具链
├─ 持续优化编译器
└─ 活跃的社区

✅ 丰富的库
├─ wasm-bindgen（JS 绑定）
├─ web-sys（Web API）
├─ js-sys（JavaScript API）
└─ 成熟的 Web 框架

✅ 开发体验
├─ 类型安全
├─ 优秀的错误信息
├─ 强大的包管理器
└─ 完善的文档
```

---

## 🛠️ 核心工具链

### 1. wasm-bindgen - JavaScript 绑定

**作用**: 在 Rust 和 JavaScript 之间建立桥梁

```rust
use wasm_bindgen::prelude::*;

// 暴露 Rust 函数给 JavaScript
#[wasm_bindgen]
pub fn greet(name: &str) -> String {
    format!("Hello, {}!", name)
}

// 调用 JavaScript 函数
#[wasm_bindgen]
extern "C" {
    fn alert(s: &str);
    
    #[wasm_bindgen(js_namespace = console)]
    fn log(s: &str);
}

#[wasm_bindgen]
pub fn hello() {
    log("Hello from Rust!");
    alert("WASM is working!");
}
```

**JavaScript 端使用**:
```javascript
import init, { greet, hello } from './pkg/my_wasm.js';

async function run() {
    await init();
    const message = greet("World");
    console.log(message); // "Hello, World!"
    hello(); // 调用 Rust 中的 alert
}

run();
```

### 2. web-sys - Web API 绑定

**作用**: 提供所有 Web 标准 API 的 Rust 绑定

```rust
use wasm_bindgen::prelude::*;
use web_sys::{Document, Element, HtmlElement, Window};

#[wasm_bindgen(start)]
pub fn main() -> Result<(), JsValue> {
    let window = web_sys::window().expect("no global window");
    let document = window.document().expect("no document");
    
    // 创建元素
    let div = document.create_element("div")?;
    div.set_inner_html("<h1>Hello from Rust!</h1>");
    
    // 添加到 DOM
    let body = document.body().expect("no body");
    body.append_child(&div)?;
    
    // 事件监听
    let button = document.create_element("button")?;
    button.set_inner_html("Click me!");
    
    let closure = Closure::wrap(Box::new(move || {
        web_sys::console::log_1(&"Button clicked!".into());
    }) as Box<dyn FnMut()>);
    
    button.add_event_listener_with_callback(
        "click",
        closure.as_ref().unchecked_ref()
    )?;
    closure.forget(); // 防止被释放
    
    body.append_child(&button)?;
    
    Ok(())
}
```

### 3. js-sys - JavaScript 标准库

**作用**: 提供 JavaScript 内置对象和函数的绑定

```rust
use js_sys::{Array, Date, Math, Object, Promise, Reflect};

#[wasm_bindgen]
pub fn use_js_apis() {
    // 使用 Math
    let random = Math::random();
    
    // 使用 Date
    let now = Date::now();
    
    // 使用 Array
    let array = Array::new();
    array.push(&JsValue::from(1));
    array.push(&JsValue::from(2));
    
    // 使用 Promise
    let promise = Promise::resolve(&JsValue::from("Success"));
}
```

### 4. wasm-pack - 构建工具

**作用**: 编译、打包、发布 WASM 项目

```bash
# 安装
cargo install wasm-pack

# 创建新项目
cargo new --lib my-wasm-project
cd my-wasm-project

# 编译为 WASM（多种目标）
wasm-pack build --target web      # 直接在浏览器使用
wasm-pack build --target bundler  # Webpack/Rollup 等打包工具
wasm-pack build --target nodejs   # Node.js 环境

# 发布到 npm
wasm-pack publish
```

### 工具链对比

| 工具 | 用途 | 必需性 |
|------|------|--------|
| **wasm-bindgen** | Rust ↔ JS 通信 | ⭐⭐⭐⭐⭐ |
| **web-sys** | Web API 访问 | ⭐⭐⭐⭐ |
| **js-sys** | JavaScript API | ⭐⭐⭐ |
| **wasm-pack** | 构建和打包 | ⭐⭐⭐⭐⭐ |
| **wasm-opt** | 优化 WASM | ⭐⭐⭐ |

---

## 🚀 快速开始

### 方式 1：最小化设置（5 分钟）

**1. 安装依赖**
```bash
# 安装 Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# 添加 WASM 目标
rustup target add wasm32-unknown-unknown

# 安装 wasm-pack
cargo install wasm-pack
```

**2. 创建项目**
```bash
cargo new --lib hello-wasm
cd hello-wasm
```

**3. 配置 Cargo.toml**
```toml
[package]
name = "hello-wasm"
version = "0.1.0"
edition = "2021"

[lib]
crate-type = ["cdylib"]

[dependencies]
wasm-bindgen = "0.2"
```

**4. 编写 Rust 代码** (`src/lib.rs`)
```rust
use wasm_bindgen::prelude::*;

#[wasm_bindgen]
pub fn greet(name: &str) -> String {
    format!("Hello, {}!", name)
}

#[wasm_bindgen]
pub fn add(a: i32, b: i32) -> i32 {
    a + b
}
```

**5. 编译**
```bash
wasm-pack build --target web
```

**6. 创建 HTML** (`index.html`)
```html
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Hello WASM</title>
</head>
<body>
    <h1>Rust + WebAssembly Demo</h1>
    <script type="module">
        import init, { greet, add } from './pkg/hello_wasm.js';
        
        async function run() {
            await init();
            
            const message = greet("World");
            console.log(message);
            
            const sum = add(5, 3);
            console.log(`5 + 3 = ${sum}`);
            
            document.body.innerHTML += `<p>${message}</p>`;
            document.body.innerHTML += `<p>5 + 3 = ${sum}</p>`;
        }
        
        run();
    </script>
</body>
</html>
```

**7. 运行**
```bash
# 使用简单的 HTTP 服务器
python -m http.server 8080
# 或
npx serve
```

访问 `http://localhost:8080`

### 方式 2：使用 Vite（推荐）

**1. 创建项目**
```bash
npm create vite@latest my-wasm-app -- --template vanilla
cd my-wasm-app
npm install

# 创建 Rust 子项目
cargo new --lib wasm
cd wasm
```

**2. 配置 Rust** (`wasm/Cargo.toml`)
```toml
[package]
name = "wasm"
version = "0.1.0"
edition = "2021"

[lib]
crate-type = ["cdylib"]

[dependencies]
wasm-bindgen = "0.2"
web-sys = { version = "0.3", features = ["console"] }
```

**3. 编写逻辑** (`wasm/src/lib.rs`)
```rust
use wasm_bindgen::prelude::*;
use web_sys::console;

#[wasm_bindgen(start)]
pub fn main() {
    console::log_1(&"WASM initialized!".into());
}

#[wasm_bindgen]
pub struct Calculator;

#[wasm_bindgen]
impl Calculator {
    #[wasm_bindgen(constructor)]
    pub fn new() -> Self {
        Calculator
    }
    
    pub fn add(&self, a: f64, b: f64) -> f64 {
        a + b
    }
    
    pub fn multiply(&self, a: f64, b: f64) -> f64 {
        a * b
    }
}
```

**4. 构建脚本** (`package.json`)
```json
{
  "scripts": {
    "dev": "vite",
    "build:wasm": "cd wasm && wasm-pack build --target web",
    "build": "npm run build:wasm && vite build"
  }
}
```

**5. 使用** (`main.js`)
```javascript
import './style.css'
import init, { Calculator } from './wasm/pkg/wasm.js'

async function run() {
    await init();
    
    const calc = new Calculator();
    const result = calc.add(10, 20);
    
    document.querySelector('#app').innerHTML = `
        <h1>Rust WASM Calculator</h1>
        <p>10 + 20 = ${result}</p>
    `;
}

run();
```

---

## 🎨 Web 框架

### 1. Yew - React 风格框架

**特点**:
- 类似 React 的组件模型
- 虚拟 DOM
- 成熟稳定
- 大型社区

**快速开始**:
```bash
cargo install trunk
cargo new yew-app
cd yew-app
```

**Cargo.toml**:
```toml
[dependencies]
yew = { version = "0.21", features = ["csr"] }
```

**示例应用** (`src/main.rs`):
```rust
use yew::prelude::*;

#[function_component(App)]
fn app() -> Html {
    let counter = use_state(|| 0);
    
    let increment = {
        let counter = counter.clone();
        Callback::from(move |_| counter.set(*counter + 1))
    };
    
    html! {
        <div>
            <h1>{ "Yew Counter App" }</h1>
            <p>{ format!("Count: {}", *counter) }</p>
            <button onclick={increment}>{ "Increment" }</button>
        </div>
    }
}

fn main() {
    yew::Renderer::<App>::new().render();
}
```

**index.html**:
```html
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Yew App</title>
</head>
<body></body>
</html>
```

**运行**:
```bash
trunk serve
```

### 2. Leptos - 现代响应式框架

**特点**:
- 细粒度响应式
- 无虚拟 DOM
- SSR/CSR 同构
- 极致性能

**快速开始**:
```bash
cargo new leptos-app
cd leptos-app
```

**Cargo.toml**:
```toml
[dependencies]
leptos = { version = "0.6", features = ["csr"] }
```

**示例**:
```rust
use leptos::*;

#[component]
fn App() -> impl IntoView {
    let (count, set_count) = create_signal(0);
    
    view! {
        <div>
            <h1>"Leptos Counter"</h1>
            <p>"Count: " {count}</p>
            <button on:click=move |_| set_count.update(|n| *n += 1)>
                "Increment"
            </button>
        </div>
    }
}

fn main() {
    mount_to_body(|| view! { <App/> })
}
```

### 3. Dioxus - 跨平台框架

**特点**:
- 一套代码多平台（Web、Desktop、Mobile）
- RSX 语法（类似 JSX）
- 虚拟 DOM
- 组件化

**示例**:
```rust
use dioxus::prelude::*;

fn main() {
    dioxus_web::launch(App);
}

fn App(cx: Scope) -> Element {
    let mut count = use_state(cx, || 0);
    
    cx.render(rsx! {
        div {
            h1 { "Counter: {count}" }
            button {
                onclick: move |_| count += 1,
                "Increment"
            }
        }
    })
}
```

### 框架对比

| 框架 | 性能 | 成熟度 | 学习曲线 | SSR |
|------|------|--------|----------|-----|
| **Yew** | ⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ | 中等 | ✅ |
| **Leptos** | ⭐⭐⭐⭐⭐ | ⭐⭐⭐ | 陡峭 | ✅ |
| **Dioxus** | ⭐⭐⭐⭐ | ⭐⭐⭐ | 简单 | ✅ |

---

## 💻 实战项目

### 项目 1：图像处理工具

**功能**: 在浏览器中进行高性能图像处理

```rust
use wasm_bindgen::prelude::*;
use wasm_bindgen::Clamped;
use web_sys::ImageData;

#[wasm_bindgen]
pub struct ImageProcessor;

#[wasm_bindgen]
impl ImageProcessor {
    pub fn grayscale(data: &mut [u8]) {
        for chunk in data.chunks_exact_mut(4) {
            let avg = (chunk[0] as u32 + chunk[1] as u32 + chunk[2] as u32) / 3;
            chunk[0] = avg as u8;
            chunk[1] = avg as u8;
            chunk[2] = avg as u8;
        }
    }
    
    pub fn invert(data: &mut [u8]) {
        for chunk in data.chunks_exact_mut(4) {
            chunk[0] = 255 - chunk[0];
            chunk[1] = 255 - chunk[1];
            chunk[2] = 255 - chunk[2];
        }
    }
    
    pub fn blur(
        data: &[u8],
        width: u32,
        height: u32,
        radius: u32,
    ) -> Vec<u8> {
        // 简化的模糊算法
        let mut result = data.to_vec();
        // ... 实现高斯模糊
        result
    }
}
```

### 项目 2：游戏引擎（康威生命游戏）

```rust
use wasm_bindgen::prelude::*;

#[wasm_bindgen]
pub struct Universe {
    width: u32,
    height: u32,
    cells: Vec<bool>,
}

#[wasm_bindgen]
impl Universe {
    pub fn new(width: u32, height: u32) -> Self {
        let cells = (0..width * height)
            .map(|_| js_sys::Math::random() < 0.5)
            .collect();
        
        Universe { width, height, cells }
    }
    
    pub fn tick(&mut self) {
        let mut next = self.cells.clone();
        
        for row in 0..self.height {
            for col in 0..self.width {
                let idx = self.get_index(row, col);
                let cell = self.cells[idx];
                let live_neighbors = self.live_neighbor_count(row, col);
                
                next[idx] = match (cell, live_neighbors) {
                    (true, 2) | (true, 3) => true,
                    (false, 3) => true,
                    _ => false,
                };
            }
        }
        
        self.cells = next;
    }
    
    pub fn cells(&self) -> *const bool {
        self.cells.as_ptr()
    }
    
    fn get_index(&self, row: u32, col: u32) -> usize {
        (row * self.width + col) as usize
    }
    
    fn live_neighbor_count(&self, row: u32, col: u32) -> u8 {
        let mut count = 0;
        for delta_row in [self.height - 1, 0, 1].iter().cloned() {
            for delta_col in [self.width - 1, 0, 1].iter().cloned() {
                if delta_row == 0 && delta_col == 0 {
                    continue;
                }
                
                let neighbor_row = (row + delta_row) % self.height;
                let neighbor_col = (col + delta_col) % self.width;
                let idx = self.get_index(neighbor_row, neighbor_col);
                count += self.cells[idx] as u8;
            }
        }
        count
    }
}
```

### 项目 3：Markdown 渲染器

```rust
use wasm_bindgen::prelude::*;
use pulldown_cmark::{Parser, html};

#[wasm_bindgen]
pub fn render_markdown(input: &str) -> String {
    let parser = Parser::new(input);
    let mut html_output = String::new();
    html::push_html(&mut html_output, parser);
    html_output
}
```

---

## ⚡ 性能优化

### 1. 减小 WASM 体积

```bash
# 使用 release 构建
cargo build --release --target wasm32-unknown-unknown

# 优化 Cargo.toml
[profile.release]
opt-level = 'z'        # 优化体积
lto = true             # 链接时优化
codegen-units = 1      # 单个代码生成单元
panic = 'abort'        # 减小体积

# 使用 wasm-opt
wasm-opt -Oz -o output.wasm input.wasm

# 启用 WASM GC 提案（实验性）
[profile.release.package."*"]
opt-level = 'z'
```

### 2. 延迟加载

```javascript
// 按需加载 WASM 模块
button.addEventListener('click', async () => {
    const { heavy_computation } = await import('./pkg/my_wasm.js');
    await heavy_computation();
});
```

### 3. 内存管理

```rust
// 避免不必要的分配
#[wasm_bindgen]
pub fn process_data(data: &[u8]) -> Vec<u8> {
    // 使用引用而不是复制
    let mut result = Vec::with_capacity(data.len());
    // ...
    result
}

// 使用内存池
static mut BUFFER: [u8; 4096] = [0; 4096];

#[wasm_bindgen]
pub fn use_buffer() -> *mut u8 {
    unsafe { BUFFER.as_mut_ptr() }
}
```

### 4. 并行计算

```rust
// 使用 Web Workers 并行处理
use wasm_bindgen::prelude::*;
use wasm_bindgen_futures::spawn_local;

#[wasm_bindgen]
pub async fn parallel_process(data: Vec<u8>) -> Vec<u8> {
    // 拆分任务
    let chunk_size = data.len() / 4;
    let mut handles = vec![];
    
    for chunk in data.chunks(chunk_size) {
        handles.push(process_chunk(chunk.to_vec()));
    }
    
    // 等待所有任务完成
    // ...合并结果
    vec![]
}
```

---

## 📚 学习路线

### 阶段 1：基础入门（1-2 周）

```
Week 1: Rust 基础
├─ 完成 Rustlings
├─ 理解所有权系统
└─ 掌握基本语法

Week 2: WASM 入门
├─ 安装工具链
├─ 第一个 Hello World
├─ 理解 wasm-bindgen
└─ JS 互操作基础
```

### 阶段 2：深入实践（2-4 周）

```
Week 3-4: 工具链掌握
├─ web-sys API 使用
├─ DOM 操作
├─ 事件处理
└─ 异步编程

Week 5-6: 实战项目
├─ 图像处理工具
├─ 简单游戏
├─ 数据可视化
└─ 性能优化
```

### 阶段 3：框架学习（4-6 周）

```
Week 7-9: Yew 框架
├─ 组件开发
├─ 状态管理
├─ 路由
└─ 完整应用

Week 10-12: 高级主题
├─ SSR/SSG
├─ 性能调优
├─ 生产部署
└─ 最佳实践
```

---

## ✅ 最佳实践

### 1. 何时使用 WASM

**✅ 适合的场景**:
- CPU 密集型计算
- 现有 C/Rust 代码移植
- 性能关键路径
- 需要保护源码

**❌ 不适合的场景**:
- 简单的 DOM 操作
- 主要是 I/O 操作
- 项目初期（过早优化）

### 2. 架构建议

```
推荐架构：

JavaScript/TypeScript (UI 逻辑)
        ↓
    WASM (性能关键部分)
        ↓
    Web APIs
```

### 3. 调试技巧

```rust
// 使用 console_error_panic_hook
use console_error_panic_hook;

#[wasm_bindgen(start)]
pub fn main() {
    console_error_panic_hook::set_once();
}

// 使用 web_sys::console
use web_sys::console;

console::log_1(&format!("Value: {}", value).into());
```

### 4. 测试策略

```rust
#[cfg(test)]
mod tests {
    use super::*;
    use wasm_bindgen_test::*;
    
    #[wasm_bindgen_test]
    fn test_add() {
        assert_eq!(add(2, 3), 5);
    }
}
```

---

## 📊 生态系统

### 核心 Crates

| Crate | 用途 | Stars |
|-------|------|-------|
| wasm-bindgen | JS 绑定 | 7K+ |
| yew | Web 框架 | 30K+ |
| leptos | 响应式框架 | 15K+ |
| trunk | 构建工具 | 3K+ |
| gloo | Web API 工具 | 1.5K+ |

### 学习资源

**官方文档**:
- [Rust and WebAssembly Book](https://rustwasm.github.io/book/)
- [wasm-bindgen Guide](https://rustwasm.github.io/wasm-bindgen/)
- [MDN WebAssembly](https://developer.mozilla.org/en-US/docs/WebAssembly)

**教程**:
- [Game of Life Tutorial](https://rustwasm.github.io/book/game-of-life/introduction.html)
- [Yew Tutorial](https://yew.rs/docs/tutorial)
- [Leptos Book](https://leptos-rs.github.io/leptos/)

**视频**:
- [Rust WASM Crash Course](https://www.youtube.com/watch?v=hcA_GuZHyZM)
- [Building Web UIs with Rust](https://www.youtube.com/watch?v=ie13kswrWu4)

---

## 🎯 总结

### 关键要点

1. **Rust + WASM = 高性能 Web**
   - 接近原生的执行速度
   - 类型安全
   - 无 GC 开销

2. **工具链完善**
   - wasm-pack 简化构建
   - wasm-bindgen 无缝集成
   - web-sys 完整 API

3. **生态系统活跃**
   - 多个成熟框架可选
   - 丰富的学习资源
   - 活跃的社区支持

4. **实际应用**
   - Figma - 设计工具
   - Google Earth - 地图渲染
   - AutoCAD - CAD 软件
   - Disney+ - 视频处理

### 学习建议

1. **先掌握 Rust 基础** - 所有权、借用、生命周期
2. **从简单项目开始** - Hello World → 图像处理 → 游戏
3. **选择合适的框架** - Yew（稳定）、Leptos（性能）、Dioxus（跨平台）
4. **关注性能优化** - 体积优化、内存管理、并行计算
5. **参与社区** - 提问、分享、贡献代码

### 下一步行动

```
✅ 完成 Rustlings 练习
   ↓
✅ 构建第一个 WASM 应用
   ↓
✅ 学习 web-sys API
   ↓
✅ 选择并学习一个框架
   ↓
✅ 构建完整的 Web 应用
   ↓
✅ 优化性能并部署
```

---

## 🌟 成功案例

### 1. Figma
- **用途**: 矢量图形编辑器
- **优势**: WASM 提供接近原生的性能
- **效果**: 复杂图形处理流畅运行

### 2. Google Earth
- **用途**: 3D 地球渲染
- **技术**: C++ 代码编译为 WASM
- **效果**: 在浏览器中流畅渲染地球

### 3. AutoCAD Web
- **用途**: CAD 设计软件
- **迁移**: 桌面应用 Web 化
- **效果**: 保持专业级性能

### 4. Photoshop Web
- **用途**: 图像编辑
- **技术**: C++ + WASM
- **效果**: 功能完整的 Web 版本

---

## 📱 移动端和桌面端

### Tauri - 跨平台桌面应用

```rust
// 使用 Rust + WASM 构建桌面应用
#[tauri::command]
fn greet(name: &str) -> String {
    format!("Hello, {}!", name)
}

fn main() {
    tauri::Builder::default()
        .invoke_handler(tauri::generate_handler![greet])
        .run(tauri::generate_context!())
        .expect("error while running tauri application");
}
```

### 优势
- 体积小（相比 Electron）
- 性能好
- 内存占用低
- 原生 UI

---

## 🔮 未来展望

### WASM 的发展方向

**1. Component Model**
- 模块化组件
- 跨语言互操作
- 标准化接口

**2. WASI (WebAssembly System Interface)**
- 服务器端 WASM
- 无需浏览器运行
- 通用系统接口

**3. 多线程支持**
- SharedArrayBuffer
- 原子操作
- 并行计算

**4. GC 支持**
- 垃圾回收提案
- 更多语言支持
- 更好的性能

### Rust 在 WASM 的地位

```
当前趋势：
- Rust 是 WASM 最流行的语言
- 70% 的 WASM 项目使用 Rust
- 工具链最完善
- 社区最活跃
```

---

## 🎓 练习项目推荐

### 入门级（1-2 周）

1. **计算器**
   - 基本四则运算
   - UI 用 HTML/CSS
   - 逻辑用 WASM

2. **待办事项**
   - 添加/删除任务
   - 本地存储
   - 使用 web-sys

3. **Markdown 预览**
   - 实时渲染
   - 使用 pulldown-cmark
   - 分屏显示

### 中级（2-4 周）

4. **图像滤镜**
   - 灰度、反色、模糊
   - Canvas API
   - 性能对比

5. **生命游戏**
   - 细胞自动机
   - Canvas 渲染
   - 性能优化

6. **音频可视化**
   - Web Audio API
   - FFT 计算
   - Canvas 动画

### 高级（4-8 周）

7. **代码编辑器**
   - 语法高亮
   - 代码补全
   - 使用 Yew/Leptos

8. **在线 IDE**
   - 代码执行
   - 文件管理
   - 终端模拟

9. **3D 渲染引擎**
   - WebGL 集成
   - 3D 场景
   - 实时渲染

---

## 📖 推荐阅读

### 书籍
- "Programming WebAssembly with Rust" by Kevin Hoffman
- "Rust and WebAssembly" (在线免费书)

### 博客
- [Rust WASM Working Group Blog](https://rustwasm.github.io/)
- [Lin Clark's Code Cartoons](https://code-cartoons.com/)

### 网站
- [WebAssembly.org](https://webassembly.org/)
- [Made with WebAssembly](https://madewithwebassembly.com/)
- [WASM by Example](https://wasmbyexample.dev/)

---

## 🤝 社区资源

### Discord/Slack
- Rust WASM Discord
- Yew Discord
- Leptos Discord

### GitHub
- [rustwasm](https://github.com/rustwasm) - 官方组织
- [awesome-rust-and-webassembly](https://github.com/rustwasm/awesome-rust-and-webassembly)

### 论坛
- [Rust Users Forum](https://users.rust-lang.org/)
- [r/rust](https://reddit.com/r/rust)
- [r/WebAssembly](https://reddit.com/r/WebAssembly)

---

## ✨ 最后的话

Rust + WebAssembly 代表了 Web 开发的未来：

- 🚀 **性能** - 接近原生速度
- 🛡️ **安全** - 编译时保证
- 🔧 **工具** - 一流的开发体验
- 🌍 **生态** - 活跃的社区

无论你是想构建高性能 Web 应用，还是将现有代码移植到浏览器，Rust + WASM 都是最佳选择。

**开始你的 WASM 之旅吧！** 🎉

---

## 🔗 相关笔记

- [[00-Index/Rust-MOC|Rust 知识地图]]
- [[00-Index/Learning-Roadmap|学习路线图]]
- [[06-Projects/projects|GitHub 项目推荐]]
- [[02-Advanced-Concepts/Async-Await|异步编程]]

---

#rust #webassembly #wasm #web #frontend #performance #tutorial

*最后更新: 2024-01-15*
*版本: 1.0.0*