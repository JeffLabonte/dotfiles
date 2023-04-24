function create_dashboard()
  local dashboard = require("alpha.themes.dashboard")
  dashboard.section.header.val = require("plugins.dashboard.logo")["random"]
  dashboard.section.buttons.val = {
    dashboard.button("f", " " .. " Find file", ":Telescope find_files <CR>"),
    dashboard.button("n", " " .. " New file", ":ene <BAR> startinsert <CR>"),
    dashboard.button("r", " " .. " Recent files", ":Telescope oldfiles <CR>"),
    dashboard.button("g", " " .. " Find text", ":Telescope live_grep <CR>"),
    dashboard.button("c", " " .. " Config", ":e $MYVIMRC <CR>"),
    dashboard.button("l", "鈴" .. " Lazy", ":Lazy<CR>"),
    dashboard.button("q", " " .. " Quit", ":qa<CR>"),
  }
  for _, button in ipairs(dashboard.section.buttons.val) do
    button.opts.hl = "AlphaButtons"
    button.opts.hl_shortcut = "AlphaShortcut"
  end

  dashboard.section.footer.opts.hl = "Constant"
  dashboard.section.header.opts.hl = "AlphaHeader"
  dashboard.section.buttons.opts.hl = "AlphaButtons"
  dashboard.opts.layout[1].val = 0

  return dashboard
end

function show_on_start(dashboard_opts)
  if vim.o.filetype == "lazy" then
    -- close and re-open lazy after showing alpha
    vim.notify("Missing plugins installed", vim.log.levels.INFO, { title = "lazy.nvim" })
    vim.cmd.close()
    require("lazy").show()
  end

  require("alpha").setup(dashboard_opts)
end

function generate_footer()
  local neovim_version = "   v" .. vim.version().major .. "." .. vim.version().minor .. "." .. vim.version().patch
  local quote = table.concat(require("alpha.fortune")(), "\n")

  local lazy_stats = require("lazy").stats()
  local startup_time_in_ms = (math.floor(lazy_stats.startuptime * 100 + 0.5) / 100)
  local plugins_stats = "⚡Neovim loaded " .. lazy_stats.count .. " plugins in " .. startup_time_in_ms .. "ms"

  return "\t" .. neovim_version .. "\t" .. plugins_stats .. "\n" .. quote
end

return {
  "goolord/alpha-nvim",
  lazy = false,
  config = function()
    local dashboard = create_dashboard()
    show_on_start(dashboard.opts)

    vim.api.nvim_create_autocmd("User", {
      pattern = "LazyVimStarted",
      callback = function()
        dashboard.section.footer.val = generate_footer()
        pcall(vim.cmd.AlphaRedraw)
      end,
    })
  end,
}
