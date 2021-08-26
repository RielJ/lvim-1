-- Neovim
-- =========================================
lvim.format_on_save = false
lvim.leader = " "
lvim.colorscheme = "pablo"
lvim.debug = false
-- lvim.log.level = "debug"
vim.opt.relativenumber = true
vim.opt.wrap = true
vim.opt.timeoutlen = 200
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevel = 5
vim.opt.guifont = "FiraCode Nerd Font:h13"
vim.opt.cmdheight = 1
vim.g.dashboard_enable_session = 0
vim.g.dashboard_disable_statusline = 0
vim.opt.pumblend = 10 -- Popup blend
vim.opt.joinspaces = false -- No double spaces with join after a dot
vim.opt.list = true -- Show some invisible characters (tabs...

-- Customization
-- =========================================
lvim.builtin.lastplace = { active = false } -- change to false if you are jumping to future
lvim.builtin.tabnine = { active = true } -- change to false if you don't like tabnine
lvim.builtin.persistence = { active = true } -- change to false if you don't want persistence
lvim.builtin.presence = { active = false } -- change to true if you want discord presence
lvim.builtin.neorg = { active = true } -- change to true if you want neorg
lvim.builtin.dap.active = false -- change this to enable/disable debugging
lvim.builtin.lir = { active = true } -- change this to enable/disable lir
require("user.builtin").config()

-- StatusLine
-- =========================================

if lvim.builtin.dap.active then
  require("user.dap").config()
end

-- Language Specific
-- =========================================
lvim.lang.markdown = {}
lvim.lang.dockerfile = { formatters = {} }
lvim.builtin.lspinstall.on_config_done = function()
  require("user.tailwind").setup()
  require("user.dockerls").setup()
end
lvim.lsp.diagnostics.virtual_text = false
lvim.lsp.override = { "rust", "java" }
require("user.json_schemas").setup()

-- Additional Plugins
-- =========================================
require("user.plugins").config()

-- Autocommands
-- =========================================
require("user.autocommands").config()

-- Additional keybindings
-- =========================================
require("user.keybindings").config()
