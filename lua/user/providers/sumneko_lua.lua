local status_ok, lua_dev = pcall(require, "lua-dev")
if not status_ok then
  vim.cmd [[ packadd lua-dev.nvim ]]
  lua_dev = require "lua-dev"
end

local luadev = lua_dev.setup {
  library = {
    vimruntime = true, -- runtime path
    types = true, -- full signature, docs and completion of vim.api, vim.treesitter, vim.lsp and others
    plugins = false, -- installed opt or start plugins in packpath
    -- you can also specify the list of plugins to make available as a workspace library
    -- plugins = { "nvim-treesitter", "plenary.nvim", "telescope.nvim" },
  },
  lspconfig = {
    on_attach = require("lsp").common_on_attach,
    on_init = require("lsp").common_on_init,
    capabilities = require("lsp").common_capabilities(),
    settings = {
      Lua = {
        diagnostics = {
          globals = { "vim", "lvim" },
        },
        workspace = {
          library = {
            [require("utils").join_paths(get_runtime_dir(), "lvim", "lua")] = true,
            [vim.fn.expand "$VIMRUNTIME/lua"] = true,
            [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
          },
          maxPreload = 100000,
          preloadFileSize = 10000,
        },
      },
    },
  },
}

return luadev
