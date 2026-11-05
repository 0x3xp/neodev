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

### Assembly (x86_64 NASM)
When assembling, tell NASM to emit DWARF debug symbols:
```bash
nasm -f elf64 -g -F dwarf exploit.asm -o exploit.o
ld -g -no-pie exploit.o -o exploit
```

---

## 2. Debugging Workflows

### Workflow A: Launching a Binary
1. Open your source code file (`.c`, `.rs`, or `.asm`).
2. Move your cursor to the desired line and press **`<leader>db`** to place a breakpoint (a red `●` will appear in the sign column).
3. Press **`<F5>`**.
4. A prompt will appear at the bottom:
   ```text
   Path to executable: /path/to/project/app
   ```
5. If your program expects command line arguments, enter them at the `Arguments:` prompt, or press `Enter` to skip.
6. The **DAP UI** will split open automatically:
   - **Top Left**: Local, Global, and Register scopes
   - **Middle Left**: Breakpoint list
   - **Bottom Left**: Call stack frames and Threads
   - **Bottom Window**: REPL & Console output
7. The active execution pointer will highlight with a green arrow `▶`.

### Workflow B: Stepping & Instruction Control
- **`<F10>`**: **Step Over** – Executes the current line/call and stops at the next line.
- **`<F11>`**: **Step Into** – Steps inside the function or instruction being executed.
- **`<F12>`**: **Step Out** – Runs until the current function returns to its caller.
- **`<F5>`**: **Continue** – Resumes execution until the next breakpoint or termination.
- **`<leader>dx`**: **Terminate** – Kills the debugged process and closes the DAP UI windows.

### Workflow C: Conditional Breakpoints
To break only when a specific variable hits a threshold or a register matches an offset:
1. Position cursor on the target line.
2. Press **`<leader>dB`**.
3. Enter your condition expression:
   - C/Rust: `i == 100` or `ptr == 0x0`
   - Assembly / Registers: `$rax == 0` or `$rdi != 0`
4. A yellow `◆` icon marks the conditional breakpoint.

### Workflow D: Attaching to an Active Process (PID)
Useful for debugging network daemons, forked processes, or analyzing malware:
1. Select the **"Attach to process (GDB)"** configuration when prompted.
2. Enter the executable name or the PID directly (e.g. `1337`).
3. GDB will attach to the process and suspend execution so you can inspect memory and set breakpoints.

---

## 3. Inline Variable Annotations (`nvim-dap-virtual-text`)

While stepping through code, variable values are printed **inline** right next to your code in dim comments:
```c
int total = calculate_sum(a, b); // total: 42
```
This avoids having to look back and forth between the scopes window and your code lines.

---

## 4. GDB REPL & GEF (GDB Enhanced Features)

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
