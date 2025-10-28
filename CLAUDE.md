# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a **Rust Learning Vault** - a comprehensive knowledge base built with Obsidian for systematic Rust language learning. It's structured as a Knowledge Accumulation Workflow (KAW) system with bidirectional linking, atomic notes, and visual knowledge graphs.

**Key Characteristics:**
- Educational content repository, not a software project
- Contains 10,000+ lines of learning materials in Chinese and English
- Emphasis on Rust + WebAssembly development
- Complete Obsidian configuration included for out-of-the-box experience
- No traditional build process - this is a knowledge management system

## Repository Structure

The vault follows a carefully designed learning progression:

```
rust_vault/
├── 00-Index/                   # 📍 Start here - Central hub and navigation
│   ├── Rust-MOC.md           # 🌟 Master Index (main entry point)
│   ├── Learning-Roadmap.md   # 🗺️ 16-week structured learning path
│   └── How-To-Use-This-Vault.md
├── 01-Fundamentals/           # 📘 Core Rust concepts (Ownership, Borrowing, etc.)
├── 02-Advanced-Concepts/      # 🎓 Advanced topics (Traits, Async, Macros)
├── 03-Standard-Library/       # 📦 Std library reference
├── 04-Ecosystem/              # 🌐 Crates and tools (Cargo, Serde, Tokio)
├── 05-Patterns-and-Practices/ # 🎨 Best practices and design patterns
├── 06-Projects/               # 🚀 Practical projects and WebAssembly guides
├── 07-Code-Snippets/          # 💾 Reusable code examples
├── 08-Daily-Learning/         # 📅 Learning journals and progress tracking
├── 09-Questions-and-Answers/  # ❓ Problem solving and FAQs
├── 10-Templates/              # 📝 Note creation templates
└── .obsidian/                 # ⚙️ Complete Obsidian configuration
```

## Working with This Repository

### Content Creation Workflow

1. **Always start from `00-Index/Rust-MOC.md`** - This is the central hub
2. **Use the template system** in `10-Templates/` for consistent note creation
3. **Follow bidirectional linking** convention with `[[double brackets]]`
4. **Apply the tagging system** consistently (see Tagging Convention below)

### Essential Templates

- **`10-Templates/Concept-Template.md`** - For learning new Rust concepts
- **`10-Templates/Daily-Learning-Template.md`** - For progress tracking
- **`10-Templates/Code-Snippet-Template.md`** - For reusable code examples

### Tagging Convention

```markdown
# Type Tags
#concept #snippet #project #question #resource

# Difficulty
#easy #medium #hard

# Status
#learning #understood #mastered #review

# Topic Tags
#ownership #async #macros #wasm #web #fundamentals #advanced
```

## Obsidian Configuration

This repository includes a complete `.obsidian/` configuration for an out-of-the-box experience:

### Key Features
- **Pre-configured graph colors** by folder for visual organization
- **Custom hotkeys** for productivity (see `.obsidian/README.md`)
- **Template system** ready to use
- **Daily notes** with custom location and templates
- **Essential plugins** enabled

### Critical Hotkeys
- `Ctrl/Cmd + G` - Open graph view
- `Ctrl/Cmd + Shift + D` - Open today's note
- `Ctrl/Cmd + T` - Insert template
- `Ctrl/Cmd + O` - Quick switcher

## Content Guidelines

### Writing Style
- **Bilingual content**: Primary Chinese with English terminology
- **Code-first approach**: Every concept includes runnable examples
- **Atomic notes**: One concept per note with cross-references
- **Progressive complexity**: From basics to production-ready examples

### High-Value Content Areas
1. **`06-Projects/Rust-WebAssembly-Guide.md`** (1250 lines) - Comprehensive WASM tutorial
2. **`06-Projects/Rust-Web-Projects.md`** (1292 lines) - 5 major web frameworks
3. **`01-Fundamentals/Ownership.md`** (439 lines) - In-depth ownership explanation
4. **`00-Index/Learning-Roadmap.md`** (584 lines) - 16-week structured path

### Note Structure Standards
Each concept note should include:
- Clear definition and purpose
- Code examples with explanations
- Common errors and solutions
- Links to related concepts
- Difficulty rating and learning status

## Development Workflow

### Daily Learning Process
1. Create daily note using template from `10-Templates/`
2. Learn new concept and create concept note
3. Add code snippets to `07-Code-Snippets/`
4. Link new concepts to existing knowledge base
5. Update progress in `00-Index/Rust-MOC.md`

### Knowledge Management
- **Visual learning**: Use graph view (Ctrl+G) to identify knowledge gaps
- **Spaced repetition**: Review schedule (1d, 3d, 7d, 30d)
- **Progress tracking**: Update MOC files with learning status
- **Cross-referencing**: Minimum 3 related concepts per note

## Important Notes

- **This is not a code compilation project** - it's a knowledge management system
- **Never modify the `.obsidian/` core configuration** unless improving the setup
- **Always maintain the bilingual format** (Chinese primary, English terminology)
- **Preserve the progressive learning structure** - don't add advanced content to fundamentals folders
- **Test all code examples** before including them in notes

## Quality Standards

All content must meet these criteria:
- **Accuracy**: Code examples must compile and run
- **Clarity**: Complex concepts explained with simple language
- **Completeness**: Include common errors and solutions
- **Interconnection**: Link to at least 3 related concepts
- **Progressive**: Build from simple to complex within each topic

## File Naming Conventions

- **Concept files**: `PascalCase.md` (e.g., `Ownership.md`, `Async-Await.md`)
- **Daily notes**: `YYYY-MM-DD.md` format in `08-Daily-Learning/`
- **Code snippets**: Descriptive names with hyphens (e.g., `error-handling-example.md`)
- **Templates**: `PascalCase-Template.md` format

## Version Control

- **Commit frequently** when adding content
- **Use descriptive commit messages** following the existing pattern
- **Include `.obsidian/` changes** when improving configuration
- **Never commit personal workspace files** (`workspace.json`)

---

**Remember**: This vault's purpose is to take learners from zero Rust knowledge to production-ready development through systematic, interconnected knowledge building.