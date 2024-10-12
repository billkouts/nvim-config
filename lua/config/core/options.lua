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
opt.guicursor = {
  "a:block",
  "i-r:block-blinkwait100-blinkon500-blinkoff500",
}

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

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
