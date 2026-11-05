# ⚙️ Language Tooling: C, C++, Rust, and Assembly

This document explains how language servers, linters, and formatters are configured for each language in this setup.

---

## 1. C and C++ (`clangd`)

### Features
- AST indexing for instant symbol navigation
- Clang-Tidy integration for static analysis and bug prevention
- Header insertion and completion (`#include` suggestions)
- Function parameter placeholders

### Compile Commands (`compile_commands.json`)
For large projects or custom Makefiles, generate a `compile_commands.json` compilation database so `clangd` knows all include paths:

```bash
# CMake projects
cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -B build

# Makefile projects using Bear
bear -- make

# Makefile projects using compiledb
compiledb make
```
Symlink or copy `compile_commands.json` to your project root. `clangd` detects it automatically.

### Formatting
Press **`<leader>fm`** to format your code using `clang-format` according to your project's `.clang-format` rules.

---

## 2. Rust (`rust-analyzer`)

### Features
- **Clippy on Save**: Diagnostics are run via `cargo clippy --all-features`, flagging inefficiencies, unidiomatic patterns, and safety hazards.
- **Procedural Macros**: Macro expansion and attribute evaluation are enabled out of the box.
- **Inlay Hints**: Displays inferred types, parameter names, and closure return types inline.

### Toggling Inlay Hints
When reading dense code or long iterator pipelines, press:
```text
<leader>ih
```
This toggles inline type hints on and off so your buffer stays readable.

### Formatting
Press **`<leader>fm`** to format the buffer using `rustfmt`.

---

## 3. Assembly (`asm-lsp`)

### Features
- Supports **x86**, **x86_64**, **ARM**, **AArch64**, **NASM**, and **GAS** syntax.
- **Opcode Documentation**: Place cursor over any assembly instruction (e.g. `movzx`, `syscall`, `lea`, `test`, `je`) and press **`K`** to display:
  - Instruction description & purpose
  - Operand forms & restrictions
  - Modified CPU status flags (`ZF`, `CF`, `SF`, etc.)
- Register documentation and validation.

### Custom Configuration (`.asm-lsp.toml`)
If you work primarily with a specific target architecture (such as ARM64 or AVR), generate a local configuration in your project root:
```bash
asm-lsp gen-config
```
This generates a `.asm-lsp.toml` file where you can specify your default assembler and instruction set.

---

## 4. Syntax Highlighting (Treesitter)

The following Treesitter parsers are configured for automatic installation:
- **Languages**: `c`, `cpp`, `rust`, `asm`, `bash`, `python`
- **Build systems**: `make`, `cmake`
- **Data & Configs**: `json`, `toml`, `yaml`
- **Documentation**: `markdown`, `markdown_inline`

To install or update parsers manually:
```vim
:TSInstall <language>
:TSUpdate
```
