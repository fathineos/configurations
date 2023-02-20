-- <leader><Ctrl-b>     Toggle File Navigator
-- <leader><Ctrl-f>     Open File Navigator on current file
-- <leader><Ctrl-q>     Open Tag Bar Navigator on current file
-- <leader><Ctrl-Space> Toggle Comment
-- <leader>gD           Go to declaration
-- <leader>gd           Go to definition
-- <leader>K            hover
-- <leader>gr           Show references
-- <leader>gi           Show implementation
-- <leader><Ctrl-k>     Signature help (???)
-- <leader>gl           Show line diagnostics (deprecated)

local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

-- Better window navigation
-- keymap("n", "<C-h>", "<C-w>h", opts)
vim.cmd "nnoremap <C-h> <C-w>h"
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
keymap("n", "<C-t>", ":tabnew<CR>", opts)

-- fzf wrapper
keymap("n", "<leader><C-p>", ":Files<CR>", opts)
keymap("n", "<leader><C-b>", ":Buffers<CR>", opts)
keymap("n", "<leader><C-h>", ":History<CR>", opts)
keymap("n", "<leader><C-t>", ":NERDTreeToggle<CR>", opts)
keymap("n", "<leader><C-f>", ":NERDTreeFind<CR>", opts)

-- tagbar
keymap("n", "<leader><C-q>", ":TagbarToggle<CR>", opts)

-- Folding
vim.cmd "nnoremap <space> za"
vim.cmd "vnoremap <space> zf"

-- LSP
keymap("n", "<leader><C-d>", ":lua vim.lsp.buf.definition()<CR>", opts)
keymap("n", "K", ":lua vim.lsp.buf.hover()<CR>", opts)
