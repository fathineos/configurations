"######################################################################
" CUSTOM SHORTCUTS
"######################################################################

" <c-Space>         Toggle comment
" <Ctrl-c>          Copy in clipboard
" leader key is "\"
" <leader><Ctrl-t>  Open new tab
" <leader><Space>   Toggle folding
" <leader><Ctrl-b>  Toggle nerdtree
" <leader><Ctrl-f>  Find current open file on nerdtree
" <leader><Ctrl-q>  Toggle tagbar
" <leader><Ctrl-p>  Find files with fzf
" <leader>d         Add python debugger

"######################################################################
" VUNDLE PACKAGES
"######################################################################

scriptencoding utf-8
set encoding=utf-8

" Plug automatic installation
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" package manager installation
Plug 'VundleVim/Vundle.vim'

" syntax for a collection of languages
Plug 'sheerun/vim-polyglot'

" Multi-editor config
Plug 'editorconfig/editorconfig-vim'

" File Navigation
Plug 'scrooloose/nerdtree'

" Class outliner viewer
Plug 'majutsushi/tagbar'

" Asynchronous linting and make framework
Plug 'neomake/neomake'

" Git integration
Plug 'airblade/vim-gitgutter'

" Autocomplete
if has('nvim')
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

" Search fzf wrapper
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Tmux integration
" Navigate between tmux panes and vim splits seamlessly
Plug 'christoomey/vim-tmux-navigator'

" FocusGained and FocusLost autocommand events while in tmux. To
" autoreload externally modified files
Plug 'tmux-plugins/vim-tmux-focus-events'

" Comment lines for all languages
Plug 'scrooloose/nerdcommenter'

" Text aligning
Plug 'godlygeek/tabular'

" Automatic table creator/editor
Plug 'dhruvasagar/vim-table-mode'

" Prefer local repo install of eslint over global install with neomake
"Plug 'benjie/neomake-local-eslint.vim'

" Better folding for python
Plug 'tmhedberg/SimpylFold'

" Helper to open github
Plug 'ruanyl/vim-gh-line'

" Colors/syntax
Plug 'morhetz/gruvbox'
"Plug 'rakr/vim-one'
Plug 'arcticicestudio/nord-vim'

" Customize start screen
Plug 'mhinz/vim-startify'

" Fancy icons
Plug 'ryanoasis/vim-devicons'

call plug#end()


"######################################################################
" PLUGIN CONFIGURATION
"######################################################################

" tagbar
nmap <leader><C-q> :TagbarToggle<CR>

" nerdtree
map <leader><C-b> :NERDTreeToggle<CR>
map <leader><C-f> :NERDTreeFind<CR>

" markdown
let g:vim_markdown_folding_level = 4

" startify
let g:startify_change_to_dir = 0
let g:startify_custom_header = []

" neomake
call neomake#configure#automake('w')
let g:neomake_open_list = 3
let g:neomake_python_enabled_makers = ['python', 'flake8']
let g:neomake_javascript_enabled_makers = ['eslint']

" deoplete
if has('nvim')
  let g:deoplete#enable_at_startup = 1
  call deoplete#custom#option('ignore_sources', {'_': ['buffer']})
endif
" navigate suggestions with Tab
inoremap <expr> <C-i> pumvisible() ? "\<C-n>" : "\<C-i>"

" fzf wrapper
map <leader><C-p> :Files<CR>

" Use Ag for search
" let g:ackprg = 'ag --nogroup --nocolor --column'
let g:fzf_tags_command = 'ctags -R'
let g:ackprg = 'ag --vimgrep'

" nerdtree as netrw, not project drawer
let NERDTreeHijackNetrw=1
" Ignore files
let NERDTreeIgnore=['\.pyc$','\~$','\.git$','\.svn$','.tags','DS_Store','\.swp$']
let NERDTreeShowHidden=1

" vim-airline
set laststatus=2
" use patched fonts
let g:airline_powerline_fonts=0

" vim-gitgutter
set updatetime=250

" simplyfold
let g:SimpylFold_docstring_preview=1

"set t_Co=256
" colorscheme
set termguicolors

let g:gruvbox_contrast_light='hard'
let g:gruvbox_contrast_dark='hard'

":silent! colorscheme gruvbox
":silent! colorscheme one
let g:nord_italic_comments = 1
:silent! colorscheme nord
set background=dark

"######################################################################
" KEYMAPS
"######################################################################

" toggle folding
nnoremap <space> za
vnoremap <space> zf

" visual copy/cut to os clipboard
if has("unix")
  vnoremap <C-c> "+y
  let s:uname = system("uname -s")
  if s:uname == "Darwin"
    vmap <C-c> :!pbcopy<CR>
  endif
endif

