local dap = require("dap")
local dapui = require("dapui")

-- Setup DAP UI
dapui.setup({
  icons = { expanded = "▾", collapsed = "▸", current_frame = "▸" },
  mappings = {
    expand = { "<CR>", "<2-LeftMouse>" },
    open = "o",
    remove = "d",
    edit = "e",
    repl = "r",
    toggle = "t",
  },
  layouts = {
    {
      elements = {
        { id = "scopes", size = 0.35 },
        { id = "breakpoints", size = 0.20 },
        { id = "stacks", size = 0.25 },
        { id = "watches", size = 0.20 },
      },
      size = 40,
      position = "left",
    },
    {
      elements = {
        { id = "repl", size = 0.60 },
        { id = "console", size = 0.40 },
      },
      size = 10,
      position = "bottom",
    },
  },
  floating = {
    max_height = nil,
    max_width = nil,
    border = "single",
    mappings = {
      close = { "q", "<Esc>" },
    },
  },
})

-- Open DAP UI automatically when session initializes
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end

-- Inform user on exit without abruptly destroying the UI layout
dap.listeners.after.event_terminated["dapui_config"] = function()
  vim.notify("Debugging finished. Press <leader>du or <leader>dx to close UI.", vim.log.levels.INFO)
end

dap.listeners.after.event_exited["dapui_config"] = function(_, body)
  local code = (body and body.exitCode) or 0
  vim.notify(string.format("Process exited with code %s. Press <leader>du to toggle UI.", code), vim.log.levels.INFO)
end

-- Configure GDB as the Debug Adapter (native to Linux / Kali)
dap.adapters.gdb = {
  type = "executable",
  command = "gdb",
  args = { "-q", "-i", "dap" },
}

-- Prompt helpers
local function get_program()
  local p = vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
  if p == nil or p == "" then
    return nil
  end
  return vim.fn.expand(p)
end

local function get_args()
  local args_str = vim.fn.input("Arguments: ")
  if args_str == nil or args_str:match("^%s*$") then
    return {}
  end
  return vim.split(args_str, "%s+")
end

-- Configurations for C, C++, Rust, and Assembly
local gdb_configurations = {
  {
    name = "Launch & Stop at entry point (_start / starti)",
    type = "gdb",
    request = "launch",
    program = get_program,
    args = get_args,
    cwd = "${workspaceFolder}",
    stopOnEntry = true, -- Runs starti; stops at the very first instruction (perfect for ASM, shellcode, and C)
  },
  {
    name = "Launch & Run to breakpoint (GDB run)",
    type = "gdb",
    request = "launch",
    program = get_program,
    args = get_args,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
  },
  {
    name = "Launch & Stop at main (GDB start)",
    type = "gdb",
    request = "launch",
    program = get_program,
    args = get_args,
    cwd = "${workspaceFolder}",
    stopAtBeginningOfMainSubprogram = true,
  },
  {
    name = "Attach to process (GDB attach)",
    type = "gdb",
    request = "attach",
    pid = function()
      local name = vim.fn.input("Executable name (or PID directly): ")
      local pid = tonumber(name)
      if pid then
        return pid
      end
      local pids = vim.fn.systemlist("pidof " .. name)
      if #pids > 0 then
        return tonumber(pids[1])
      end
      return tonumber(vim.fn.input("PID: "))
    end,
    cwd = "${workspaceFolder}",
  },
}

dap.configurations.c = gdb_configurations
dap.configurations.cpp = gdb_configurations
dap.configurations.rust = gdb_configurations
dap.configurations.asm = gdb_configurations
dap.configurations.nasm = gdb_configurations

-- Breakpoint icons & visual styling
vim.api.nvim_set_hl(0, "DapBreakpoint", { fg = "#F07178" })
vim.api.nvim_set_hl(0, "DapBreakpointCondition", { fg = "#E7C547" })
vim.api.nvim_set_hl(0, "DapLogPoint", { fg = "#36A3D9" })
vim.api.nvim_set_hl(0, "DapStopped", { fg = "#AAD84C", bold = true })

vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = "" })
vim.fn.sign_define("DapBreakpointCondition", { text = "◆", texthl = "DapBreakpointCondition", linehl = "", numhl = "" })
vim.fn.sign_define("DapLogPoint", { text = "◆", texthl = "DapLogPoint", linehl = "", numhl = "" })
vim.fn.sign_define("DapStopped", { text = "▶", texthl = "DapStopped", linehl = "CursorLine", numhl = "DapStopped" })
