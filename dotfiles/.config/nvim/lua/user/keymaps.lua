-- <leader><Ctrl-t>  Open new tab
-- <leader><Ctrl-b>  Toggle File Navigator

local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Nvimtree
keymap("n", "<leader><C-b>", ":NvimTreeToggle<cr>", opts)

keymap("n", "<leader><C-t>", ":tabnew<CR>", opts)

-- fzf wrapper
keymap("n", "<leader><C-p>", ":Files<CR>", opts)
keymap("n", "<leader><C-b>", ":NERDTreeToggle<CR>", opts)
keymap("n", "<leader><C-f>", ":NERDTreeFind<CR>", opts)
keymap("n", "<C-c>", "\"+y", opts)
