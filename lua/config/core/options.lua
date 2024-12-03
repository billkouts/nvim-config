vim.g.have_nerd_font = true
local opt = vim.opt

opt.number = true
opt.relativenumber = true

opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true

opt.cursorline = true

opt.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

opt.scrolloff = 999

opt.wrap = true
opt.breakindent = true
opt.breakindentopt = "shift:4"
opt.linebreak = true
opt.showbreak = "↪ "

opt.termguicolors = true

opt.mouse = ""

vim.opt.splitright = true
vim.opt.splitbelow = true

-- disable builtin file explorer
-- i have an autocommand to load neo-tree instead
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
