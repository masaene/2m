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
vim.opt.laststatus = 3

--vim.api.nvim_set_hl(0, 'CurSearch', {fg='#000000', bg='#70eeff'})
--vim.api.nvim_set_hl(0, 'Search', {fg='#000000', bg='#408a98'})
vim.api.nvim_set_hl(0, 'CurSearch', {fg='#000000', bg='#00ff7f'})
vim.api.nvim_set_hl(0, 'Search', {fg='#000000', bg='#2e8b57'})



-- g:mapleader
-- vim.g.mapleade
--vim.keymap.set('n', '<Leader>[', 'bi[<Esc>ea]<Esc>')
vim.keymap.set('n', '<Leader>[', function() surround_with_c('[') end)
vim.keymap.set('n', '<Leader>{', function() surround_with_c('{') end)
vim.keymap.set('n', '<Leader>(', function() surround_with_c('(') end)
vim.keymap.set('n', '<Leader>\'', function() surround_with_c('\'') end)
vim.keymap.set('n', '<Leader>"', function() surround_with_c('"') end)


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


vim.cmd('colorscheme unokai')

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


vim.lsp.config('pyright', {
  cmd = { "pyright-langserver", "--stdio" },
  filetypes = { "python" },
  -- root_markersを空にするか、現在のディレクトリを常にルートにする
  root_markers = { ".git"},
})

vim.lsp.enable('pyright')

vim.diagnostic.config({
	virtual_text = true,
	signs = true,
})


--vim.cmd('highlight lspWarningHighLight guifg=red guibg=green')
--vim.cmd('highlight LspWarningVirtualText guifg=white guibg=blue')
--vim.cmd('highlight LspErrorVirtualText guifg=white guibg=red')
