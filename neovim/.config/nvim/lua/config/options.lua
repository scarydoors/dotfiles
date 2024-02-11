vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local opt = vim.opt

opt.clipboard = "unnamedplus" -- Sync with system clipboard
opt.completeopt = "menu,menuone,noselect"
opt.conceallevel = 3 -- Hide * markup for bold and itallic
opt.confirm = true -- Confirm to save changes before exiting modified buffer
opt.cursorline = true -- Highlight line that cursor is on
opt.expandtab = true -- Spaces instead of tabs
opt.formatoptions = "jcroqlnt" -- tcqj
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"
opt.smartcase = true --  Don't ignore case with capitals
opt.ignorecase = true -- Use uppercase sensitive search case
opt.inccommand = "nosplit" -- preview incremental substitution
opt.laststatus = 3 -- global statusline
opt.list = true -- show invis chars
opt.mouse = "a" -- enable mouse mode
opt.number = true -- print line number
opt.pumblend = 10 -- popup blend??
opt.pumheight = 10 -- popup entries??
opt.relativenumber = true -- relative line numbers
opt.scrolloff = 4 -- lines of context 
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }
opt.shiftround = true -- indent in multiples of shiftwidth
opt.shiftwidth = 2 -- indent size
opt.sidescrolloff = 8 -- columns of context
opt.signcolumn = "yes" -- Always show the sidecolumn, otherwise it would shift the text each time
opt.smartindent = true -- insert indents automatically
opt.spelllang = { "en" }
opt.splitkeep = "screen" 
opt.tabstop = 2 -- Number of spaces tabs count for
opt.termguicolors = true -- True color
opt.timeoutlen = 300
opt.undofile = true
opt.undolevels = 10000
opt.updatetime = 200 -- Save swap file and trigger CursorHold (?? probably something to do with lazy.nvim)
opt.virtualedit = "block" -- Allow cursor to move where there is no text in visual block mode
opt.wildmode = "longest:full,full" -- Command-line completion mode (?? idk what this means)
opt.winminwidth = 5 -- Minimum window width
opt.wrap = false -- I hate line wrap
opt.fillchars = {
  foldopen = "",
  foldclose = "",
  -- fold = "⸱",
  fold = " ",
  foldsep = " ",
  diff = "╱",
  eob = " ",
}
opt.showmode = false

vim.g.markdown_recommended_style = 0 -- Fix markdown indentation settings

vim.filetype.add({extension = {wgsl = "wgsl"}})

-- NOTE: check out format.lua or conform.nvim
