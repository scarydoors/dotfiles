return {
  {
    "j-hui/fidget.nvim",
    event = "VeryLazy",
    opts = {},
  },
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function()
      local lualine_require = require("lualine_require")
      lualine_require.require = require

      vim.o.laststatus = vim.g.lualine_laststatus

      return {
        options = {
          theme = "auto",
          component_separators = { left = '', right = ''},
          section_separators = { left = '', right = ''},
          globalstatus = true,
        }
      }
    end
  },
  {
    "nvim-tree/nvim-web-devicons", lazy = true
  },
  {
    "MunifTanjim/nui.nvim", lazy = true
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {},
  }
}
