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
map("n", "<F5>", function()
  require("dap").continue()
end, { desc = "Debug: Start / Continue" })

map("n", "<F10>", function()
  require("dap").step_over()
end, { desc = "Debug: Step Over" })

map("n", "<F11>", function()
  require("dap").step_into()
end, { desc = "Debug: Step Into" })

map("n", "<F12>", function()
  require("dap").step_out()
end, { desc = "Debug: Step Out" })

map("n", "<leader>db", function()
  require("dap").toggle_breakpoint()
end, { desc = "Debug: Toggle Breakpoint" })

map("n", "<leader>dB", function()
  require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, { desc = "Debug: Set Conditional Breakpoint" })

map("n", "<leader>dr", function()
  require("dap").repl.open()
end, { desc = "Debug: Open REPL" })

map("n", "<leader>dl", function()
  require("dap").run_last()
end, { desc = "Debug: Run Last" })

map("n", "<leader>dx", function()
  require("dap").terminate()
  pcall(function()
    require("dapui").close()
  end)
end, { desc = "Debug: Terminate session" })

map("n", "<leader>du", function()
  require("dapui").toggle()
end, { desc = "Debug: Toggle DAP UI" })
