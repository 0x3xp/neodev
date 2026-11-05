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

-- Automatically open/close DAP UI when debugging starts/ends
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

-- Configure GDB as the Debug Adapter (native to Linux / Kali)
dap.adapters.gdb = {
  type = "executable",
  command = "gdb",
  args = { "-i", "dap" },
}

-- Configurations for C, C++, Rust, and Assembly
local gdb_configurations = {
  {
    name = "Launch binary (GDB)",
    type = "gdb",
    request = "launch",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    end,
    args = function()
      local args_string = vim.fn.input("Arguments: ")
      return vim.split(args_string, " +")
    end,
    cwd = "${workspaceFolder}",
    stopAtBeginningOfMainSubprogram = false,
  },
  {
    name = "Launch binary & Stop at main (GDB)",
    type = "gdb",
    request = "launch",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    end,
    cwd = "${workspaceFolder}",
    stopAtBeginningOfMainSubprogram = true,
  },
  {
    name = "Attach to process (GDB)",
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

-- Breakpoint icons & visual styling
vim.api.nvim_set_hl(0, "DapBreakpoint", { fg = "#F07178" })
vim.api.nvim_set_hl(0, "DapBreakpointCondition", { fg = "#E7C547" })
vim.api.nvim_set_hl(0, "DapLogPoint", { fg = "#36A3D9" })
vim.api.nvim_set_hl(0, "DapStopped", { fg = "#AAD84C", bold = true })

vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = "" })
vim.fn.sign_define("DapBreakpointCondition", { text = "◆", texthl = "DapBreakpointCondition", linehl = "", numhl = "" })
vim.fn.sign_define("DapLogPoint", { text = "◆", texthl = "DapLogPoint", linehl = "", numhl = "" })
vim.fn.sign_define("DapStopped", { text = "▶", texthl = "DapStopped", linehl = "CursorLine", numhl = "DapStopped" })
