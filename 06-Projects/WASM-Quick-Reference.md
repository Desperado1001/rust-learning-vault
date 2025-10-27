---
tags: [rust, wasm, webassembly, cheatsheet, quick-reference]
created: 2024-01-15
updated: 2024-01-15
---

# 🚀 Rust WebAssembly 快速参考

> 常用命令、API 和代码片段速查表

---

## 📦 安装与设置

```bash
# 安装 Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# 添加 WASM 目标
rustup target add wasm32-unknown-unknown

# 安装 wasm-pack
cargo install wasm-pack

# 安装 trunk (Yew 构建工具)
cargo install trunk

# 安装 wasm-bindgen-cli
cargo install wasm-bindgen-cli
```

---

## 🏗️ 项目初始化

### 基础 WASM 库
```bash
cargo new --lib my-wasm-lib
cd my-wasm-lib
```

**Cargo.toml**:
```toml
[lib]
crate-type = ["cdylib"]

[dependencies]
wasm-bindgen = "0.2"
web-sys = { version = "0.3", features = ["console"] }
js-sys = "0.3"
```

### Yew 应用
```bash
cargo new yew-app
cd yew-app
```

**Cargo.toml**:
```toml
[dependencies]
yew = { version = "0.21", features = ["csr"] }
```

---

## 🔨 构建命令

```bash
# wasm-pack 构建
wasm-pack build --target web        # 浏览器 ES 模块
wasm-pack build --target bundler    # Webpack/Vite
wasm-pack build --target nodejs     # Node.js

# 优化构建
wasm-pack build --release

# 手动编译
cargo build --target wasm32-unknown-unknown --release

# Trunk 构建（Yew）
trunk serve              # 开发服务器
trunk build --release    # 生产构建
```

---

## 📝 基础语法

### 导出函数给 JavaScript

```rust
use wasm_bindgen::prelude::*;

// 简单函数
#[wasm_bindgen]
pub fn add(a: i32, b: i32) -> i32 {
    a + b
}

// 字符串处理
#[wasm_bindgen]
pub fn greet(name: &str) -> String {
    format!("Hello, {}!", name)
}

// 初始化函数
#[wasm_bindgen(start)]
pub fn main() {
    console_log("WASM initialized!");
}
```

### 导出结构体

```rust
#[wasm_bindgen]
pub struct Counter {
    value: i32,
}

#[wasm_bindgen]
impl Counter {
    #[wasm_bindgen(constructor)]
    pub fn new() -> Counter {
        Counter { value: 0 }
    }
    
    pub fn increment(&mut self) {
        self.value += 1;
    }
    
    pub fn get(&self) -> i32 {
        self.value
    }
}
```

---

## 🔗 JavaScript 互操作

### 调用 JS 函数

```rust
#[wasm_bindgen]
extern "C" {
    // alert
    fn alert(s: &str);
    
    // console.log
    #[wasm_bindgen(js_namespace = console)]
    fn log(s: &str);
    
    // setTimeout
    #[wasm_bindgen(js_namespace = window)]
    fn setTimeout(closure: &Closure<dyn FnMut()>, delay: i32);
}

#[wasm_bindgen]
pub fn hello() {
    log("Hello from Rust!");
    alert("WASM works!");
}
```

### 使用 web-sys

```rust
use web_sys::{window, document, Element, HtmlElement};

// 获取 window 和 document
let window = window().expect("no global window");
let document = window.document().expect("no document");

// 创建元素
let div = document.create_element("div")?;
div.set_inner_html("<h1>Hello WASM!</h1>");

// 添加到 DOM
let body = document.body().expect("no body");
body.append_child(&div)?;

// 查询元素
let element = document.query_selector("#app")?;

// 事件监听
let closure = Closure::wrap(Box::new(move || {
    web_sys::console::log_1(&"Clicked!".into());
}) as Box<dyn FnMut()>);

element.add_event_listener_with_callback("click", closure.as_ref().unchecked_ref())?;
closure.forget(); // 防止被释放
```

### 使用 js-sys

```rust
use js_sys::{Array, Date, Math, Promise};

// Math API
let random = Math::random();
let sqrt = Math::sqrt(16.0);

// Date API
let now = Date::now();

// Array API
let array = Array::new();
array.push(&JsValue::from(1));
array.push(&JsValue::from(2));
```

---

## 🎨 Web 框架代码片段

### Yew 组件

```rust
use yew::prelude::*;

#[function_component(App)]
fn app() -> Html {
    let counter = use_state(|| 0);
    
    let onclick = {
        let counter = counter.clone();
        Callback::from(move |_| counter.set(*counter + 1))
    };
    
    html! {
        <div>
            <h1>{ "Counter" }</h1>
            <p>{ format!("Count: {}", *counter) }</p>
            <button {onclick}>{ "Increment" }</button>
        </div>
    }
}

fn main() {
    yew::Renderer::<App>::new().render();
}
```

### Leptos 组件

```rust
use leptos::*;

#[component]
fn App() -> impl IntoView {
    let (count, set_count) = create_signal(0);
    
    view! {
        <div>
            <h1>"Counter"</h1>
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

---

## 💾 数据传递

### Rust → JavaScript

```rust
// 基础类型：自动转换
#[wasm_bindgen]
pub fn get_number() -> i32 { 42 }

#[wasm_bindgen]
pub fn get_string() -> String { "Hello".to_string() }

// 数组：使用 Box<[T]>
#[wasm_bindgen]
pub fn get_array() -> Box<[u8]> {
    vec![1, 2, 3].into_boxed_slice()
}

// 使用 serde 传递复杂对象
use serde::{Serialize, Deserialize};
use wasm_bindgen::JsValue;

