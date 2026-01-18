vim.api.nvim_set_hl(0, 'StatusLineNormal', {fg='#ffffff', bg='#000000', bold=true})
vim.api.nvim_set_hl(0, 'StatusLineInsert', {fg='#ffffff', bg='#4169e1', bold=true})
vim.api.nvim_set_hl(0, 'StatusLineCommand', {fg='#000000', bg='#00ff7f', bold=true})
vim.api.nvim_set_hl(0, 'StatusLineNone', {fg='#000000', bg='#ffffff'})

vim.api.nvim_set_hl(0, 'CurSearch', {fg='#000000', bg='#00ff7f'})
vim.api.nvim_set_hl(0, 'Search', {fg='#000000', bg='#2e8b57'})

vim.api.nvim_set_hl(0, 'VirtualTextSearchStats', {fg='#ffd700', bg='none', underline=true})


-- g:mapleader
-- vim.g.mapleade
--vim.keymap.set('n', '<Leader>[', 'bi[<Esc>ea]<Esc>')
vim.keymap.set('n', '<Leader>[', function() surround_with_c('[') end)
vim.keymap.set('n', '<Leader>{', function() surround_with_c('{') end)
vim.keymap.set('n', '<Leader>(', function() surround_with_c('(') end)
vim.keymap.set('n', '<Leader>\'', function() surround_with_c('\'') end)
vim.keymap.set('n', '<Leader>"', function() surround_with_c('"') end)


local plug = require('2m')
vim.api.nvim_create_user_command('HelloLua', function()
  plug.hello()
end, {})

_G.get_status_mode_color = function()
	return plug.get_status_mode_color()
end

_G.surround_with_c = function(c)
	return plug.surround_with_c(c)
end

local status_format = "%!v:lua.get_status_mode_color()"
vim.opt.statusline = status_format
--
vim.opt.laststatus = 2






vim.keymap.set('i', '<Tab>', function()
	if vim.fn.pumvisible() == 1 then
		return '<C-n>'
	end

	local col = vim.fn.col('.') - 1
	if col == 0 or vim.fn.getline('.'):sub(col,col):match('%s') then
		return '<Tab>'
	end

	return '<C-x><C-o>'
end, {expr = true})

vim.keymap.set('i', '<CR>', function()
	if vim.fn.pumvisible() == 1 then
		return '<C-y>'
	end
	return '<CR>'
end, {expr = true})

local ns_id = vim.api.nvim_create_namespace('2m_ns')
vim.api.nvim_create_autocmd('CursorMoved', {
	callback = function()
		local buf = vim.api.nvim_get_current_buf()
		local row = vim.fn.line('.') - 1
		vim.api.nvim_buf_clear_namespace(buf, ns_id, 0, -1)
		if vim.v.hlsearch == 1 then
			local reg = vim.fn.getreg('/')
			local current_line_str = vim.fn.getline('.')
			local match_ret = vim.fn.match(current_line_str, reg)
			if match_ret ~= -1 then
				local search_result = vim.fn.searchcount({recompute=1})
				local virtual_str = '[' .. search_result.current .. '/' .. search_result.total .. ']'
				vim.api.nvim_buf_set_extmark(buf,ns_id,row,0, {
					virt_text = {{virtual_str,'VirtualTextSearchStats'}},
					virt_text_pos = "eol",
				})
			end
		end
	end,
})




--vim.call('plug#begin')
--Plug('masaene/mmm')
--Plug('prabirshrestha/vim-lsp')
--Plug('mattn/vim-lsp-settings')
--Plug('neovim/nvim-lspconfig')
--Plug('vim-scripts/ScrollColors')
--vim.call('plug#end')

--vim.g.lsp_document_highlight_enabled = 1
--vim.g.lsp_semantic_enabled = 1
--vim.g.lsp_log_file = ''
--vim.g.lsp_log_verbose = 1

--vim.lsp.enable('pyright')

--vim.cmd('highlight lspWarningHighLight guifg=red guibg=green')
--vim.cmd('highlight LspWarningVirtualText guifg=white guibg=blue')
--vim.cmd('highlight LspErrorVirtualText guifg=white guibg=red')
