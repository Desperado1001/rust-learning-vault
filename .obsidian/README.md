# 🔧 Obsidian Configuration Guide

[English](#english) | [中文](#中文)

---

<a name="english"></a>

## 📖 English

### What is This Folder?

The `.obsidian` folder contains all the configuration for this Obsidian vault. This configuration is **committed to the repository** to provide an **out-of-the-box experience** for all users.

### 🎯 Pre-configured Features

This vault comes with a carefully crafted configuration that includes:

- ✅ **Core Plugins** - All essential Obsidian features enabled
- ✅ **Templates Setup** - Automatic template folder configuration
- ✅ **Daily Notes** - Pre-configured with custom location and template
- ✅ **Graph View** - Color-coded by folder for visual organization
- ✅ **Hotkeys** - Productivity-boosting keyboard shortcuts
- ✅ **Appearance** - Beautiful, readable default theme

### 📁 Configuration Files

| File | Purpose |
|------|---------|
| `app.json` | Main application settings (font size, line breaks, spellcheck, etc.) |
| `appearance.json` | Theme and visual settings |
| `core-plugins.json` | List of enabled core plugins |
| `community-plugins.json` | List of installed community plugins |
| `templates.json` | Template folder location and format settings |
| `daily-notes.json` | Daily notes configuration (folder, format, template) |
| `graph.json` | Graph view colors and layout settings |
| `hotkeys.json` | Custom keyboard shortcuts |
| `workspace.json` | **(Not included)** Your personal workspace layout |

> **Note:** `workspace.json` and `workspace-mobile.json` are intentionally not committed as they contain your personal layout preferences.

### 🎨 Graph View Colors

The graph view is pre-configured with distinct colors for each folder:

- 🔴 **00-Index** - Red (Starting point)
- 🟠 **01-Fundamentals** - Orange
- 🟡 **02-Advanced-Concepts** - Yellow
- 🟢 **03-Standard-Library** - Green
- 🔵 **04-Ecosystem** - Cyan
- 🟣 **05-Patterns-and-Practices** - Blue
- 🟣 **06-Projects** - Purple
- 🟣 **07-Code-Snippets** - Magenta
- 🟤 **08-Daily-Learning** - Brown
- 🟠 **09-Questions-and-Answers** - Light Orange
- ⚫ **10-Templates** - Gray

### ⌨️ Essential Hotkeys

| Action | Shortcut (Windows/Linux) | Shortcut (Mac) |
|--------|-------------------------|----------------|
| **Navigation** |
| Quick Switcher | `Ctrl + O` | `Cmd + O` |
| Command Palette | `Ctrl + Shift + P` | `Cmd + Shift + P` |
| Open Graph View | `Ctrl + G` | `Cmd + G` |
| Open Local Graph | `Ctrl + Shift + G` | `Cmd + Shift + G` |
| Reveal in File Explorer | `Ctrl + Shift + E` | `Cmd + Shift + E` |
| Open Outline | `Ctrl + Shift + O` | `Cmd + Shift + O` |
| **Daily Notes** |
| Open Today's Note | `Ctrl + Shift + D` | `Cmd + Shift + D` |
| **Templates** |
| Insert Template | `Ctrl + T` | `Cmd + T` |
| **Editing** |
| Toggle Bold | `Ctrl + B` | `Cmd + B` |
| Toggle Italic | `Ctrl + I` | `Cmd + I` |
| Toggle Code | `Ctrl + \`` | `Cmd + \`` |
| Insert Link | `Ctrl + K` | `Cmd + K` |
| Toggle Highlight | `Ctrl + Shift + H` | `Cmd + Shift + H` |
| Toggle Checklist | `Ctrl + Enter` | `Cmd + Enter` |
| **Window Management** |
| Split Vertical | `Ctrl + \` | `Cmd + \` |
| Split Horizontal | `Ctrl + Shift + \` | `Cmd + Shift + \` |
| Close Tab | `Ctrl + W` | `Cmd + W` |
| Reopen Closed Tab | `Ctrl + Shift + T` | `Cmd + Shift + T` |

### 🔌 Recommended Community Plugins

While the vault works great out-of-the-box, these community plugins can enhance your experience:

#### Essential (⭐⭐⭐)
1. **Calendar** - Visual calendar for daily notes
2. **Dataview** - Query and display data dynamically
3. **Templater** - Advanced template features with scripting

#### Highly Recommended (⭐⭐)
4. **Tasks** - Advanced task management with queries
5. **Kanban** - Kanban board for project tracking
6. **Excalidraw** - Draw diagrams and sketches

#### Nice to Have (⭐)
7. **Advanced Tables** - Better table editing
8. **Tag Wrangler** - Manage tags efficiently
9. **Periodic Notes** - Weekly/monthly note support
10. **Breadcrumbs** - Navigate hierarchical structures

### 📥 How to Install Community Plugins

1. Open Obsidian Settings (`Ctrl/Cmd + ,`)
2. Go to **Community Plugins**
3. Click **Turn on community plugins** (if first time)
4. Click **Browse** button
5. Search for the plugin name
6. Click **Install**, then **Enable**

### 🎛️ Customizing Your Configuration

All settings can be customized through:
- **Settings Panel** - `Ctrl/Cmd + ,`
- **Appearance Tab** - Change theme, fonts, colors
- **Hotkeys Tab** - Customize keyboard shortcuts
- **Plugin Settings** - Configure each plugin

Your changes will be saved in this folder. If you want to keep your custom configuration private, make sure not to commit your changes to `app.json`, `hotkeys.json`, etc.

### 🔄 Syncing Your Configuration

If you're using this vault across multiple devices:

**Option 1: Git (Recommended)**
- Commit configuration changes
- Pull on other devices
- Your setup stays in sync

**Option 2: Obsidian Sync**
- Obsidian Sync syncs configuration automatically
- Paid service from Obsidian

**Option 3: Cloud Storage**
- Place vault in Dropbox/OneDrive/iCloud
- Configuration syncs automatically

### 🆘 Troubleshooting

**Issue: Graph view looks different**
- Solution: Open Settings → Graph → Reset to default, then reload vault

**Issue: Hotkeys not working**
- Solution: Check Settings → Hotkeys for conflicts

**Issue: Daily notes not using template**
- Solution: Verify Settings → Daily notes → Template file location

**Issue: Settings keep resetting**
- Solution: Make sure `.obsidian` folder is not being ignored by git/sync

---

<a name="中文"></a>

## 📖 中文

### 这个文件夹是什么？

`.obsidian` 文件夹包含了这个 Obsidian 仓库的所有配置。这些配置**已提交到仓库**，以便为所有用户提供**开箱即用的体验**。

### 🎯 预配置功能

这个知识库包含了精心设计的配置，包括：

- ✅ **核心插件** - 所有必要的 Obsidian 功能已启用
- ✅ **模板设置** - 自动配置模板文件夹
- ✅ **每日笔记** - 预配置自定义位置和模板
- ✅ **图谱视图** - 按文件夹颜色编码，便于可视化组织
- ✅ **快捷键** - 提高生产力的键盘快捷键
- ✅ **外观** - 美观、易读的默认主题

### 📁 配置文件说明

| 文件 | 用途 |
|------|------|
| `app.json` | 主应用设置（字体大小、换行、拼写检查等）|
| `appearance.json` | 主题和视觉设置 |
| `core-plugins.json` | 已启用的核心插件列表 |
| `community-plugins.json` | 已安装的社区插件列表 |
| `templates.json` | 模板文件夹位置和格式设置 |
| `daily-notes.json` | 每日笔记配置（文件夹、格式、模板）|
| `graph.json` | 图谱视图颜色和布局设置 |
| `hotkeys.json` | 自定义键盘快捷键 |
| `workspace.json` | **（未包含）**你的个人工作区布局 |

> **注意：** `workspace.json` 和 `workspace-mobile.json` 故意未提交，因为它们包含你的个人布局偏好。

### 🎨 图谱视图颜色

图谱视图预配置了每个文件夹的独特颜色：

- 🔴 **00-Index** - 红色（起点）
- 🟠 **01-Fundamentals** - 橙色
- 🟡 **02-Advanced-Concepts** - 黄色
- 🟢 **03-Standard-Library** - 绿色
- 🔵 **04-Ecosystem** - 青色
- 🟣 **05-Patterns-and-Practices** - 蓝色
- 🟣 **06-Projects** - 紫色
- 🟣 **07-Code-Snippets** - 品红
- 🟤 **08-Daily-Learning** - 棕色
- 🟠 **09-Questions-and-Answers** - 浅橙色
- ⚫ **10-Templates** - 灰色

### ⌨️ 常用快捷键

| 操作 | 快捷键 (Windows/Linux) | 快捷键 (Mac) |
|------|----------------------|--------------|
| **导航** |
| 快速切换 | `Ctrl + O` | `Cmd + O` |
| 命令面板 | `Ctrl + Shift + P` | `Cmd + Shift + P` |
| 打开图谱视图 | `Ctrl + G` | `Cmd + G` |
| 打开局部图谱 | `Ctrl + Shift + G` | `Cmd + Shift + G` |
| 在文件管理器中显示 | `Ctrl + Shift + E` | `Cmd + Shift + E` |
| 打开大纲 | `Ctrl + Shift + O` | `Cmd + Shift + O` |
| **每日笔记** |
| 打开今日笔记 | `Ctrl + Shift + D` | `Cmd + Shift + D` |
| **模板** |
| 插入模板 | `Ctrl + T` | `Cmd + T` |
| **编辑** |
| 切换粗体 | `Ctrl + B` | `Cmd + B` |
| 切换斜体 | `Ctrl + I` | `Cmd + I` |
| 切换代码 | `Ctrl + \`` | `Cmd + \`` |
| 插入链接 | `Ctrl + K` | `Cmd + K` |
| 切换高亮 | `Ctrl + Shift + H` | `Cmd + Shift + H` |
| 切换检查列表 | `Ctrl + Enter` | `Cmd + Enter` |
| **窗口管理** |
| 垂直分割 | `Ctrl + \` | `Cmd + \` |
| 水平分割 | `Ctrl + Shift + \` | `Cmd + Shift + \` |
| 关闭标签页 | `Ctrl + W` | `Cmd + W` |
| 重新打开已关闭标签页 | `Ctrl + Shift + T` | `Cmd + Shift + T` |

### 🔌 推荐的社区插件

虽然这个知识库开箱即用效果很好，但这些社区插件可以增强你的体验：

#### 必备 (⭐⭐⭐)
1. **Calendar** - 每日笔记的可视化日历
2. **Dataview** - 动态查询和展示数据
3. **Templater** - 带脚本的高级模板功能

#### 强烈推荐 (⭐⭐)
4. **Tasks** - 高级任务管理与查询
5. **Kanban** - 项目追踪看板
6. **Excalidraw** - 绘制图表和草图

#### 锦上添花 (⭐)
7. **Advanced Tables** - 更好的表格编辑
8. **Tag Wrangler** - 高效管理标签
9. **Periodic Notes** - 周/月笔记支持
10. **Breadcrumbs** - 导航层级结构

### 📥 如何安装社区插件

1. 打开 Obsidian 设置（`Ctrl/Cmd + ,`）
2. 进入**社区插件**
3. 点击**开启社区插件**（如果是第一次）
4. 点击**浏览**按钮
5. 搜索插件名称
6. 点击**安装**，然后**启用**

### 🎛️ 自定义配置

所有设置都可以通过以下方式自定义：
- **设置面板** - `Ctrl/Cmd + ,`
- **外观标签** - 更改主题、字体、颜色
- **快捷键标签** - 自定义键盘快捷键
- **插件设置** - 配置每个插件

你的更改将保存在此文件夹中。如果你想保持自定义配置私密，请确保不要提交对 `app.json`、`hotkeys.json` 等的更改。

### 🔄 同步配置

如果你在多个设备上使用这个知识库：

**方案 1：Git（推荐）**
- 提交配置更改
- 在其他设备上拉取
- 你的设置保持同步

**方案 2：Obsidian Sync**
- Obsidian Sync 自动同步配置
- Obsidian 的付费服务

**方案 3：云存储**
- 将知识库放在 Dropbox/OneDrive/坚果云/iCloud
- 配置自动同步

### 🆘 故障排除

**问题：图谱视图看起来不同**
- 解决方案：打开设置 → 图谱 → 重置为默认，然后重新加载知识库

**问题：快捷键不工作**
- 解决方案：检查设置 → 快捷键是否有冲突

**问题：每日笔记未使用模板**
- 解决方案：验证设置 → 每日笔记 → 模板文件位置

**问题：设置总是重置**
- 解决方案：确保 `.obsidian` 文件夹没有被 git/同步工具忽略

---

## 📚 Additional Resources

- [Obsidian Help](https://help.obsidian.md/)
- [Obsidian Forum](https://forum.obsidian.md/)
- [Obsidian Discord](https://discord.gg/obsidianmd)
- [Community Plugins Directory](https://obsidian.md/plugins)

---

<div align="center">

**Enjoy your optimized Obsidian experience!** 🎉

*Made with ❤️ for the Rust Learning Community*

</div>