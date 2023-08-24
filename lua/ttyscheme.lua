local M = { }

local function f(fg, bg)
	fg = fg or "None"
	bg = bg or "None"
	return { ctermfg = fg, ctermbg = bg }
end

--[[
-- 0 = black
-- 1 = red
-- 2 green
-- 3 = yellow
-- 4 = blue
-- 5 magenta
-- 6 cyan
-- 7 whtie
-- +8 for light variants
--]]
M.groups = {
	-- Cursor highlighting not working in tty
	Normal = f(7, 0),
	Comment = f(8),
	Directory = f(12),
	Visual = f(nil, 4),
	IncSearch = f(nil, 6),
	-- Underline is interpreted as light in tty
	-- highlight background instead
	DiagnosticUnderlineWarn = f(nil, 3),
	DiagnosticUnderlineInfo = f(nil, 7),
	DiagnosticUnderlineHint = f(nil, 6),
	DiagnosticUnderlineError = f(nil, 1),
	-- Overwrite groups that use 256colors instead of 16
	-- :lua for group in pairs(vim.api.nvim_get_hl(0, {})) do local settings = vim.api.nvim_get_hl(0, {name = group}) if (settings.ctermfg~=nil and settings.ctermfg>15) or (settings.ctermbg~=nill and settings.ctermbg>15) then vim.cmd(":highlight "..group) end end
}
M.map256to16fg = {
	["81"] = 14,
	["121"] = 10,
	["224"] = 15,
	["225"] = 15,
	["242"] = 7,
}
-- actually 16
M.map256to16bg = {
	["242"] = 0,
}

-- Make all groups have dark ctermbg (background)
-- this way colorscheme looks the same on both
-- vconsole and normal terminal emulators
function M:dark_ctermbg()
	for group in pairs(vim.api.nvim_get_hl(0, {})) do
		local settings = vim.api.nvim_get_hl(0, {name = group})
		if settings.ctermbg ~= nil and settings.ctermbg >= 8 and settings.ctermbg <= 15 then
			settings.ctermbg = settings.ctermbg - 8
			vim.api.nvim_set_hl(0, group, settings)
		end
	end
end
function M:from256to16()
	for group in pairs(vim.api.nvim_get_hl(0, {})) do
		local settings = vim.api.nvim_get_hl(0, {name = group})
		if settings.ctermfg ~= nil then
			local newfg = self.map256to16fg[settings.ctermfg]
			if settings.ctermfg > 15 and newfg ~= nil then
				settings.ctermfg = newfg
			end
		end
		if settings.ctermbg ~= nil then
			local newbg = self.map256to16bg[settings.ctermbg]
			if settings.ctermbg > 15 and newbg ~= nil then
				settings.ctermbg = newbg
			end
		end
	end
end

function M:colorscheme()
	if vim.fn.exists('syntax_on') then
		vim.api.nvim_command('syntax reset')
	end
	vim.o.background = 'dark'
	vim.o.termguicolors = false
	vim.g.colors_name = 'ttyscheme'
	for group, settings in pairs(M.groups) do
		vim.api.nvim_set_hl(0, group, settings)
	end
	if true or vim.fn.expand("$TERM") ~= "linux" then
		M:dark_ctermbg()
		M:from256to16()
	end
end

M:colorscheme()
return M
