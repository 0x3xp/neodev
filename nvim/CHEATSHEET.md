# ⚡ Low-Level & Hacker Neovim Cheatsheet

> **Leader Key**: `Space` (`<leader>`)  
> **Open This Cheatsheet Anytime**: `<leader>?` or `<leader>cs`  
> **Built-in NvChad Cheatsheet**: `<leader>ch`  
> **Theme**: `ayu_dark` | **Font**: `JetBrainsMono Nerd Font`

---

## 🧭 1. General & Window Management

| Shortcut | Mode | Description |
|---|---|---|
| `<leader>?` or `<leader>cs` | Normal | Open this cheatsheet |
| `;` | Normal | Fast command mode (`:`) |
| `jk` | Insert | Fast escape to Normal mode |
| `<Esc>` | Normal | Clear search highlights (`:noh`) |
| `<C-s>` | Normal/Insert | Save current file (`:w`) |
| `<C-c>` | Normal | Copy entire file contents to clipboard |
| `<leader>n` | Normal | Toggle line numbers |
| `<leader>rn` | Normal | Toggle relative line numbers |
| `<C-h>` / `<C-j>` / `<C-k>` / `<C-l>` | Normal | Navigate between window splits |
| `<leader>v` | Normal | Open vertical terminal split |
| `<leader>h` | Normal | Open horizontal terminal split |
| `<A-i>` | Normal/Term | Toggle floating scratchpad terminal |
| `<C-x>` | Terminal | Exit terminal mode to normal window controls |

---

## 📁 2. File Explorer & Fuzzy Finding (Telescope)

| Shortcut | Description |
|---|---|
| `<C-n>` | Toggle NvimTree file manager sidebar |
| `<leader>e` | Focus NvimTree window |
| `<leader>ff` | Find files by name in current project |
| `<leader>fa` | Find all files (including hidden & dotfiles) |
| `<leader>fw` | Live grep / search text across whole codebase |
| `<leader>fb` | Find and switch active buffers |
| `<leader>fo` | Find recently opened files (oldfiles) |
| `<leader>fz` | Fuzzy search within the current buffer |
| `<leader>cm` | Git commits browser |
| `<leader>gt` | Git status picker |
| `<leader>th` | Interactive theme switcher (preview themes live) |

---

## 🗂️ 3. Tabs & Buffers (Tabufline)

| Shortcut | Description |
|---|---|
| `<Tab>` | Switch to next open buffer tab |
| `<S-Tab>` | Switch to previous open buffer tab |
| `<leader>b` | Open a brand new empty buffer |
| `<leader>x` | Close current buffer tab |

---

## 🧠 4. LSP & Code Intelligence (Rust, C/C++, Assembly)

Active Language Servers:
- **`rust_analyzer`**: Rust (cargo clippy on save, type inference, macro expansions)
- **`clangd`**: C / C++ (AST indexing, clang-tidy checks, argument placeholders)
- **`asm_lsp`**: Assembly (x86_64, ARM, NASM, GAS instruction docs & registers)

| Shortcut | Description |
|---|---|
| `K` | Hover documentation (types, register info, asm opcode details) |
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `gi` | Go to implementation |
| `gr` | Find all references via Telescope |
| `<leader>D` | Go to type definition |
| `<leader>ca` | Code action (quick fixes, imports, clippy suggestions) |
| `<leader>ra` | NvRenamer (smart identifier rename across project) |
| `<leader>ih` | **Toggle Inlay Hints** (Rust inferred types & param names inline!) |
| `<leader>fm` | Format buffer (`conform.nvim` with lsp fallback / stylua / clang-format) |
| `[d` | Jump to previous diagnostic error / warning |
| `]d` | Jump to next diagnostic error / warning |
| `<leader>lf` | Show diagnostic message for current line in floating window |
| `<leader>ds` | Open diagnostic loclist for buffer |

---

## 🐞 5. Debugger (DAP + GDB)

Equipped with native Linux **GDB** backend:
Works seamlessly on **C**, **C++**, **Rust**, and **Assembly** binaries!

| Shortcut | Description |
|---|---|
| `<F5>` | **Start Debugging / Continue** (prompts for binary path & args) |
| `<F10>` | **Step Over** (execute next line without entering functions) |
| `<F11>` | **Step Into** (enter function call / instruction) |
| `<F12>` | **Step Out** (finish current function and return to caller) |
| `<leader>db` | **Toggle Breakpoint** on current line |
| `<leader>dB` | Set **Conditional Breakpoint** (e.g. `i == 42` or `$rax == 0`) |
| `<leader>du` | **Toggle DAP UI** (Variables, Scopes, Stack Trace, Watches) |
| `<leader>dr` | Open **Debug REPL** / Interactive evaluator |
| `<leader>dl` | Re-run last debugged configuration |
| `<leader>dx` | **Terminate** debugging session & close UI |

---

## 🛡️ 6. Low-Level & Ethical Hacker Utilities

| Shortcut / Command | Description |
|---|---|
| `<leader>hx` | **Toggle Hex Mode (`xxd`)**: Converts buffer to hex dump with offsets and ASCII. Edit hex directly, then press `<leader>hx` again to convert back to raw binary! |
| `<A-i>` | Quick floating terminal for running `checksec`, `objdump`, `readelf`, `gdb`, or `radare2` |
| `:Mason` | Open Mason package manager UI to install or update LSPs, DAPs, and linters |
| `:LspInfo` | Check running LSP clients for the current file |
| `:Lazy` | Open Lazy package manager UI |

---

## 🎨 7. Theme & Appearance

- **Theme**: Ayu Dark (`ayu_dark`) configured in `lua/chadrc.lua`
- **Font**: JetBrainsMono Nerd Font configured in `~/.config/qterminal.org/qterminal.ini` and `lua/options.lua`
- **Switch Themes Instantly**: Press `<leader>th` and choose from over 60+ pre-baked themes!
