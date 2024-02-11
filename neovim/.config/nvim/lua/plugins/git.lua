return {
  {
    'NeogitOrg/neogit',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
      'sindrets/diffview.nvim',
    },
    opts = {},
    event = "VeryLazy",
    keys = {
      { "<leader>gg", "<cmd>Neogit kind=vsplit cwd=%:p:h<CR>", desc = "Neogit" }
    }
  },
  {
    'tpope/vim-fugitive',
  },
  {
    'lewis6991/gitsigns.nvim',
    opts = {},
  }
}
