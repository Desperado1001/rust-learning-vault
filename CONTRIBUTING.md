# 🤝 Contributing to Rust Learning Vault

First off, thank you for considering contributing to the Rust Learning Vault! It's people like you that make this learning resource better for everyone. 🎉

This document provides guidelines for contributing to this project. Following these guidelines helps communicate that you respect the time of the developers managing and developing this open-source project. In return, they should reciprocate that respect in addressing your issue, assessing changes, and helping you finalize your pull requests.

## 📋 Table of Contents

- [Code of Conduct](#code-of-conduct)
- [What Can I Contribute?](#what-can-i-contribute)
- [Getting Started](#getting-started)
- [Development Workflow](#development-workflow)
- [Content Guidelines](#content-guidelines)
- [Pull Request Process](#pull-request-process)
- [Style Guide](#style-guide)
- [Community](#community)

---

## 📜 Code of Conduct

This project and everyone participating in it is governed by our commitment to provide a welcoming and inspiring community for all.

### Our Standards

**Examples of behavior that contributes to a positive environment:**

- ✅ Using welcoming and inclusive language
- ✅ Being respectful of differing viewpoints and experiences
- ✅ Gracefully accepting constructive criticism
- ✅ Focusing on what is best for the community
- ✅ Showing empathy towards other community members

**Examples of unacceptable behavior:**

- ❌ Trolling, insulting/derogatory comments, and personal or political attacks
- ❌ Public or private harassment
- ❌ Publishing others' private information without explicit permission
- ❌ Other conduct which could reasonably be considered inappropriate

---

## 🎯 What Can I Contribute?

There are many ways to contribute to this project:

### 📚 Content Contributions

- **Concept Notes** - Add explanations for Rust concepts
- **Code Snippets** - Share useful, reusable code examples
- **Project Guides** - Create hands-on project tutorials
- **Learning Paths** - Design structured learning sequences
- **Resource Links** - Curate valuable external resources
- **Templates** - Design new note templates

### 🐛 Bug Reports

- Report broken links
- Identify outdated information
- Report formatting issues
- Identify missing cross-references

### 💡 Feature Suggestions

- Propose new vault structures
- Suggest workflow improvements
- Recommend new templates
- Propose new learning paths

### 🎨 Improvements

- Fix typos and grammar
- Improve explanations
- Add diagrams and visualizations
- Enhance existing notes
- Update outdated content

### 🌍 Translations

- Help translate content to other languages
- Review existing translations
- Maintain language-specific versions

---

## 🚀 Getting Started

### Prerequisites

Before you begin, ensure you have:

1. **Obsidian** - [Download here](https://obsidian.md/)
2. **Git** - [Install Git](https://git-scm.com/downloads)
3. **GitHub Account** - [Sign up](https://github.com/signup)
4. **Basic Markdown Knowledge** - [Learn Markdown](https://www.markdownguide.org/)

### Setting Up Your Environment

1. **Fork the Repository**
   ```bash
   # Click the "Fork" button on GitHub
   ```

2. **Clone Your Fork**
   ```bash
   git clone https://github.com/YOUR_USERNAME/rust-learning-vault.git
   cd rust-learning-vault/rust_vault
   ```

3. **Open in Obsidian**
   - Launch Obsidian
   - Click "Open folder as vault"
   - Select the `rust_vault` folder

4. **Create a Branch**
   ```bash
   git checkout -b feature/your-feature-name
   # or
   git checkout -b content/concept-name
   # or
   git checkout -b fix/issue-description
   ```

---

## 🔄 Development Workflow

### Branch Naming Convention

Use descriptive branch names:

- `feature/` - New features or templates
- `content/` - New learning content
- `fix/` - Bug fixes
- `docs/` - Documentation updates
- `refactor/` - Code/content restructuring

**Examples:**
- `content/async-await-guide`
- `feature/project-template`
- `fix/broken-links-in-moc`
- `docs/update-contributing-guide`

### Making Changes

1. **Create or Edit Files**
   - Use appropriate templates from `10-Templates/`
   - Follow the vault structure conventions
   - Use consistent formatting

2. **Add Frontmatter (Optional but Recommended)**
   ```yaml
   ---
   title: Your Note Title
   tags: [rust, concept, ownership]
   difficulty: beginner
   created: 2025-10-27
   updated: 2025-10-27
   ---
   ```

3. **Link Related Concepts**
   - Use `[[wikilinks]]` to connect related notes
   - Add backlinks where appropriate
   - Update the MOC (Map of Content) if needed

4. **Test Your Changes**
   - Verify all links work
   - Check formatting in Obsidian
   - Ensure code examples are correct
   - Test on different devices if possible

5. **Commit Your Changes**
   ```bash
   git add .
   git commit -m "type: brief description"
   ```

   **Commit Message Format:**
   ```
   type: brief description
   
   Detailed explanation (optional)
   
   - Bullet point 1
   - Bullet point 2
   ```

   **Types:**
   - `feat:` - New content or feature
   - `fix:` - Bug fix or correction
   - `docs:` - Documentation changes
   - `style:` - Formatting changes
   - `refactor:` - Content restructuring
   - `chore:` - Maintenance tasks

   **Examples:**
   ```bash
   git commit -m "feat: add async/await comprehensive guide"
   git commit -m "fix: correct ownership example in Borrowing.md"
   git commit -m "docs: update README with new plugin recommendations"
   ```

---

## 📝 Content Guidelines

### Writing Style

1. **Clarity First**
   - Write in clear, simple language
   - Explain complex concepts step-by-step
   - Use analogies when helpful

2. **Be Concise**
   - Keep notes focused on one concept
   - Use bullet points for lists
   - Avoid unnecessary verbosity

3. **Be Accurate**
   - Verify all technical information
   - Test all code examples
   - Cite sources when needed

4. **Be Inclusive**
   - Use gender-neutral language
   - Avoid jargon without explanation
   - Consider diverse learning styles

### Note Structure

Every concept note should include:

```markdown
---
title: Concept Name
tags: [rust, topic, difficulty]
---

# Concept Name

## Overview
Brief introduction (2-3 sentences)

## Key Points
- Point 1
- Point 2
- Point 3

## Detailed Explanation
In-depth explanation with examples

## Code Example
```rust
// Practical, runnable code
fn example() {
    // ...
}
```

## Common Pitfalls
- Pitfall 1
- Pitfall 2

## Best Practices
- Practice 1
- Practice 2

## Related Concepts
- [[Related Concept 1]]
- [[Related Concept 2]]

## Resources
- [External Link 1](URL)
- [External Link 2](URL)

## Review
- Created: YYYY-MM-DD
- Last Reviewed: YYYY-MM-DD
- Next Review: YYYY-MM-DD
```

### Code Examples

1. **Must Be Runnable**
   ```rust
   // ✅ Good - Complete, runnable example
   fn main() {
       let x = 5;
       println!("x = {}", x);
   }
   ```

2. **Include Comments**
   ```rust
   // ❌ Avoid - Incomplete code
   let x = 5;
   ```

3. **Show Both Good and Bad**
   ```rust
   // ❌ Don't do this
   let mut x = 5;
   let y = &mut x;
   let z = &mut x; // Error!
   
   // ✅ Do this instead
   let mut x = 5;
   {
       let y = &mut x;
       *y += 1;
   } // y goes out of scope
   let z = &mut x; // OK!
   ```

4. **Test Your Code**
   - All code examples should compile
   - Use the Rust Playground to verify
   - Include expected output when relevant

### File Naming

- Use **kebab-case**: `async-await.md`
- Be descriptive: `error-handling-result-type.md`
- Avoid abbreviations: `ownership.md` not `own.md`
- Use `.md` extension for all notes

### Links and References

1. **Internal Links (Wikilinks)**
   ```markdown
   [[Ownership]]
   [[Borrowing|borrowing rules]]
   ```

2. **External Links**
   ```markdown
   [The Rust Book](https://doc.rust-lang.org/book/)
   ```

3. **Relative Links** (for images)
   ```markdown
   ![Diagram](../assets/ownership-diagram.png)
   ```

---

## 🔍 Pull Request Process

### Before Submitting

- [ ] I have tested my changes in Obsidian
- [ ] All links work correctly
- [ ] Code examples compile and run
- [ ] I have updated related notes with cross-references
- [ ] I have followed the style guide
- [ ] I have added/updated tags appropriately
- [ ] My commit messages are clear and descriptive
- [ ] I have updated the MOC if needed

### Submitting a Pull Request

1. **Push Your Branch**
   ```bash
   git push origin feature/your-feature-name
   ```

2. **Create Pull Request on GitHub**
   - Go to your fork on GitHub
   - Click "New Pull Request"
   - Select your branch
   - Fill out the PR template

3. **PR Title Format**
   ```
   type(scope): brief description
   ```
   
   **Examples:**
   - `feat(content): add async/await guide`
   - `fix(docs): correct ownership examples`
   - `docs(readme): update installation instructions`

4. **PR Description Should Include:**
   - What changes were made
   - Why these changes are needed
   - Any relevant issue numbers (#123)
   - Screenshots (if UI changes)
   - Testing performed

### PR Template

```markdown
## Description
Brief description of changes

## Type of Change
- [ ] New content (concept notes, guides, etc.)
- [ ] Bug fix (typo, broken link, incorrect info)
- [ ] Feature (new template, structure improvement)
- [ ] Documentation update

## Testing Checklist
- [ ] Tested in Obsidian
- [ ] All links verified
- [ ] Code examples compile
- [ ] Cross-references updated

## Related Issues
Closes #(issue number)

## Screenshots (if applicable)
Add screenshots here

## Additional Notes
Any additional information
```

### Review Process

1. **Automated Checks** - Ensure no merge conflicts
2. **Maintainer Review** - Code/content quality check
3. **Community Feedback** - Other learners may comment
4. **Revisions** - Address feedback if needed
5. **Approval** - Maintainer approves changes
6. **Merge** - Changes are merged into main branch

---

## 🎨 Style Guide

### Markdown Conventions

1. **Headers**
   ```markdown
   # H1 - Only for note title
   ## H2 - Major sections
   ### H3 - Subsections
   #### H4 - Sub-subsections (use sparingly)
   ```

2. **Lists**
   ```markdown
   - Unordered lists use hyphens
   - Not asterisks or plus signs
   
   1. Ordered lists use numbers
   2. Start at 1
   3. Increment by 1
   ```

3. **Code Blocks**
   ````markdown
   ```rust
   // Always specify language
   fn main() {
       println!("Hello, world!");
   }
   ```
   ````

4. **Emphasis**
   ```markdown
   **Bold** for important concepts
   *Italic* for emphasis
   `inline code` for code references
   ```

5. **Tables**
   ```markdown
   | Header 1 | Header 2 |
   |----------|----------|
   | Cell 1   | Cell 2   |
   ```

### Obsidian-Specific Features

1. **Tags**
   ```markdown
   #rust #concept #ownership #fundamental
   ```

2. **Wikilinks**
   ```markdown
   [[Ownership]]
   [[Borrowing|borrowing rules]]
   ```

3. **Callouts** (use for important notes)
   ```markdown
   > [!note]
   > This is an important note
   
   > [!warning]
   > Watch out for this common mistake
   
   > [!tip]
   > Pro tip: Use this technique
   ```

### Emoji Usage

Use emojis consistently for visual organization:

- 📖 Overview/Introduction
- 💡 Key Concepts/Ideas
- 📝 Examples
- ⚠️ Warnings/Pitfalls
- ✅ Best Practices
- ❌ Anti-patterns
- 🔗 Related Topics
- 📚 Resources
- 🎯 Goals/Objectives
- 🚀 Getting Started

---

## 🏷️ Tagging System

### Required Tags

Every note should have:
- **Language**: `#rust`
- **Type**: `#concept`, `#snippet`, `#project`, `#resource`, `#question`
- **Topic**: `#ownership`, `#async`, `#macros`, etc.

### Optional Tags

- **Difficulty**: `#beginner`, `#intermediate`, `#advanced`
- **Status**: `#learning`, `#understood`, `#mastered`, `#review`
- **Category**: `#memory`, `#concurrency`, `#web`, `#wasm`

### Example

```yaml
---
tags: [rust, concept, ownership, beginner, learning]
---
```

---

## 🎓 Learning Path Contributions

When creating learning paths:

1. **Define Prerequisites**
   - What should learners know before starting?
   - Link to prerequisite notes

2. **Set Clear Goals**
   - What will learners achieve?
   - What skills will they gain?

3. **Provide Structure**
   - Break down into manageable steps
   - Estimate time for each step
   - Include practice exercises

4. **Link Resources**
   - Internal vault notes
   - External tutorials
   - Official documentation
   - Practice projects

---

## 🧪 Testing Your Contributions

### Manual Testing

1. **Open in Obsidian**
   - Verify note renders correctly
   - Check all links work
   - Test in both edit and preview modes

2. **Check Cross-References**
   - Use Obsidian's "Linked mentions" panel
   - Verify backlinks appear correctly

3. **Test Code Examples**
   - Copy code to Rust Playground
   - Verify it compiles
   - Ensure output matches description

4. **Verify Graph View**
   - Check note appears in graph
   - Verify connections make sense

### Automated Checks (Coming Soon)

We're working on automated checks for:
- Broken links
- Markdown linting
- Code compilation
- Spell checking

---

## 📊 Project Structure

Understanding the vault structure helps you contribute effectively:

```
rust_vault/
├── 00-Index/           # Start here - MOCs and guides
├── 01-Fundamentals/    # Basic Rust concepts
├── 02-Advanced/        # Advanced topics
├── 03-Std-Library/     # Standard library reference
├── 04-Ecosystem/       # Crates and tools
├── 05-Patterns/        # Design patterns and practices
├── 06-Projects/        # Hands-on projects
├── 07-Snippets/        # Code snippet library
├── 08-Daily/           # Daily learning logs
├── 09-QA/              # Questions and answers
└── 10-Templates/       # Note templates
```

---

## 🌟 Recognition

Contributors will be recognized in:

- README.md acknowledgments section
- CONTRIBUTORS.md file (if we create one)
- Release notes for significant contributions
- Social media shout-outs for major contributions

---

## 💬 Community

### Communication Channels

- **GitHub Issues** - Bug reports and feature requests
- **GitHub Discussions** - Questions, ideas, and general discussion
- **Pull Requests** - Code/content review and collaboration

### Getting Help

If you need help:

1. Check existing documentation
2. Search GitHub Issues/Discussions
3. Ask in GitHub Discussions
4. Reach out to maintainers

### Response Times

- We aim to respond to issues within 48 hours
- PRs typically reviewed within 1 week
- Be patient - this is maintained by volunteers!

---

## 📝 Contributor License Agreement

By contributing to this project, you agree that:

1. Your contributions will be licensed under the MIT License
2. You have the right to submit the work
3. You grant the project maintainers permission to use your contributions

---

## 🙏 Thank You!

Your contributions make this project better for everyone learning Rust. Whether you're:

- 📝 Writing content
- 🐛 Reporting bugs
- 💡 Suggesting ideas
- 🎨 Improving design
- 🌍 Translating content
- ⭐ Starring the repo
- 📢 Sharing with others

**You're making a difference!** 🎉

---

## 📞 Contact

- **GitHub**: [@Desperado1001](https://github.com/Desperado1001)
- **Repository**: [rust-learning-vault](https://github.com/Desperado1001/rust-learning-vault)
- **Issues**: [Report an issue](https://github.com/Desperado1001/rust-learning-vault/issues)

---

<div align="center">

**Happy Contributing!** 🦀❤️

*"The Rust compiler is your friend, and so are we!"*

</div>