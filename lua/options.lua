require "nvchad.options"

-- add yours here!

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!

vim.opt.relativenumber = true

-- Folding options
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldenable = false -- Don't fold by default when opening files
vim.opt.foldlevel = 99     -- High value most folds open by default
--vim.opt.foldcolumn = "1" -- Shows a small column next to line numbers
