local function create_keymap()
  vim.api.nvim_create_autocmd("LspAttach", {
    desc = "LSP actions",
    callback = function(event)
      local keys = vim.keymap

      local opts_desc = function(desc)
        local opts = { 
          buffer = event.buf,
          desc = desc
        }

        return opts
      end

      keys.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts_desc("Find definitions"))
      keys.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts_desc("Find declarations"))
      keys.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts_desc("Find implementation"))
      keys.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts_desc("Find type definition"))
      keys.set('n', 'gr', '<cmd>Telescope lsp_references<cr>', opts_desc("Find references"))
      keys.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts_desc("Signature help"))
      keys.set('n', '<leader>lr', '<cmd>lua vim.lsp.buf.rename()<cr>', opts_desc("Rename"))
      keys.set({ 'n', 'x' }, '<leader>lf', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts_desc("Format buffer"))
      keys.set('n', '<leader>la', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts_desc("Code actions"))
      keys.set('n', '<leader>ld', '<cmd>Telescope diagnostics bufnr=0<cr>', opts_desc("Buffer Diagnostics"))
      keys.set('n', '<leader>lD', '<cmd>Telescope diagnostics<cr>', opts_desc("All Diagnostics"))

      keys.set('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>', opts_desc("Open diagnostic at point"))
      keys.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>', opts_desc("Prev diagnostic"))
      keys.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>', opts_desc("Next diagnostic"))
    end
  })
end
return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    dependencies = {
      "mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    opts = {
      diagnostics = {
        underline = true,
        update_in_insert = false,
        virtual_text = {
          spacing = 4,
          source = "if_many",
          prefix = "icons",
        },
        severity_sort = true,
      },
      inlay_hints = {
        enabled = false,
      },

      capabilities = {},

      format = {
        formatting_options = nil,
        timeout_ms = nil,
      },

      servers = {
        lua_ls = {
          settings = {
            Lua = {
              workspace = {
                checkThirdParty = false,
              },
              completion = {
                callSnippet = "Replace",
              },
            }
          }
        }
      },
      setup = {}
    },
    config = function(_, opts)
      local servers = opts.servers
      local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
      local capabilities = vim.tbl_deep_extend(
        "force",
        {},
        vim.lsp.protocol.make_client_capabilities(),
        has_cmp and cmp_nvim_lsp.default_capabilities() or {},
        opts.capabilities or {}
      )

      local function setup(server)
        local server_opts = vim.tbl_deep_extend("force", {
          capabilities = vim.deepcopy(capabilities),
        }, servers[server] or {})

        if opts.setup[server] then
          if opts.setup[server](server, server_opts) then
            return
          end
        elseif opts.setup["*"] then
          if opts.setup["*"](server, server_opts) then
            return
          end
        end
        require("lspconfig")[server].setup(server_opts)
      end

      local have_mason, mlsp = pcall(require, "mason-lspconfig")
      local all_mlsp_servers = {}
      if have_mason then
        all_mlsp_servers = vim.tbl_keys(require("mason-lspconfig.mappings.server").lspconfig_to_package)
      end

      local ensure_installed = {}
      for server, server_opts in pairs(servers) do
        if server_opts then
          server_opts = server_opts == true and {} or server_opts
          if server_opts.mason == false or not vim.tbl_contains(all_mlsp_servers, server) then
            setup(server)
          else
            ensure_installed[#ensure_installed + 1] = server
          end
        end
      end

      if have_mason then
        mlsp.setup({ ensure_installed = ensure_installed, handlers = { setup } })
      end
      create_keymap()
    end
  },
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    build = ":MasonUpdate",
    opts = {
      ensure_installed = {
        "stylua",
        "lua_ls",
        "shfmt",
        "rust_analyzer",
        "intelephense",
      },
    },
    config = function(_, opts)
      require("mason").setup(opts)
      local mr = require("mason-registry")
      mr:on("package:install:success", function()
        vim.defer_fn(function()
          require("lazy.core.handler.event").trigger({
            event = "FileType",
            buf = vim.api.nvim_get_current_buf(),
          })
        end, 100)
      end)
    end
  },
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        "lua_ls",
        "rust_analyzer",
        "intelephense"
      },
      automatic_installation = true,
    },
    config = function(_, opts)
      require("mason-lspconfig").setup(opts)
      require("mason-lspconfig").setup_handlers {
        function(server_name)
          require("lspconfig")[server_name].setup {}
        end
      }
    end
  }
}
