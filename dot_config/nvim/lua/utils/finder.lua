local M = {}

function M.find_files()
	local fzf = require "fzf-lua"
	if vim.fn.system "git rev-parse --is-inside-work-tree" == true then
		fzf.git_files()
	else
		fzf.files()
	end
end

function M.find_buffers()
	local results = {}
	local buffers = vim.api.nvim_lst_bufs()

	for _, buffer in ipairs(buffers) do
		if vim.api.nvim_buf_loaded(buffer) then
			local filename = vim.api.nvim_buf_get_name(buffer)
			table.insert(results, filename)
		end
	end

	vim.ui.select(results, { prompt = "Find buffer:" }, function(selected)
		if selected then
			vim.api.nvim("buffer" .. selected)
		end
	end)
end

return M
