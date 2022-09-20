local M = {}

function M.setup()
	local tabnine = require("cmp_tabnine.config")
	
	local conf = {
		max_lines = 1000,
		max_num_results = 20,
		sort = true,
		run_on_every_keystroke = true,
		snippet_placeholder = "..",
		ignored_file_types = {},
	}
	tabnine.setup(conf)
end

return M
