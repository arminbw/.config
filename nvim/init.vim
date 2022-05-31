" syntax on

set noerrorbells
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set smartcase
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set cursorline

set nocompatible
filetype off

" use the MacOS clipboard
" faster startup, see: https://github.com/neovim/neovim/issues/8631
let g:clipboard = {'copy': {'+': 'pbcopy', '*': 'pbcopy'}, 'paste': {'+': 'pbpaste', '*': 'pbpaste'}, 'name': 'pbcopy', 'cache_enabled': 0}
set clipboard+=unnamedplus

" plugins
call plug#begin('~/.config/nvim/plugged')
Plug 'morhetz/gruvbox'
" Plug 'tpope/vim-fugitive'
Plug 'preservim/nerdtree'
" Plug 'ctrlpvim/ctrlp.vim'
Plug 'jkramer/vim-checkbox'
call plug#end()

colorscheme gruvbox
set background=dark

" Use 24-bit (true-color) mode
if (has("termguicolors"))
    set termguicolors
endif

" extra shortcuts
" set leader key to <space>
map <Space> <Leader>

" Move between vim screens (and back and forth to NERDTree)
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" move up down one paragraph
nnoremap } {
nnoremap { }

" Navigating buffers
nnoremap <Tab>      :bnext<CR>:redraw<CR>:ls<CR>
nnoremap <S-Tab>    :bprevious<CR>
nnoremap <leader>b  :ls<CR>:b
# close current buffer without messing up the layout
# (move to previous buffer, then delete the buffer we just moved away from)
nmap <silent> <leader>q :bp\|bd #<CR>


" NERDTree config
" map <silent> <C-n> :NERDTreeFocus<CR>
map <C-n> :NERDTreeToggle<CR>
map <leader>f :NERDTreeFind<CR>
let NERDTreeShowHidden=1
let NERDTreeMinimalUI=1
let NERDTreeIgnore=['\.DS_Store']

" Start NERDTree. If a file is specified, move the cursor to its window.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * NERDTree | if argc() > 0 || exists("s:std_in") | wincmd p | endif

" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
    \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif

" when directory is changed via :cd, change the Nerdtree root directory
augroup DIRCHANGE
    au!
    autocmd DirChanged global :NERDTreeCWD
augroup END

