return {
  {
    "neovim/nvim-lspconfig",
    event = "BufReadPre",
    dependencies = {
      "folke/neoconf.nvim",
      { "folke/neodev.nvim",       config = true },
      { "j-hui/fidget.nvim",       config = true },
      { "smjonas/inc-rename.nvim", config = true },
      "simrat39/rust-tools.nvim",
      "rust-lang/rust.vim",
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lsp-signature-help",
    },
    config = function(plugins)
      require("plugins.lsp.config").setup(plugins)
    end
  },
  {
    "folke/neoconf.nvim",
    cmd = "Neoconf",
    config = function()
      require("folke/neoconf.nvim").setup({
        import = {
          vscode = true,
        },
      })
    end,
  },
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
    ensure_installed = {
      "stylua",
      "autopep8",
      "ruff",
      "black",
      "rust-analyzer",
      "json-lsp",
    },
    config = function(plugin)
      require("mason").setup()
      local mason_registry = require("mason-registry")

      for _, tool in ipairs(plugin.ensure_installed) do
        local _package = mason_registry.get_package(tool)
        if not _package:is_installed() then
          _package:install()
        end
      end
    end
  }
}
