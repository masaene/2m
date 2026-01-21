local M = {}

function M.hello()
  print("Hello from Lua!")
end

function M.open_floating_build_and_run()
	local width = math.ceil(vim.o.columns * 0.8)
	local height = math.ceil(vim.o.lines * 0.6)
	local col = math.ceil((vim.o.columns - width) / 2)
	local row = math.ceil((vim.o.lines - height) / 2)

	local buf = vim.api.nvim_create_buf(false, true)

	local opts = {
		relative = 'editor',
		width = width,
		height = height,
		col = col,
		row = row,
		style = 'minimal',
		border = 'rounded'
	}

	local win = vim.api.nvim_open_win(buf, true, opts)

	vim.fn.termopen('cargo run')
	vim.cmd('startinsert')
end



function M.get_status_mode_color()
	local mode = vim.api.nvim_get_mode().mode
	local format_str = ''
	if mode == 'n' then
		mode_str = '%#StatusLineNormal# |Normal| %*'
	elseif mode == 'i' then
		mode_str = '%#StatusLineInsert# |Insert| %*'
	else
		mode_str = '%#StatusLineCommand# |Command| %*'
	end
	format_str = format_str .. mode_str

	format_str = format_str .. ' %f :'

	local errors = vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
	local warns = vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
	format_str = format_str .. ' W=' .. #warns .. ',E=' .. #errors

	format_str = format_str .. ' [%l/%L]%*'

	return format_str
end

function M.surround_with_c(c)
	local current = vim.fn.col('.')
	local eol = vim.fn.col('$')

	if c == '(' then
		c2 = ')'
	elseif c == '[' then
		c2 = ']'
	elseif c == '{' then
		c2 = '}'
	else
		c2 = c
	end

	local ret_cmd = ''
	if current == (eol-1) then
 		ret_cmd = '"zdawa' .. c .. '<Esc>"zpa' .. c2 .. '<Esc>'
	else
 		ret_cmd = '"zdawi' .. c .. '<Esc>"zpa' .. c2 .. '<Esc>'
	end
	local term_keys = vim.api.nvim_replace_termcodes(ret_cmd, true, false, true)
	vim.api.nvim_feedkeys(term_keys, 'n', false)
	return 
end

return M