map <leader><C-t> :tabnew<CR>

" insert debugger depending on file format
let g:debugger_map = {
      \ 'javascript' : 'debugger',
      \ 'python' : '__import__("pdb").set_trace()',
      \}

function! InsertDebugger()
  if has_key(g:debugger_map, &filetype)
    let text = get(g:debugger_map, &filetype)
    call feedkeys('o', 'i')
    call feedkeys(text)
    call feedkeys("\<Esc>")
  else
    echo 'No mapping defined for filetype: ' . &filetype
  endif
endfunction
map <leader>d :call InsertDebugger()<cr>

"######################################################################
" FORMATTING
"######################################################################

" Turn on file syntax
syntax on

" Turn on relative line numbering
set relativenumber
" absolute current line number
set number

" Number of screen lines to keep above/below cursor
set scrolloff=5

" Enable mouse support
set mouse=a

" highlight lines over 80 characters
" highlight OverLength ctermbg=red ctermfg=white guibg=#592929
" match OverLength /\%81v.\+/

" backspace behavior to also delete
set backspace=2

" Visual change on 80/120 chars
" set colorcolumn=80,100
let &colorcolumn="72,80,120".join(range(120,122),",")

" Highligh trailing space
":highlight ws ctermbg=red guibg=red
":match ws /\s\+$/

" Highlighting line or number follows....
set cul " highlight current line

" Higlhight search
set hls

set foldmethod=indent

" Javascript
autocmd FileType javascript set shiftwidth=2
autocmd FileType javascript set softtabstop=2
autocmd FileType javascript set tabstop=2
autocmd FileType javascript set expandtab

" HTML
autocmd FileType html set shiftwidth=2
autocmd FileType html set softtabstop=2
autocmd FileType html set tabstop=2

"######################################################################
" VIM/NVIM SETTINGS
"######################################################################

if !has('nvim')
  set viminfo+=n~/.vim/viminfo
else
  set viminfo+=n~/.shada
endif

" ctags
set tags=./.tags;

" set list listchars=tab:\|\
" highlight Whitespace cterm=underline gui=underline ctermbg=NONE guibg=NONE ctermfg=yellow guifg=yellow
" autocmd ColorScheme * highlight Whitespace gui=underline ctermbg=NONE guibg=NONE ctermfg=yellow guifg=yellow
" match Whitespace /  \+/

set list
set listchars=""                      " reset
set listchars=tab:→\ 
set listchars+=trail:·

" System local settings
silent! so $HOME/.vim/.vimrc_local

" Apply project specific settings (Loads ./.vimrc_local file)
" http://vim.wikia.com/wiki/Project_specific_settings
silent! so .vimrc_local

" When a file has changed outside of vim, it will be reloaded
set autoread
"au CursorHold,CursorHoldI * checktime
au FocusGained,BufEnter * :checktime

" Open files where we left off
if has("autocmd")
    au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
        \| exe "normal! g'\"" | endif
endif

" Save your backups to a less annoying place than the current directory.
" If you have .vim-backup in the current directory, it'll use that.
" Otherwise it saves it to ~/.vim/backup or . if all else fails.
" http://stackoverflow.com/questions/4331776/change-vim-swap-backup-undo-file-name
if isdirectory($HOME . '/.vim/backup') == 0
    :silent !mkdir -p ~/.vim/backup >/dev/null 2>&1
endif
set backupdir-=.
set backupdir+=.
set backupdir-=~/
set backupdir^=~/.vim/backup/
set backup

" Save your swp files to a less annoying place than the current directory.
" If you have .vim-swap in the current directory, it'll use that.
" Otherwise it saves it to ~/.vim/swap, ~/tmp or .
if isdirectory($HOME . '/.vim/swap') == 0
    :silent !mkdir -p ~/.vim/swap >/dev/null 2>&1
endif
set directory=./.vim-swap//
set directory+=~/.vim/swap//
set directory+=~/tmp//
set directory+=.

" viminfo stores the the state of your previous editing session
set viminfo+=n~/.vim/viminfo

" undofile - This allows you to use undos after exiting and restarting
" This, like swap and backups, uses .vim-undo first, then ~/.vim/undo
" :help undo-persistence
" This is only present in 7.3+
if exists("+undofile")
  if isdirectory($HOME . '/.vim/undo') == 0
    :silent !mkdir -p ~/.vim/undo > /dev/null 2>&1
  endif
  set undodir=./.vim-undo//
  set undodir+=~/.vim/undo//
  set undofile
endif

" Disable Background Color Erase (BCE) so that color schemes
" render properly when inside 256-color tmux and GNU screen.
" see also http://snk.tuxfamily.org/log/vim-256color-bce.html
if &term =~ '256color'
    set t_ut=
endif
