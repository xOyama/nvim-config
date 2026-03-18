require "nvchad.autocmds"

-- Showkeys autostart
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    require("showkeys").toggle()
  end,
})

-- Enable autoread
vim.opt.autoread = true

-- Auto refresh buffers when file changes on disk
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "WinEnter", "BufEnter", "CursorHold", "CursorHoldI" }, {
  pattern = "*",
  command = "checktime"
})

