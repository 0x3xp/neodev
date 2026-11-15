require "nvchad.autocmds"

-- Provide :LspInfo alias globally to :checkhealth vim.lsp
vim.api.nvim_create_user_command("LspInfo", "checkhealth vim.lsp", { desc = "Check LSP status and active clients" })
