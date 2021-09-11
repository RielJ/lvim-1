local M = {}

M.config = function()
  vim.g.vimtex_compiler_method = "latexmk"
  vim.g.vimtex_view_method = "skim"
  vim.g.vimtex_fold_enabled = 0
  vim.g.vimtex_quickfix_ignore_filters = {}
  vim.cmd [[
        augroup vimtex_event_1
            au!
            au User VimtexEventQuit     call vimtex#compiler#clean(0)
            au User VimtexEventInitPost call vimtex#compiler#compile()
        augroup END
    ]]
  local tex_preview_settings = {}
  local forward_search_executable = "/Applications/Skim.app/Contents/SharedSupport/displayline"

  local sumatrapdf_args = { "-reuse-instance", "%p", "-forward-search", "%f", "%l" }
  local evince_args = { "-f", "%l", "%p", '"code -g %f:%l"' }
  local okular_args = { "--unique", "file:%p#src:%l%f" }
  local zathura_args = { "--synctex-forward", "%l:1:%f", "%p" }
  local qpdfview_args = { "--unique", "%p#src:%f:%l:1" }
  local skim_args = { "%l", "%p", "%f" }

  if forward_search_executable == "C:/Users/{User}/AppData/Local/SumatraPDF/SumatraPDF.exe" then
    tex_preview_settings = sumatrapdf_args
  elseif forward_search_executable == "evince-synctex" then
    tex_preview_settings = evince_args
  elseif forward_search_executable == "okular" then
    tex_preview_settings = okular_args
  elseif forward_search_executable == "zathura" then
    tex_preview_settings = zathura_args
  elseif forward_search_executable == "qpdfview" then
    tex_preview_settings = qpdfview_args
  elseif forward_search_executable == "/Applications/Skim.app/Contents/SharedSupport/displayline" then
    tex_preview_settings = skim_args
  end
  return {
    cmd = { vim.fn.stdpath "data" .. "/lspinstall/latex/texlab" },
    filetypes = { "tex", "bib" },
    settings = {
      texlab = {
        auxDirectory = nil,
        bibtexFormatter = "texlab",
        build = {
          executable = "latexmk",
          args = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "%f" },
          on_save = false,
          forward_search_after = false,
        },
        chktex = {
          on_open_and_save = false,
          on_edit = false,
        },
        forward_search = {
          executable = nil,
          args = {},
        },
        latexindent = {
          ["local"] = nil,
          modify_line_breaks = false,
        },
        linters = { "chktex" },
        auto_save = false,
        ignore_errors = {},
        diagnosticsDelay = 300,
        formatterLineLength = 120,
        forwardSearch = {
          args = tex_preview_settings,
          executable = forward_search_executable,
        },
        latexFormatter = "latexindent",
      },
    },
  }
end

return M