#[derive(Serialize)]
pub struct User {
    name: String,
    age: u32,
}

#[wasm_bindgen]
pub fn get_user() -> JsValue {
    let user = User {
        name: "Alice".to_string(),
        age: 30,
    };
    serde_wasm_bindgen::to_value(&user).unwrap()
}
```

### JavaScript → Rust

```rust
use wasm_bindgen::prelude::*;

// 接收基础类型
#[wasm_bindgen]
pub fn process(data: &str) -> String {
    data.to_uppercase()
}

// 接收数组
#[wasm_bindgen]
pub fn sum_array(arr: &[i32]) -> i32 {
    arr.iter().sum()
}

// 使用 serde 接收对象
use serde::Deserialize;

#[derive(Deserialize)]
pub struct Config {
    host: String,
    port: u16,
}

#[wasm_bindgen]
pub fn configure(value: JsValue) -> Result<(), JsValue> {
    let config: Config = serde_wasm_bindgen::from_value(value)?;
    // 使用 config
    Ok(())
}
```

---

## 🎯 常见模式

### Console 日志

```rust
use web_sys::console;

// 简单日志
console::log_1(&"Hello".into());

// 格式化
console::log_1(&format!("Value: {}", 42).into());

// 多个参数
console::log_2(&"Name:".into(), &name.into());

// 宏方式（需要 gloo）
use gloo::console::log;
log!("Value:", value);
```

### 错误处理

```rust
use wasm_bindgen::prelude::*;

#[wasm_bindgen]
pub fn risky_operation() -> Result<String, JsValue> {
    // 使用 ? 操作符
    let result = some_operation()
        .map_err(|e| JsValue::from_str(&e.to_string()))?;
    
    Ok(result)
}

// 设置 panic hook 以获得更好的错误信息
#[wasm_bindgen(start)]
pub fn main() {
    console_error_panic_hook::set_once();
}
```

### 异步操作

```rust
use wasm_bindgen::prelude::*;
use wasm_bindgen_futures::JsFuture;
use web_sys::{Request, RequestInit, Response};

#[wasm_bindgen]
pub async fn fetch_data(url: String) -> Result<JsValue, JsValue> {
    let mut opts = RequestInit::new();
    opts.method("GET");
    
    let request = Request::new_with_str_and_init(&url, &opts)?;
    
    let window = web_sys::window().unwrap();
    let resp_value = JsFuture::from(window.fetch_with_request(&request)).await?;
    let resp: Response = resp_value.dyn_into()?;
    
    let json = JsFuture::from(resp.json()?).await?;
    Ok(json)
}
```

---

## ⚡ 性能优化

### Cargo.toml 优化

```toml
[profile.release]
opt-level = "z"        # 优化体积
lto = true             # 链接时优化
codegen-units = 1      # 更好的优化
panic = "abort"        # 减小体积
strip = true           # 移除调试符号（Rust 1.59+）
```

### 避免不必要的分配

```rust
// ❌ 不好：每次都分配
#[wasm_bindgen]
pub fn process(data: String) -> String {
    data.to_uppercase()
}

// ✅ 更好：使用引用
#[wasm_bindgen]
pub fn process(data: &str) -> String {
    data.to_uppercase()
}
```

### 使用 wasm-opt

```bash
# 安装
npm install -g wasm-opt

# 优化
wasm-opt -Oz -o output.wasm input.wasm
```

---

## 🧪 测试

```rust
#[cfg(test)]
mod tests {
    use super::*;
    use wasm_bindgen_test::*;
    
    // 单元测试
    #[test]
    fn test_add() {
        assert_eq!(add(2, 3), 5);
    }
    
    // WASM 测试
    #[wasm_bindgen_test]
    fn test_wasm_add() {
        assert_eq!(add(2, 3), 5);
    }
}
```

运行测试：
```bash
# Node.js
wasm-pack test --node

# 浏览器
wasm-pack test --headless --firefox
wasm-pack test --headless --chrome
```

---

## 🔍 调试

### 浏览器调试

```rust
// 使用 console.log
web_sys::console::log_1(&format!("Value: {}", value).into());

// 设置 panic hook
use console_error_panic_hook;

#[wasm_bindgen(start)]
pub fn main() {
    console_error_panic_hook::set_once();
}

// Source maps（在 Cargo.toml）
[profile.release]
debug = true
```

---

## 📚 常用 Features

### web-sys features

```toml
[dependencies.web-sys]
version = "0.3"
features = [
    "console",
    "Document",
    "Element",
    "HtmlElement",
    "Node",
    "Window",
    "CanvasRenderingContext2d",
    "HtmlCanvasElement",
    "EventTarget",
    "MouseEvent",
]
```

---

## 🎁 有用的 Crates

```toml
[dependencies]
# 核心
wasm-bindgen = "0.2"
web-sys = "0.3"
js-sys = "0.3"

# 工具
gloo = "0.11"                    # Web API 工具集
console_error_panic_hook = "0.1" # 更好的错误信息
wasm-bindgen-futures = "0.4"     # 异步支持

# 序列化
serde = { version = "1.0", features = ["derive"] }
serde-wasm-bindgen = "0.6"

# 框架
yew = "0.21"
leptos = "0.6"
```

---

## 📖 快速链接

- [Rust WASM Book](https://rustwasm.github.io/book/)
- [wasm-bindgen Docs](https://rustwasm.github.io/wasm-bindgen/)
- [web-sys Docs](https://rustwasm.github.io/wasm-bindgen/api/web_sys/)
- [MDN WASM](https://developer.mozilla.org/en-US/docs/WebAssembly)

---

#rust #wasm #cheatsheet #quick-reference