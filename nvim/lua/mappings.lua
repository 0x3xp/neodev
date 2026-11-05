require "nvchad.mappings"

local map = vim.keymap.set

-- General ergonomics
map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>", { desc = "Escape insert mode" })
map("n", "<Esc>", "<cmd>noh<CR>", { desc = "Clear search highlight" })

-------------------------------------------------------------------------------
-- Cheatsheet Quick Access
-------------------------------------------------------------------------------
map("n", "<leader>?", function()
  vim.cmd("edit " .. vim.fn.stdpath("config") .. "/CHEATSHEET.md")
end, { desc = "Open Neovim cheatsheet" })

map("n", "<leader>cs", function()
  vim.cmd("edit " .. vim.fn.stdpath("config") .. "/CHEATSHEET.md")
end, { desc = "Open Neovim cheatsheet" })

-------------------------------------------------------------------------------
-- Low-Level & Ethical Hacker Tools
-------------------------------------------------------------------------------
-- Toggle Hex dump mode using xxd
local hex_mode = false
map("n", "<leader>hx", function()
  if not hex_mode then
    vim.cmd("%!xxd")
    vim.bo.filetype = "xxd"
    hex_mode = true
    print("Hex mode enabled (xxd)")
  else
    vim.cmd("%!xxd -r")
    vim.cmd("filetype detect")
    hex_mode = false
    print("Hex mode disabled (converted back)")
  end
end, { desc = "Toggle Hex dump mode (xxd)" })

-------------------------------------------------------------------------------
-- Debugger (DAP) Keybindings for C, C++, Rust, ASM
-------------------------------------------------------------------------------
local dap_ok, dap = pcall(require, "dap")
local dapui_ok, dapui = pcall(require, "dapui")

if dap_ok then
  map("n", "<F5>", dap.continue, { desc = "Debug: Start / Continue" })
  map("n", "<F10>", dap.step_over, { desc = "Debug: Step Over" })
  map("n", "<F11>", dap.step_into, { desc = "Debug: Step Into" })
  map("n", "<F12>", dap.step_out, { desc = "Debug: Step Out" })

  map("n", "<leader>db", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
  map("n", "<leader>dB", function()
    dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
  end, { desc = "Debug: Set Conditional Breakpoint" })

  map("n", "<leader>dr", dap.repl.open, { desc = "Debug: Open REPL" })
  map("n", "<leader>dl", dap.run_last, { desc = "Debug: Run Last" })
  map("n", "<leader>dx", function()
    dap.terminate()
    if dapui_ok then
      dapui.close()
    end
  end, { desc = "Debug: Terminate session" })

  if dapui_ok then
    map("n", "<leader>du", dapui.toggle, { desc = "Debug: Toggle DAP UI" })
  end
end
