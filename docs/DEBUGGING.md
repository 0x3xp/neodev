# 🐞 Low-Level Debugging Guide (GDB / GEF + DAP)

This setup integrates the **GNU Debugger (GDB)** directly into Neovim using the native **Debug Adapter Protocol (DAP)**. It eliminates the need to constantly switch between terminal windows to inspect registers, set breakpoints, or step through instructions.

---

## 1. Prerequisites & Compilation

To inspect variables, line numbers, and call stacks, always compile your programs with debug symbols enabled (`-g`).

### C and C++ (GCC / Clang)
```bash
# Debug build without optimizations
gcc -g -O0 -Wall main.c -o app

# Clang with AddressSanitizer (great for exploit & memory bug detection)
clang -g -O0 -fsanitize=address main.c -o app
```

### Rust (Cargo)
By default, `cargo build` produces debug builds with full DWARF symbols located at:
```text
target/debug/<binary_name>
```

### Assembly & Shellcodes (x86_64 NASM)
When assembling raw assembly or shellcodes, you **must** tell NASM to emit DWARF debug symbols so line breakpoints work:
```bash
nasm -f elf64 -g -F dwarf exploit.nasm -o exploit.o
ld -g exploit.o -o exploit
```

---

## 2. Debugging Launch Configurations

When you press **`<F5>`**, you can choose between four dedicated launch modes:

| # | Mode | Best For | Behavior |
|:---:|---|---|---|
| **1** | **Stop at Entry Point (`_start` / `starti`)** | **Assembly, Shellcodes, C** | Executes GDB `starti`. Stops at the **very first machine instruction** (`_start` or entry point). Works even if debug symbols are missing! |
| **2** | **Run to Breakpoint (`run`)** | **Normal Development** | Runs the program immediately until a line breakpoint is hit. |
| **3** | **Stop at Main (`start`)** | **C, C++, Rust** | Stops execution at the beginning of the `main()` function. |
| **4** | **Attach to Process (`attach`)** | **Daemons, Exploits, Services** | Attaches to a running PID. Suspends execution so you can inspect memory. |

---

## 3. Step-by-Step Debugging Workflow

### Step 1: Set a Breakpoint (Optional if using Option 1)
Move your cursor to the desired line and press **`<leader>db`** (a red `●` will appear in the sign column).

### Step 2: Launch Debugger
1. Press **`<F5>`**.
2. Select **`1`** (`Launch & Stop at entry point`).
3. Enter binary path (e.g. `./sh_shell` or `./target/debug/app`).
4. If your program takes arguments, enter them at the prompt (or press `Enter` to skip).

### Step 3: The DAP UI
The UI splits open automatically:
- **Top Left**: Scopes (Local variables, memory addresses, registers)
- **Middle Left**: Breakpoint list
- **Bottom Left**: Call stack frames and Threads
- **Bottom Window**: REPL & Console output

> **Note**: Unlike vanilla DAP configs that disappear immediately when a program exits, NeoDev keeps the UI open on process termination so you can inspect registers, crash dumps, and console output. When ready, press **`<leader>du`** or **`<leader>dx`** to close it.

---

## 4. Execution Controls

| Key | Action | Details |
|:---:|---|---|
| **`<F10>`** | **Step Over** | Executes current line/instruction, moves to next |
| **`<F11>`** | **Step Into** | Steps inside function call / machine instruction |
| **`<F12>`** | **Step Out** | Runs until current function returns to caller |
| **`<F5>`** | **Continue** | Resumes execution until next breakpoint |
| **`<leader>dB`** | **Conditional Breakpoint** | Break only when condition is true (e.g. `$rax == 0` or `i == 100`) |
| **`<leader>dr`** | **Open GDB REPL** | Interactive evaluation prompt |
| **`<leader>du`** | **Toggle DAP UI** | Manually show/hide debugger windows |
| **`<leader>dx`** | **Terminate** | Kills the debugged process and closes DAP UI |

---

## 5. Inline Variable Annotations (`nvim-dap-virtual-text`)

While stepping through code, variable values are printed **inline** right next to your code in dim comments:
```c
int total = calculate_sum(a, b); // total: 42
```
This avoids having to look back and forth between the scopes window and your code lines.

---

## 6. GDB REPL & GEF (GDB Enhanced Features)

Press **`<leader>dr`** to open the interactive GDB REPL window. You can evaluate raw GDB and GEF commands here:

```text
p/x $rax           # Print register RAX in hex
x/10gx $rsp        # Examine 10 quadwords on the stack
checksec           # Run GEF security checks (NX, Canary, PIE, RELRO)
vmmap              # Display process memory mappings
```

For full-screen interactive GEF sessions, press **`<A-i>`** to pop open the floating terminal and launch GDB directly:
```bash
gdb -q ./app
```
Hit **`<A-i>`** again to minimize the shell without closing your session.
