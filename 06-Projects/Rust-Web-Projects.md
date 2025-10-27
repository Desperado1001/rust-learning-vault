---
tags: [rust, web, backend, frameworks, projects, fullstack]
created: 2024-01-15
updated: 2024-01-15
difficulty: ⭐⭐⭐⭐
---

# 🌐 Rust Web 经典项目完全指南

> 从框架对比到实战项目，全面掌握 Rust Web 开发

---

## 📋 目录

- [Web 框架对比](#web-框架对比)
- [经典开源项目](#经典开源项目)
- [实战项目示例](#实战项目示例)
- [完整应用架构](#完整应用架构)
- [学习路线](#学习路线)

---

## 🎯 Rust Web 框架对比

### 主流框架总览

| 框架 | Stars | 性能 | 难度 | 异步 | 生态 | 适用场景 |
|------|-------|------|------|------|------|----------|
| **Actix-Web** | 21K+ | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐ | ✅ | 最成熟 | 高性能 API |
| **Axum** | 17K+ | ⭐⭐⭐⭐⭐ | ⭐⭐⭐ | ✅ | 快速增长 | 现代 Web 服务 |
| **Rocket** | 24K+ | ⭐⭐⭐⭐ | ⭐⭐ | ✅ | 成熟 | 快速开发 |
| **Warp** | 9K+ | ⭐⭐⭐⭐ | ⭐⭐⭐⭐ | ✅ | 中等 | 函数式风格 |
| **Tide** | 3.3K+ | ⭐⭐⭐⭐ | ⭐⭐ | ✅ | 较小 | 简单项目 |

---

## 🏆 1. Actix-Web - 高性能之王

### 📊 项目信息
- **GitHub**: [actix/actix-web](https://github.com/actix/actix-web)
- **Stars**: 21,000+
- **特点**: 最快的 Rust Web 框架，基于 Actor 模型
- **使用者**: Discord, Microsoft, Cloudflare

### 🎯 核心特性

**1. 极致性能**
```rust
// 处理能力：每秒 100K+ 请求
// 延迟低至 1-2ms
```

**2. 灵活的路由**
```rust
use actix_web::{web, App, HttpResponse, HttpServer, Responder};

#[actix_web::main]
async fn main() -> std::io::Result<()> {
    HttpServer::new(|| {
        App::new()
            .route("/", web::get().to(index))
            .route("/hello/{name}", web::get().to(greet))
            .service(
                web::scope("/api")
                    .route("/users", web::get().to(get_users))
                    .route("/users", web::post().to(create_user))
            )
    })
    .bind(("127.0.0.1", 8080))?
    .run()
    .await
}

async fn index() -> impl Responder {
    HttpResponse::Ok().body("Hello world!")
}

async fn greet(path: web::Path<String>) -> impl Responder {
    let name = path.into_inner();
    HttpResponse::Ok().body(format!("Hello {}!", name))
}
```

**3. 强大的中间件**
```rust
use actix_web::middleware::{Logger, Compress};

HttpServer::new(|| {
    App::new()
        .wrap(Logger::default())
        .wrap(Compress::default())
        .wrap(middleware::Cors::default())
})
```

### 💡 完整 REST API 示例

```rust
use actix_web::{web, App, HttpResponse, HttpServer, Responder};
use serde::{Deserialize, Serialize};
use std::sync::Mutex;

#[derive(Debug, Serialize, Deserialize, Clone)]
struct User {
    id: u32,
    name: String,
    email: String,
}

struct AppState {
    users: Mutex<Vec<User>>,
}

// GET /users
async fn get_users(data: web::Data<AppState>) -> impl Responder {
    let users = data.users.lock().unwrap();
    HttpResponse::Ok().json(&*users)
}

// GET /users/{id}
async fn get_user(
    data: web::Data<AppState>,
    id: web::Path<u32>,
) -> impl Responder {
    let users = data.users.lock().unwrap();
    match users.iter().find(|u| u.id == *id) {
        Some(user) => HttpResponse::Ok().json(user),
        None => HttpResponse::NotFound().body("User not found"),
    }
}

// POST /users
async fn create_user(
    data: web::Data<AppState>,
    user: web::Json<User>,
) -> impl Responder {
    let mut users = data.users.lock().unwrap();
    users.push(user.into_inner());
    HttpResponse::Created().body("User created")
}

// PUT /users/{id}
async fn update_user(
    data: web::Data<AppState>,
    id: web::Path<u32>,
    user: web::Json<User>,
) -> impl Responder {
    let mut users = data.users.lock().unwrap();
    if let Some(existing) = users.iter_mut().find(|u| u.id == *id) {
        *existing = user.into_inner();
        HttpResponse::Ok().body("User updated")
    } else {
        HttpResponse::NotFound().body("User not found")
    }
}

// DELETE /users/{id}
async fn delete_user(
    data: web::Data<AppState>,
    id: web::Path<u32>,
) -> impl Responder {
    let mut users = data.users.lock().unwrap();
    let initial_len = users.len();
    users.retain(|u| u.id != *id);
    
    if users.len() < initial_len {
        HttpResponse::Ok().body("User deleted")
    } else {
        HttpResponse::NotFound().body("User not found")
    }
}

#[actix_web::main]
async fn main() -> std::io::Result<()> {
    let app_state = web::Data::new(AppState {
        users: Mutex::new(vec![]),
    });

    HttpServer::new(move || {
        App::new()
            .app_data(app_state.clone())
            .route("/users", web::get().to(get_users))
            .route("/users/{id}", web::get().to(get_user))
            .route("/users", web::post().to(create_user))
            .route("/users/{id}", web::put().to(update_user))
            .route("/users/{id}", web::delete().to(delete_user))
    })
    .bind(("127.0.0.1", 8080))?
    .run()
    .await
}
```

### 🗄️ 数据库集成（Diesel ORM）

```toml
[dependencies]
actix-web = "4"
diesel = { version = "2", features = ["postgres", "r2d2"] }
dotenv = "0.15"
serde = { version = "1", features = ["derive"] }
```

```rust
use diesel::prelude::*;
use diesel::r2d2::{self, ConnectionManager};

type DbPool = r2d2::Pool<ConnectionManager<PgConnection>>;

// 模型定义
#[derive(Queryable, Serialize)]
struct User {
    id: i32,
    name: String,
    email: String,
}

#[derive(Insertable, Deserialize)]
#[diesel(table_name = users)]
struct NewUser {
    name: String,
    email: String,
}

// 数据库操作
async fn get_users(pool: web::Data<DbPool>) -> impl Responder {
    let mut conn = pool.get().expect("couldn't get db connection");
    
    let results = users::table
        .load::<User>(&mut conn)
        .expect("Error loading users");
    
    HttpResponse::Ok().json(results)
}
```

---

## ⚡ 2. Axum - 现代化首选

### 📊 项目信息
- **GitHub**: [tokio-rs/axum](https://github.com/tokio-rs/axum)
- **Stars**: 17,000+
- **特点**: Tokio 团队出品，设计现代，易用性强
- **优势**: 与 Tokio 生态完美集成

### 🎯 核心特性

**1. 简洁的 API**
```rust
use axum::{
    routing::{get, post},
    Router,
    Json,
    extract::{Path, State},
    response::IntoResponse,
};
use serde::{Deserialize, Serialize};
use std::sync::{Arc, Mutex};

#[derive(Clone)]
struct AppState {
    users: Arc<Mutex<Vec<User>>>,
}

#[derive(Serialize, Deserialize, Clone)]
struct User {
    id: u32,
    name: String,
    email: String,
}

#[tokio::main]
async fn main() {
    let state = AppState {
        users: Arc::new(Mutex::new(vec![])),
    };

    let app = Router::new()
        .route("/", get(root))
        .route("/users", get(get_users).post(create_user))
        .route("/users/:id", get(get_user).delete(delete_user))
        .with_state(state);

    let listener = tokio::net::TcpListener::bind("0.0.0.0:3000")
        .await
        .unwrap();
    
    axum::serve(listener, app).await.unwrap();
}

async fn root() -> &'static str {
    "Hello, Axum!"
}

async fn get_users(State(state): State<AppState>) -> Json<Vec<User>> {
    let users = state.users.lock().unwrap();
    Json(users.clone())
}

async fn get_user(
    State(state): State<AppState>,
    Path(id): Path<u32>,
) -> impl IntoResponse {
    let users = state.users.lock().unwrap();
    match users.iter().find(|u| u.id == id) {
        Some(user) => Json(user.clone()).into_response(),
        None => (
            axum::http::StatusCode::NOT_FOUND,
            "User not found"
        ).into_response(),
    }
}

async fn create_user(
    State(state): State<AppState>,
    Json(user): Json<User>,
) -> impl IntoResponse {
    let mut users = state.users.lock().unwrap();
    users.push(user);
    (axum::http::StatusCode::CREATED, "User created")
}

async fn delete_user(
    State(state): State<AppState>,
    Path(id): Path<u32>,
) -> impl IntoResponse {
    let mut users = state.users.lock().unwrap();
    let initial_len = users.len();
    users.retain(|u| u.id != id);
    
    if users.len() < initial_len {
        (axum::http::StatusCode::OK, "User deleted")
    } else {
        (axum::http::StatusCode::NOT_FOUND, "User not found")
    }
}
```

**2. 强大的提取器（Extractors）**
```rust
use axum::extract::{Query, Json, Path, State, Extension};
use serde::Deserialize;

#[derive(Deserialize)]
struct Pagination {
    page: usize,
    per_page: usize,
}

async fn list_items(
    Query(pagination): Query<Pagination>,
    Extension(db): Extension<DbPool>,
) -> Json<Vec<Item>> {
    // 使用 pagination 参数
    let items = fetch_items(db, pagination).await;
    Json(items)
}
```

**3. 中间件和 Tower 集成**
```rust
use tower::ServiceBuilder;
use tower_http::{
    trace::TraceLayer,
    compression::CompressionLayer,
    cors::CorsLayer,
};

let app = Router::new()
    .route("/", get(handler))
    .layer(
        ServiceBuilder::new()
            .layer(TraceLayer::new_for_http())
            .layer(CompressionLayer::new())
            .layer(CorsLayer::permissive())
    );
```

### 🔐 JWT 认证示例

```rust
use axum::{
    routing::post,
    Router,
    Json,
    http::StatusCode,
};
use jsonwebtoken::{encode, decode, Header, Validation, EncodingKey, DecodingKey};
use serde::{Deserialize, Serialize};
use chrono::{Utc, Duration};

#[derive(Serialize, Deserialize)]
struct Claims {
    sub: String,
    exp: usize,
}

#[derive(Deserialize)]
struct LoginRequest {
    username: String,
    password: String,
}

#[derive(Serialize)]
struct LoginResponse {
    token: String,
}

async fn login(Json(req): Json<LoginRequest>) -> Result<Json<LoginResponse>, StatusCode> {
    // 验证用户（实际应查询数据库）
    if req.username == "admin" && req.password == "password" {
        let claims = Claims {
            sub: req.username,
            exp: (Utc::now() + Duration::hours(24)).timestamp() as usize,
        };
        
        let token = encode(
            &Header::default(),
            &claims,
            &EncodingKey::from_secret("secret".as_ref()),
        ).map_err(|_| StatusCode::INTERNAL_SERVER_ERROR)?;
        
        Ok(Json(LoginResponse { token }))
    } else {
        Err(StatusCode::UNAUTHORIZED)
    }
}

#[tokio::main]
async fn main() {
    let app = Router::new()
        .route("/login", post(login));
    
    let listener = tokio::net::TcpListener::bind("0.0.0.0:3000")
        .await
        .unwrap();
    axum::serve(listener, app).await.unwrap();
}
```

---

## 🚀 3. Rocket - 快速开发

### 📊 项目信息
- **GitHub**: [SergioBenitez/Rocket](https://github.com/SergioBenitez/Rocket)
- **Stars**: 24,000+
- **特点**: 类型安全，代码简洁，开发效率高
- **优势**: 最易上手的 Rust Web 框架

### 🎯 核心特性

**1. 优雅的路由**
```rust
#[macro_use] extern crate rocket;

use rocket::serde::{Deserialize, Serialize, json::Json};

#[derive(Serialize, Deserialize)]
struct User {
    id: u32,
    name: String,
}

#[get("/")]
fn index() -> &'static str {
    "Hello, Rocket!"
}

#[get("/hello/<name>")]
fn hello(name: &str) -> String {
    format!("Hello, {}!", name)
}

#[get("/users/<id>")]
fn get_user(id: u32) -> Json<User> {
    Json(User {
        id,
        name: "John Doe".to_string(),
    })
}

#[post("/users", data = "<user>")]
fn create_user(user: Json<User>) -> Json<User> {
    user
}

#[launch]
fn rocket() -> _ {
    rocket::build()
        .mount("/", routes![index, hello])
        .mount("/api", routes![get_user, create_user])
}
```

**2. 请求守卫（Request Guards）**
```rust
use rocket::request::{self, Request, FromRequest};
use rocket::outcome::Outcome;

struct ApiKey(String);

#[rocket::async_trait]
impl<'r> FromRequest<'r> for ApiKey {
    type Error = ();

    async fn from_request(req: &'r Request<'_>) -> request::Outcome<Self, Self::Error> {
        match req.headers().get_one("x-api-key") {
            Some(key) if key == "valid_key" => Outcome::Success(ApiKey(key.to_string())),
            _ => Outcome::Error((rocket::http::Status::Unauthorized, ())),
        }
    }
}

#[get("/protected")]
fn protected(_key: ApiKey) -> &'static str {
    "You have access!"
}
```

**3. 状态管理**
```rust
use rocket::State;
use std::sync::Mutex;

struct HitCount {
    count: Mutex<u32>,
}

#[get("/count")]
fn count(hit_count: &State<HitCount>) -> String {
    let mut count = hit_count.count.lock().unwrap();
    *count += 1;
    format!("Page hits: {}", count)
}

#[launch]
fn rocket() -> _ {
    rocket::build()
        .manage(HitCount { count: Mutex::new(0) })
        .mount("/", routes![count])
}
```

---

## 📦 经典开源项目

### 1. RealWorld - 完整示例应用

**项目**: [realworld-rs](https://github.com/TatriX/realworld-rust-rocket)
- **技术栈**: Rocket + Diesel + PostgreSQL
- **功能**: 完整的博客平台（Medium 克隆）
- **学习价值**: ⭐⭐⭐⭐⭐

**特性**:
- ✅ 用户注册/登录
- ✅ JWT 认证
- ✅ 文章 CRUD
- ✅ 评论系统
- ✅ 关注功能
- ✅ 标签系统

### 2. webapp.rs - 全栈 Rust 应用

**项目**: [saschagrunert/webapp.rs](https://github.com/saschagrunert/webapp.rs)
- **技术栈**: Actix-Web + Yew + PostgreSQL + Docker
- **特点**: 前后端都用 Rust

**架构**:
```
webapp.rs/
├── backend/          # Actix-Web API
├── frontend/         # Yew WASM
├── shared/           # 共享类型
└── docker/           # 容器化部署
```

### 3. Conduit - API 后端

**项目**: [gothinkster/rust-realworld-example-app](https://github.com/gothinkster/rust-realworld-example-app)
- **技术栈**: Actix-Web + SQLx + PostgreSQL
- **特点**: RESTful API 最佳实践

### 4. Rust Web App Template

**项目**: [rust10x/rust-web-app](https://github.com/rust10x/rust-web-app)
- **技术栈**: Axum + SeaORM + PostgreSQL
- **特点**: 生产级模板

**模块化架构**:
```rust
rust-web-app/
├── crates/
│   ├── libs/
│   │   ├── lib-auth/      # 认证模块
│   │   ├── lib-core/      # 核心功能
│   │   └── lib-rpc/       # RPC 层
│   └── services/
│       └── web-server/    # Web 服务
```

---

## 🏗️ 完整应用架构

### 典型的 Rust Web 应用架构

```
项目结构：

my-web-app/
├── src/
│   ├── main.rs           # 入口
│   ├── config.rs         # 配置
│   ├── routes/           # 路由
│   │   ├── mod.rs
│   │   ├── users.rs
│   │   └── posts.rs
│   ├── handlers/         # 处理器
│   │   ├── mod.rs
│   │   ├── user_handler.rs
│   │   └── post_handler.rs
│   ├── models/           # 数据模型
│   │   ├── mod.rs
│   │   ├── user.rs
│   │   └── post.rs
│   ├── db/               # 数据库
│   │   ├── mod.rs
│   │   └── schema.rs
│   ├── middleware/       # 中间件
│   │   ├── mod.rs
│   │   └── auth.rs
│   └── utils/            # 工具函数
│       └── mod.rs
├── migrations/           # 数据库迁移
├── tests/                # 测试
├── Cargo.toml
└── .env
```

### 完整示例：博客系统

**1. 项目初始化**
```bash
cargo new blog-api
cd blog-api
```

**2. 依赖配置** (`Cargo.toml`)
```toml
[package]
name = "blog-api"
version = "0.1.0"
edition = "2021"

[dependencies]
# Web 框架
axum = "0.7"
tokio = { version = "1", features = ["full"] }
tower = "0.4"
tower-http = { version = "0.5", features = ["fs", "cors", "trace"] }

# 序列化
serde = { version = "1", features = ["derive"] }
serde_json = "1"

# 数据库
sqlx = { version = "0.7", features = ["runtime-tokio-rustls", "postgres", "uuid", "chrono"] }

# 认证
jsonwebtoken = "9"
bcrypt = "0.15"

# 工具
chrono = { version = "0.4", features = ["serde"] }
uuid = { version = "1", features = ["v4", "serde"] }
dotenv = "0.15"
tracing = "0.1"
tracing-subscriber = "0.3"
```

**3. 数据模型** (`src/models/user.rs`)
```rust
use serde::{Deserialize, Serialize};
use sqlx::FromRow;
use uuid::Uuid;
use chrono::{DateTime, Utc};

#[derive(Debug, Serialize, Deserialize, FromRow)]
pub struct User {
    pub id: Uuid,
    pub username: String,
    pub email: String,
    #[serde(skip_serializing)]
    pub password_hash: String,
    pub created_at: DateTime<Utc>,
}

#[derive(Debug, Deserialize)]
pub struct CreateUser {
    pub username: String,
    pub email: String,
    pub password: String,
}

#[derive(Debug, Deserialize)]
pub struct LoginUser {
    pub email: String,
    pub password: String,
}

#[derive(Debug, Serialize)]
pub struct UserResponse {
    pub id: Uuid,
    pub username: String,
    pub email: String,
}

impl From<User> for UserResponse {
    fn from(user: User) -> Self {
        Self {
            id: user.id,
            username: user.username,
            email: user.email,
        }
    }
}
```

**4. 数据库层** (`src/db/users.rs`)
```rust
use sqlx::PgPool;
use uuid::Uuid;
use bcrypt::{hash, verify, DEFAULT_COST};
use crate::models::user::{User, CreateUser};

pub async fn create_user(
    pool: &PgPool,
    user_data: CreateUser,
) -> Result<User, sqlx::Error> {
    let password_hash = hash(user_data.password, DEFAULT_COST).unwrap();
    
    let user = sqlx::query_as::<_, User>(
        r#"
        INSERT INTO users (id, username, email, password_hash)
        VALUES ($1, $2, $3, $4)
        RETURNING *
        "#,
    )
    .bind(Uuid::new_v4())
    .bind(&user_data.username)
    .bind(&user_data.email)
    .bind(&password_hash)
    .fetch_one(pool)
    .await?;
    
    Ok(user)
}

pub async fn find_user_by_email(
    pool: &PgPool,
    email: &str,
) -> Result<Option<User>, sqlx::Error> {
    let user = sqlx::query_as::<_, User>(
        "SELECT * FROM users WHERE email = $1"
    )
    .bind(email)
    .fetch_optional(pool)
    .await?;
    
    Ok(user)
}

pub async fn verify_password(user: &User, password: &str) -> bool {
    verify(password, &user.password_hash).unwrap_or(false)
}
```

**5. 路由处理** (`src/handlers/user_handler.rs`)
```rust
use axum::{
    extract::State,
    Json,
    http::StatusCode,
    response::IntoResponse,
};
use crate::{
    models::user::{CreateUser, LoginUser, UserResponse},
    db::users,
    AppState,
};

pub async fn register(
    State(state): State<AppState>,
    Json(user_data): Json<CreateUser>,
) -> impl IntoResponse {
    match users::create_user(&state.pool, user_data).await {
        Ok(user) => {
            let response: UserResponse = user.into();
            (StatusCode::CREATED, Json(response)).into_response()
        }
        Err(e) => {
            (StatusCode::INTERNAL_SERVER_ERROR, e.to_string()).into_response()
        }
    }
}

pub async fn login(
    State(state): State<AppState>,
    Json(login_data): Json<LoginUser>,
) -> impl IntoResponse {
    match users::find_user_by_email(&state.pool, &login_data.email).await {
        Ok(Some(user)) => {
            if users::verify_password(&user, &login_data.password).await {
                // 生成 JWT token
                let token = generate_token(&user);
                (StatusCode::OK, Json(serde_json::json!({
                    "token": token,
                    "user": UserResponse::from(user),
                }))).into_response()
            } else {
                (StatusCode::UNAUTHORIZED, "Invalid credentials").into_response()
            }
        }
        Ok(None) => {
            (StatusCode::UNAUTHORIZED, "Invalid credentials").into_response()
        }
        Err(e) => {
            (StatusCode::INTERNAL_SERVER_ERROR, e.to_string()).into_response()
        }
    }
}

fn generate_token(user: &User) -> String {
    // JWT token 生成逻辑
    "token".to_string()
}
```

**6. 主程序** (`src/main.rs`)
```rust
use axum::{
    routing::{get, post},
    Router,
};
use sqlx::postgres::PgPoolOptions;
use std::sync::Arc;
use tower_http::cors::CorsLayer;

mod models;
mod db;
mod handlers;

#[derive(Clone)]
pub struct AppState {
    pub pool: Arc<sqlx::PgPool>,
}

#[tokio::main]
async fn main() {
    dotenv::dotenv().ok();
    tracing_subscriber::fmt::init();

    // 数据库连接
    let database_url = std::env::var("DATABASE_URL")
        .expect("DATABASE_URL must be set");
    
    let pool = PgPoolOptions::new()
        .max_connections(5)
        .connect(&database_url)
        .await
        .expect("Failed to create pool");

    let state = AppState {
        pool: Arc::new(pool),
    };

    // 路由
    let app = Router::new()
        .route("/", get(|| async { "Blog API" }))
        .route("/api/register", post(handlers::user_handler::register))
        .route("/api/login", post(handlers::user_handler::login))
        .layer(CorsLayer::permissive())
        .with_state(state);

    // 启动服务器
    let listener = tokio::net::TcpListener::bind("0.0.0.0:3000")
        .await
        .unwrap();
    
    tracing::info!("Server running on http://0.0.0.0:3000");
    
    axum::serve(listener, app).await.unwrap();
}
```

---

## 📚 学习路线

### 阶段 1：基础入门（2-3 周）

```
Week 1: Rust 基础复习
├─ 所有权和借用
├─ 异步编程基础
├─ Tokio 运行时
└─ async/await 语法

Week 2: 选择框架并学习
├─ 推荐：从 Axum 或 Rocket 开始
├─ 完成官方教程
├─ 理解路由和处理器
└─ 实现简单的 CRUD API

Week 3: 数据库集成
├─ SQLx 或 Diesel
├─ 连接池管理
├─ 查询构建
└─ 迁移管理
```

### 阶段 2：进阶实践（4-6 周）

```
Week 4-5: 认证和授权
├─ JWT 实现
├─ 密码哈希（bcrypt）
├─ 中间件编写
└─ 权限控制

Week 6-7: 高级特性
├─ 文件上传
├─ WebSocket
├─ 缓存（Redis）
└─ 后台任务

Week 8-9: 测试和部署
├─ 单元测试
├─ 集成测试
├─ Docker 容器化
└─ CI/CD 配置
```

### 阶段 3：生产实践（8-12 周）

```
Week 10-12: 性能优化
├─ 数据库查询优化
├─ 连接池调优
├─ 响应缓存
└─ 负载测试

Week 13-15: 微服务
├─ gRPC 通信
├─ 服务发现
├─ 分布式追踪
└─ 消息队列

Week 16-18: 完整项目
├─ 需求设计
├─ 架构规划
├─ 开发实现
└─ 上线部署
```

---

## 🧪 测试示例

### 单元测试

```rust
#[cfg(test)]
mod tests {
    use super::*;
    
    #[test]
    fn test_user_creation() {
        let user = User {
            id: 1,
            name: "Test User".to_string(),
            email: "test@example.com".to_string(),
        };
        
        assert_eq!(user.name, "Test User");
        assert_eq!(user.email, "test@example.com");
    }
}
```

### 集成测试（Axum）

```rust
use axum::{
    body::Body,
    http::{Request, StatusCode},
};
use tower::ServiceExt;

#[tokio::test]
async fn test_get_users() {
    let app = create_app();
    
    let response = app
        .oneshot(Request::builder().uri("/users").body(Body::empty()).unwrap())
        .await
        .unwrap();
    
    assert_eq!(response.status(), StatusCode::OK);
}
```

---

## 🐳 Docker 部署

### Dockerfile

```dockerfile
# 构建阶段
FROM rust:1.75 as builder

WORKDIR /app
COPY . .

RUN cargo build --release

# 运行阶段
FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

COPY --from=builder /app/target/release/blog-api /usr/local/bin/

EXPOSE 3000

CMD ["blog-api"]
```

### docker-compose.yml

```yaml
version: '3.8'

services:
  app:
    build: .
    ports:
      - "3000:3000"
    environment:
      - DATABASE_URL=postgres://user:password@db:5432/blogdb
      - RUST_LOG=info
    depends_on:
      - db
      - redis

  db:
    image: postgres:15
    environment:
      - POSTGRES_DB=blogdb
      - POSTGRES_USER=user
      - POSTGRES_PASSWORD=password
    volumes:
      - postgres_data:/var/lib/postgresql/data

  redis:
    image: redis:7-alpine
    ports:
      - "6379:6379"

volumes:
  postgres_data:
```

---

## 📊 性能对比（基准测试）

### TechEmpower Benchmark 结果

```
框架性能排名（请求/秒）：

1. Actix-Web:  ~700K req/s
2. Axum:       ~650K req/s
3. Rocket:     ~400K req/s
4. Warp:       ~550K req/s
5. Tide:       ~350K req/s
```

### 延迟对比

```
平均响应时间（JSON 序列化）：

Actix-Web:  0.8ms
Axum:       1.0ms
Rocket:     1.5ms
Warp:       1.1ms
```

---

## 🎯 选择建议

### 选择 Actix-Web 如果：
- ✅ 需要极致性能
- ✅ 构建高并发 API
- ✅ 有 Actor 模型经验
- ✅ 成熟的生态系统

### 选择 Axum 如果：
- ✅ 喜欢现代化设计
- ✅ 使用 Tokio 生态
- ✅ 重视开发体验
- ✅ 需要强类型保证

### 选择 Rocket 如果：
- ✅ 快速原型开发
- ✅ 初学者友好
- ✅ 喜欢声明式 API
- ✅ 需要完善文档

---

## 📖 推荐资源

### 书籍
- "Zero to Production in Rust" by Luca Palmieri
- "Rust Web Development" by Bastian Gruber
- "Hands-On Microservices with Rust" by Denis Kolodin

### 在线课程
- [Rust Web Development Course](https://www.udemy.com/course/rust-web-development/)
- [Building Web APIs with Rust](https://www.educative.io/courses/rust-web-apis)

### 博客
- [Luca Palmieri's Blog](https://www.lpalmieri.com/)
- [Actix Web Blog](https://actix.rs/blog/)
- [Tokio Blog](https://tokio.rs/blog/)

### GitHub 仓库
- [awesome-rust](https://github.com/rust-unofficial/awesome-rust)
- [realworld](https://github.com/gothinkster/realworld)
- [rust-web-framework-comparison](https://github.com/flosse/rust-web-framework-comparison)

---

## 🔥 生产案例

### 使用 Rust Web 的知名公司

**Discord**
- 技术：Rust + Actix-Web
- 场景：高性能消息服务
- 效果：延迟降低 90%

**Cloudflare**
- 技术：Rust + 自研框架
- 场景：边缘计算
- 效果：处理数百万请求/秒

**Microsoft**
- 技术：Rust + Axum
- 场景：Azure 服务
- 效果：内存使用减少 50%

**Figma**
- 技术：Rust + WebAssembly
- 场景：多人协作引擎
- 效果：性能提升 10 倍

---

## 💡 最佳实践

### 1. 项目结构
```
✅ 模块化设计
✅ 清晰的职责分离
✅ 可测试的代码
✅ 文档完善
```

### 2. 错误处理
```rust
// 使用 Result 和自定义错误类型
use thiserror::Error;

#[derive(Error, Debug)]
pub enum AppError {
    #[error("Database error: {0}")]
    Database(#[from] sqlx::Error),
    
    #[error("Not found")]
    NotFound,
    
    #[error("Unauthorized")]
    Unauthorized,
}
```

### 3. 配置管理
```rust
// 使用 config crate
use config::{Config, ConfigError, Environment, File};

#[derive(Debug, Deserialize)]
pub struct Settings {
    pub database_url: String,
    pub server_port: u16,
    pub jwt_secret: String,
}

impl Settings {
    pub fn new() -> Result<Self, ConfigError> {
        Config::builder()
            .add_source(File::with_name("config/default"))
            .add_source(Environment::with_prefix("APP"))
            .build()?
            .try_deserialize()
    }
}
```

### 4. 日志记录
```rust
use tracing::{info, error, debug};

#[tokio::main]
async fn main() {
    tracing_subscriber::fmt()
        .with_max_level(tracing::Level::INFO)
        .init();
    
    info!("Starting server...");
}
```

---

## 🎓 总结

Rust Web 开发生态系统已经非常成熟：

**优势**：
- 🚀 **性能卓越** - 接近 C++ 的速度
- 🛡️ **内存安全** - 编译时保证
- 🔧 **类型安全** - 减少运行时错误
- 📦 **优秀工具** - Cargo、Clippy、rustfmt
- 🌍 **活跃社区** - 持续发展

**应用场景**：
- ✅ 高性能 API 服务
- ✅ 微服务架构
- ✅ 实时应用（WebSocket）
- ✅ 边缘计算
- ✅ 云原生应用

**开始建议**：
1. 从 **Axum** 或 **Rocket** 开始
2. 学习异步编程基础
3. 掌握数据库操作
4. 实践完整项目
5. 参与开源贡献

---

## 🔗 相关笔记

- [[00-Index/Rust-MOC|Rust 知识地图]]
- [[00-Index/Learning-Roadmap|学习路线图]]
- [[06-Projects/projects|GitHub 项目推荐]]
- [[06-Projects/Rust-WebAssembly-Guide|Rust + WebAssembly]]
- [[02-Advanced-Concepts/Async-Await|异步编程]]

---

**开始你的 Rust Web 开发之旅吧！** 🚀

---

#rust #web #backend #actix #axum #rocket #api #fullstack #tutorial

*最后更新: 2024-01-15*
*版本: 1.0.0*