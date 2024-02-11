return {
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  {
    "rebelot/kanagawa.nvim",
    name = "kanagawa",
    priority = 1000 ,
    opts = {
      background = {
        dark = "dragon",
        light = "lotus",
      },
      overrides = function(colors)
        local theme = colors.theme
        return {
          -- modern telescope
          TelescopeTitle = { fg = theme.ui.special, bold = true },
          TelescopePromptNormal = { bg = theme.ui.bg_p1 },
          TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
          TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
          TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
          TelescopePreviewNormal = { bg = theme.ui.bg_dim },
          TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },
        }
      end,
    },
    config = function(_, opts)
      require('kanagawa').setup(opts)
      vim.cmd([[colorscheme kanagawa]])
    end
  },
  {
    "phha/zenburn.nvim",
    config = function()
      -- vim.cmd([[colorscheme zenburn]])
    end
  },
  {
    "savq/melange-nvim",
    config = function ()
      -- vim.cmd("colorscheme melange")
    end
  },
  {
    "mcchrish/zenbones.nvim",
    dependencies = {
      "rktjmp/lush.nvim"
    },
  },
  {
    'ramojus/mellifluous.nvim',
    opts = {
      color_set = "alduin",
    },
    config = function (_, opts)
      -- require('mellifluous').setup(opts)
      -- vim.cmd('colorscheme mellifluous')
    end
  }
}
