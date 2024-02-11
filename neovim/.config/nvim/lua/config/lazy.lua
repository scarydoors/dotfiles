local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  -- bootstrap lazy.nvim
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

require("lazy").setup({
  spec = {
	  {import = "plugins"},
  },
  defaults = {
    lazy = false,
    version = "*",
  }
})

local keys = vim.keymap

keys.set('n', '<leader>w', '<cmd>w<cr>', {desc = "Write file"})

local function toggleLineNumber()
  vim.o.relativenumber = not vim.o.relativenumber
end

keys.set('n', '<leader>r', toggleLineNumber, {desc = "Toggle relative numbers"})
