local f = {
}
function f(fg, bg, isguicolor)
	if isguicolor == nil then
		return { ctermfg = fg, ctermbg = bg }
	end
end

local groups = {
	Normal = f("White", "None")
	Comment = f("DarkGrey", "None")
	Visual = f(nil, "DarkBlue")
	FFirst = f(nil, "Green")
	FSecond = f("DarkGreen", "Green")
	ErrorMsg = f("Red", nil)
	--ErrorMsg                    = { fg = f.errorred },
	--MoreMsg                     = { fg = f.fairygreen },
	Function = f("DarkCyan", nil)
	--Statement                   = { fg = f.strongpink, bold = true},
	--Type                        = { fg = f.purplelight },
	--Keyword                     = { fg = f.purpledark },
	--Delimiter                   = { fg = f.purple },
	--Operator                    = { fg = f.normalplus },
	--VertSplit                   = { bg = f.none },
	--StatusLine                  = { bold = true },
	--StatusLineNC                = { },
	--Search                      = f.search,
	Search = f(nil, "DarkYellow")
	IncSearch = f(nil, "DarkCyan")
	--LineNr                      = { fg = f.gothpink },
	--CursorLineNr                = { fg = f.goldcontrast, bold = true },
	--SignColumn                  = { bg = f.none },
	--NormalFloat                 = { fg = f.normal, bg = f.none },
	--LspDiagnosticsDefaultError  = { fg = '#ec5f67' },
	--LspDiagnosticsDefaultWarning= { fg = '#fabd2f' },
	--LspDiagnosticsDefaultHint   = { fg = '#51afef' },
	--LspDiagnosticsDefaultInforma= { fg = '#51afef' },
}

function f.colorscheme()
	if vim.fn.exists('syntax_on') then
		vim.api.nvim_command('syntax reset')
	end
	vim.o.background = 'dark'
	vim.o.termguicolors = true
	vim.g.colors_name = 'ttyscheme'
	for group, settings in pairs(groups) do
		vim.api.nvim_set_hl(0, group, settings)
	end
end
f.colorscheme()

return f
