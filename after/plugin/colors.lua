function SetColors (color) 
	color = color or 'tokyonight'
	vim.cmd.colorscheme(color)
end

SetColors()
