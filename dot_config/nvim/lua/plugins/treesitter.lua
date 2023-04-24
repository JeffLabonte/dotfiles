function get_next_previous_swap()
  local swap_objects = {
    p = "@parameter.inner",
    f = "@function.outer",
    c = "@class.outer",
  }
  local next_swap_commands = {}
  local previous_swap_command = {}
  for vim_key, section in pairs(swap_objects) do
    next_swap_commands[string.format("<leader>cx%s", vim_key)] = section
    previous_swap_command[string.format("<leader>cx%s", vim_key)] = section
  end

  return next_swap_commands, previous_swap_command
end

return {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
    build = "TSUpdate",
    event = "BufReadPost",
    config = function()
      local swap_next, swap_previous = get_next_previous_swap()

      require("nvim-treesitter.configs").setup(
        {
          ensure_installed = {
            "bash",
            "help",
            "html",
            "javascript",
            "json",
            "lua",
            "markdown",
            "rust",
            "yaml",
            "python",
          },
          highlight = {
            enable = true,
          },
          indent = {
            enable = true,
            disable = {
              "python",
            },
          },
          incremental_selection = {
            enable = true,
            keymaps = {
              init_selection = "gnn",
              node_incremental = "grn",
              scope_incremental = "grc",
              node_decremental = "grm",
            },
          },
          textobjects = {
            select = {
              enable = true,
              lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
              keymaps = {
                -- You can use the capture groups defined in textobjects.scm
                ["aa"] = "@parameter.outer",
                ["ia"] = "@parameter.inner",
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner",
              },
            },
            move = {
              enable = true,
              set_jumps = true, -- whether to set jumps in the jumplist
              goto_next_start = {
                ["]m"] = "@function.outer",
                ["]]"] = "@class.outer",
              },
              goto_next_end = {
                ["]M"] = "@function.outer",
                ["]["] = "@class.outer",
              },
              goto_previous_start = {
                ["[m"] = "@function.outer",
                ["[["] = "@class.outer",
              },
              goto_previous_end = {
                ["[M"] = "@function.outer",
                ["[]"] = "@class.outer",
              },
            },
            swap = {
              enable = true,
              swap_next = swap_next,
              swap_previous = swap_previous,
            },
          }
        }
      )
    end
  }
}
