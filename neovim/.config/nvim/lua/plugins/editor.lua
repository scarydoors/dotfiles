local telescope_util = require("util.telescope")
return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    keys = {
      {
        "<leader>t",
        "<cmd>Neotree reveal<cr>",
        desc = "Show Neotree"
      }
    }
  },
  -- like which-key from emacs
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      defaults = {
        mode = { "n", "v" },
        ["<leader>b"] = { name = "Buffers" },
        ["<leader>f"] = { name = "Find" },
        ["<leader>l"] = { name = "Lsp" },
        ["<leader>g"] = { name = "Git" },
      }
    },
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)
      wk.register(opts.defaults)
    end
  },
  -- consult but for neovim :D
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    version = false,
    keys = {
      {
        "<leader>bb",
        "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>",
        desc = "Switch Buffer",
      },
      {
        "<leader><leader>",
        telescope_util.telescope("files"),
        desc = "Find Files (auto git)",
      },
      {
        "<leader>ff",
        "<cmd>Telescope find_files no_ignore=true<cr>",
        desc = "Find Files",
      },
      {
        "<leader>fs",
        "<cmd>Telescope live_grep<cr>",
        desc = "Grep",
      },
      {
        "<leader>f/",
        "<cmd>Telescope current_buffer_fuzzy_find<cr>",
        desc = "Fuzzy Search Buffer",
      },
    },
    opts = {
      defaults = {
        prompt_prefix = " ",
        selection_caret = " ",
      }
    }
  },
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make',
    enabled = vim.fn.executable("make") == 1,
    config = function(_, opts)
      require('telescope').load_extension('fzf')
    end
  },
  {
    "echasnovski/mini.bufremove",
    keys = {
      {
        "<leader>bd",
        function()
          local bd = require("mini.bufremove").delete
          if vim.bo.modified then
            local choice = vim.fn.confirm(("Save changes to %q?"):format(vim.fn.bufname()), "&Yes\n&No\n&Cancel")
            if choice == 1 then
              vim.cmd.write()
              bd(0)
            elseif choice == 2 then
              bd(0, true)
            end
          else
            bd(0)
          end
        end,
        desc = "Delete Buffer",
      },
    }
  },
  {
    "folke/todo-comments.nvim",
    cmd = { "TodoTelescope" },
    config = true,
    -- stylua: ignore
    keys = {
      { "]t",         function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
      { "[t",         function() require("todo-comments").jump_next() end, desc = "Previous todo comment" },
      { "<leader>ft", "<cmd>TodoTelescope<cr>",                            desc = "Find TODOs" },
    }
  },
  {
    "L3MON4D3/LuaSnip",
    build = (not jit.os:find("Windows"))
        and "echo 'NOTE: jsregexp is optional, so not a big deal if it fails to build'; make install_jsregexp"
        or nil,
    dependencies = {
      "rafamadriz/friendly-snippets",
      config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
      end,
    },
    opts = {
      history = true,
      delete_check_events = "TextChanged",
    },
    keys = {
      {
        "<tab>",
        function()
          return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>"
        end,
        expr = true,
        silent = true,
        mode = "i",
      },
      { "<tab>",   function() require("luasnip").jump(1) end,  mode = "s" },
      { "<s-tab>", function() require("luasnip").jump(-1) end, mode = { "i", "s" } },
    },
  },
  {
    "hrsh7th/nvim-cmp",
    version = false,
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lsp-signature-help",
    },
    opts = function()
      vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
      local cmp = require("cmp")
      local defaults = require("cmp.config.default")()

      return {
        completion = {
          completeopt = "menu,menuone,noinsert"
        },
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<Down>"] = cmp.mapping.select_next_item({ behaviour = cmp.SelectBehavior.Insert }),
          ["<Up>"] = cmp.mapping.select_prev_item({ behaviour = cmp.SelectBehavior.Insert }),
          ["<A-p>"] = cmp.mapping.scroll_docs(-4),
          ["<A-n>"] = cmp.mapping.scroll_docs(4),
          ["<C-y>"] = cmp.mapping.confirm({ select = true }),
          ["<C-g>"] = cmp.mapping.abort(),
          ["<C-space>"] = cmp.mapping.complete(),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "nvim_lsp_signature_help" },
          { name = "luasnip" },
          { name = "path" },
        }, {
          { name = "buffer" },
        }),
        experimental = {
          ghost_text = {
            hl_group = "CmpGhostText"
          }
        },
        sorting = defaults.sorting
      }
    end,
    config = function(_, opts)
      for _, source in ipairs(opts.sources) do
        source.group_index = source.group_index or 1
      end
      require("cmp").setup(opts)
    end
  },
  {
    "echasnovski/mini.pairs",
    event = "VeryLazy",
    opts = {},
  }
}
