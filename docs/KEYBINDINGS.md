# ⌨️ Keybindings & Modal Navigation Reference

> **Leader Key**: `Space` (`<leader>`)  
> **Open Cheatsheet In-Editor**: `<leader>?` or `<leader>cs`

---

## 1. General & Navigation

| Key | Mode | Description |
|---|:---:|---|
| `<leader>?` | Normal | Open the in-editor markdown cheatsheet |
| `<leader>cs` | Normal | Open the in-editor markdown cheatsheet |
| `;` | Normal | Fast command mode (replaces `:`) |
| `jk` | Insert | Fast escape to Normal mode |
| `<Esc>` | Normal | Clear active search highlights (`:noh`) |
| `<C-s>` | Normal/Insert | Save current file (`:w`) |
| `<C-c>` | Normal | Copy entire file contents to system clipboard |
| `<leader>n` | Normal | Toggle line numbers |
| `<leader>rn` | Normal | Toggle relative line numbers |
| `<C-h>` | Normal | Move cursor to window on the left |
| `<C-l>` | Normal | Move cursor to window on the right |
| `<C-j>` | Normal | Move cursor to window below |
| `<C-k>` | Normal | Move cursor to window above |

---

## 2. File Explorer & Telescope

| Key | Action |
|---|---|
| `<C-n>` | Toggle **NvimTree** file explorer sidebar |
| `<leader>e` | Focus cursor inside NvimTree window |
| `<leader>ff` | **Find Files**: Search files by name |
| `<leader>fa` | Find all files (including hidden and dotfiles) |
| `<leader>fw` | **Live Grep**: Search text across all files in workspace |
| `<leader>fb` | List and jump between open buffers |
| `<leader>fo` | List recently opened files (`oldfiles`) |
| `<leader>fz` | Fuzzy search text inside current active buffer |
| `<leader>cm` | View git commit history |
| `<leader>gt` | View git status file picker |
| `<leader>th` | Interactive theme picker (preview 60+ themes live) |

---

## 3. Buffer Tabs (Tabufline)

| Key | Action |
|---|---|
| `<Tab>` | Jump to next open buffer tab |
| `<S-Tab>` | Jump to previous open buffer tab |
| `<leader>b` | Open a brand new empty buffer |
| `<leader>x` | Close current active buffer tab |

---

## 4. LSP & Code Intelligence (Rust, C/C++, ASM)

| Key | Action | Details |
|---|---|---|
| `K` | **Hover Documentation** | Displays type info, parameter docstrings, or **CPU opcode manuals & registers** |
| `gd` | **Go to Definition** | Jump to where symbol is defined |
| `gD` | **Go to Declaration** | Jump to header declaration |
| `gi` | **Go to Implementation** | Jump to trait / interface implementation |
| `gr` | **References** | Opens Telescope with all workspace references |
| `<leader>D` | **Type Definition** | Jump to type definition |
| `<leader>ca` | **Code Actions** | Quick fixes, imports, clippy refactorings |
| `<leader>ra` | **Rename Symbol** | Renames symbol everywhere across workspace |
| `<leader>ih` | **Toggle Inlay Hints** | Toggle Rust inferred types & parameter names inline |
| `<leader>fm` | **Format Buffer** | Format code using `conform.nvim` (`clang-format`, `rustfmt`) |
| `[d` | Previous Diagnostic | Jump to previous compiler warning/error |
| `]d` | Next Diagnostic | Jump to next compiler warning/error |
| `<leader>lf` | Floating Diagnostic | Inspect compiler error in a popup window |
| `<leader>ds` | Diagnostic Loclist | Populate buffer diagnostics into location list |

---

## 5. Low-Level Debugger (DAP + GDB)

| Key | Action | Description |
|:---:|---|---|
| `<F5>` | **Start / Continue** | Prompts for binary path & arguments; runs or continues execution |
| `<F10>` | **Step Over** | Executes next instruction or line without entering function calls |
| `<F11>` | **Step Into** | Steps inside function call or machine instruction |
| `<F12>` | **Step Out** | Finishes current function and returns to caller |
| `<leader>db` | **Toggle Breakpoint** | Adds or removes a red `●` breakpoint on current line |
| `<leader>dB` | **Conditional Breakpoint** | Prompts for condition expression (e.g. `i == 100` or `$rax == 0`) |
| `<leader>du` | **Toggle DAP UI** | Shows/hides Scopes, Breakpoints, Call Stack, and Watches |
| `<leader>dr` | **Debug REPL** | Opens interactive GDB evaluation prompt |
| `<leader>dl` | **Run Last** | Re-runs the last executed debug session |
| `<leader>dx` | **Terminate Session** | Stops the debugger process and closes the debug UI |

---

## 6. Hacker & Terminal Tools

| Key | Action | Description |
|---|---|---|
| `<leader>hx` | **Toggle Hex Mode** | Runs `%!xxd` to convert buffer to a hex dump with byte offsets. Edit bytes in hex, then press `<leader>hx` again to convert back to raw binary (`%!xxd -r`)! |
| `<A-i>` | **Floating Scratchpad** | Toggles a floating terminal over your code for fast CLI commands (`checksec`, `objdump`, `readelf`, `r2`). |
| `<A-h>` | **Bottom Terminal** | Toggles a horizontal terminal drawer at the bottom. |
| `<A-v>` | **Vertical Terminal** | Toggles a vertical terminal drawer on the right. |
| `<leader>h` | **New Split (Horizontal)** | Creates a persistent horizontal terminal split. |
| `<leader>v` | **New Split (Vertical)** | Creates a persistent vertical terminal split. |
| `<C-x>` | **Exit Terminal Mode** | Switches back from terminal input to window navigation mode. |
| `<leader>/` | **Toggle Comment** | Toggles comment on current line or visual selection (`gcc` / `gc`). |
