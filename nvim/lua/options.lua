require "nvchad.options"

-- Prepend Mason bin path so all installed LSPs, DAPs, and formatters are found
local mason_bin = vim.fn.stdpath("data") .. "/mason/bin"
if vim.fn.isdirectory(mason_bin) == 1 then
  vim.env.PATH = mason_bin .. ":" .. vim.env.PATH
end

-- Font configuration (for Neovide or Neovim GUIs)
vim.opt.guifont = "JetBrainsMono Nerd Font:h11,JetBrains Mono:h11"

-- Low-level developer & ethical hacker preferences
local o = vim.opt

o.number = true
o.relativenumber = true         -- Essential for jumping lines quickly in disassembly/C/Rust
o.cursorline = true             -- Highlight current line
o.cursorlineopt = "both"
o.signcolumn = "yes"            -- Keep sign column fixed for breakpoints & LSP diagnostics
o.scrolloff = 8                 -- Keep 8 lines visible above/below cursor
o.sidescrolloff = 8

-- Indentation (Standard 4 spaces for C, C++, Rust, ASM)
o.tabstop = 4
o.shiftwidth = 4
o.softtabstop = 4
o.expandtab = true
o.smartindent = true

-- Search behavior
o.ignorecase = true
o.smartcase = true
o.hlsearch = true
o.incsearch = true

-- Terminal colors & UI
o.termguicolors = true
o.colorcolumn = "100"           -- Guide column for code length
o.wrap = false                  -- Do not wrap long lines (better for hex/asm/tables)

-- Faster update time for diagnostics and git gutter
o.updatetime = 250
o.timeoutlen = 300

-- Split orientation
o.splitbelow = true
o.splitright = true
