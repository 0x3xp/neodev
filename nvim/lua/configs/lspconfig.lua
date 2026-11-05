local nvlsp = require "nvchad.configs.lspconfig"
nvlsp.defaults()

-- Global/Buffer LSP keymaps helper
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
  callback = function(ev)
    local map = vim.keymap.set
    local opts = function(desc)
      return { buffer = ev.buf, desc = "LSP: " .. desc }
    end

    -- Navigation
    map("n", "gd", vim.lsp.buf.definition, opts "Go to definition")
    map("n", "gD", vim.lsp.buf.declaration, opts "Go to declaration")
    map("n", "gi", vim.lsp.buf.implementation, opts "Go to implementation")
    map("n", "gr", "<cmd>Telescope lsp_references<CR>", opts "LSP references")
    map("n", "<leader>D", vim.lsp.buf.type_definition, opts "Type definition")

    -- Information & Actions
    map("n", "K", vim.lsp.buf.hover, opts "Hover documentation")
    map("n", "<leader>ca", vim.lsp.buf.code_action, opts "Code action")
    map("n", "<leader>ra", require("nvchad.lsp.renamer"), opts "Rename symbol")

    -- Diagnostics
    map("n", "[d", vim.diagnostic.goto_prev, opts "Previous diagnostic")
    map("n", "]d", vim.diagnostic.goto_next, opts "Next diagnostic")
    map("n", "<leader>lf", vim.diagnostic.open_float, opts "Show line diagnostic")
    map("n", "<leader>ds", vim.diagnostic.setloclist, opts "Diagnostic list")

    -- Inlay Hints Toggle
    if vim.lsp.inlay_hint then
      map("n", "<leader>ih", function()
        local current = vim.lsp.inlay_hint.is_enabled { bufnr = ev.buf }
        vim.lsp.inlay_hint.enable(not current, { bufnr = ev.buf })
        print("LSP Inlay Hints: " .. (not current and "Enabled" or "Disabled"))
      end, opts "Toggle inlay hints")
    end
  end,
})

-- Clangd configuration for C/C++
vim.lsp.config("clangd", {
  cmd = {
    "clangd",
    "--background-index",
    "--clang-tidy",
    "--header-insertion=iwyu",
    "--completion-style=detailed",
    "--function-arg-placeholders",
    "--fallback-style=llvm",
  },
  init_options = {
    usePlaceholders = true,
    completeUnimported = true,
    clangdFileStatus = true,
  },
})

-- Rust-analyzer configuration
vim.lsp.config("rust_analyzer", {
  settings = {
    ["rust-analyzer"] = {
      cargo = {
        allFeatures = true,
        loadOutDirsFromCheck = true,
        buildScripts = {
          enable = true,
        },
      },
      checkOnSave = true,
      check = {
        command = "clippy",
        features = "all",
      },
      procMacro = {
        enable = true,
      },
      inlayHints = {
        bindingModeHints = { enable = false },
        chainingHints = { enable = true },
        closingBraceHints = { enable = true },
        closureReturnTypeHints = { enable = "always" },
        lifetimeElisionHints = { enable = "always", useParameterNames = true },
        typeHints = { enable = true },
      },
    },
  },
})

-- Assembly LSP configuration (x86, ARM, NASM, GAS)
vim.lsp.config("asm_lsp", {
  cmd = { "asm-lsp" },
  filetypes = { "asm", "s", "S", "nasm" },
})

-- Enable all desired LSP servers
local servers = { "clangd", "rust_analyzer", "asm_lsp", "html", "cssls" }
vim.lsp.enable(servers)
