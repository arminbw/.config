set noerrorbells
set tabstop=2 softtabstop=2
set shiftwidth=2
set expandtab
set smartindent
set ignorecase
set smartcase
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set cursorline
set scrolloff=8

set nocompatible
filetype off

" use the MacOS clipboard
set clipboard+=unnamedplus

" plugins
call plug#begin('~/.config/nvim/plugged')
Plug 'morhetz/gruvbox'
" Plug 'tpope/vim-fugitive'
Plug 'preservim/nerdtree'
Plug '/opt/homebrew/opt/fzf' " use the homebrew install
" for Intel Chip based MacOS use this path instead: Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim' " extra fzf-based commands and mappings
Plug 'jkramer/vim-checkbox'
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install --frozen-lockfile --production',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'markdown', 'html'] }
Plug 'IstiCusi/kicknvim'
Plug 'PhilRunninger/nerdtree-buffer-ops'
" Plug 'github/copilot.vim'
call plug#end()

colorscheme gruvbox
set background=dark

" Use 24-bit (true-color) mode
if (has("termguicolors"))
    set termguicolors
endif

" press ESC to clear search result highlighting
nnoremap <esc> :noh<return><esc>
" press ENTER to save (and exit visual mode)
noremap <CR> :w<CR>
vnoremap <CR> <ESC>:w<CR>

" extra shortcuts
" set leader key to <space>
map <Space> <Leader>

" indent selected text using tab and shift-tab
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv

" Move between vim screens (and back and forth to NERDTree)
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" move up down one paragraph (with GermanDev Keyboard Layout)
nnoremap } {
nnoremap { }

" Navigating buffers
nnoremap <Tab>      :bnext<CR>:redraw<CR>:ls<CR>
nnoremap <S-Tab>    :bprevious<CR>
nnoremap <leader>b  :ls<CR>:b
" close current buffer without messing up the layout
" (move to previous buffer, then delete the buffer we just moved away from)
nmap <silent> <leader>q :bp\|bd #<CR>


" FZF config
" Prevent FZF commands from opening in none modifiable buffers
" https://github.com/junegunn/fzf/issues/453#issuecomment-700943343
function! FZFOpen(cmd)
    " If more than 1 window, and buffer is not modifiable or file type is
    " NERD tree
    if winnr('$') > 1 && (!&modifiable || &ft == 'nerdtree')
        " Move one window to the right, then up
        wincmd l
    endif
    exe a:cmd
endfunction

" Search for files using fzf
nnoremap <silent> <C-f> :call FZFOpen(":Files")<CR>
" use rg nstead of grep inside vim
set grepprg=rg\ --vimgrep\ --smart-case\ --follow
" Search inside files using fzf and rg
nnoremap <C-g> :call FZFOpen(":Rg")<CR>
" ignore filenames when searching within files
command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, {'options': '--delimiter : --nth 4..'}, <bang>0)


" NERDTree config
" map <silent> <C-n> :NERDTreeFocus<CR>
map <C-n> :NERDTreeToggle<CR>
" map <leader>f :NERDTreeFind<CR>
let NERDTreeShowHidden=1
let NERDTreeMinimalUI=1
let NERDTreeIgnore=['\.DS_Store']

" Start NERDTree. If a file is specified, move the cursor to its window.
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * NERDTree | if argc() > 0 || exists("s:std_in") | wincmd p | endif

" If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
" https://github.com/preservim/nerdtree
autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
    \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif

" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" when directory is changed via :cd, change the Nerdtree root directory
augroup DIRCHANGE
    au!
    autocmd DirChanged global :NERDTreeCWD
augroup END

" Find current file on NERDTree
noremap <silent> <leader>nf :NERDTreeFind<CR>


" Check if NERDTree is open
function! IsNERDTreeOpen()
  return !empty(filter(range(1, winnr('$')),
        \ 'getbufvar(winbufnr(v:val), "&filetype") ==# "nerdtree"'))
endfunction

" Call NERDTreeFind if NERDTree is active, current buffer contains a
" modifiable file, and we're not in vimdiff and return to focus to previous
" window
function! SyncTree()
  if &modifiable && IsNERDTreeOpen() && strlen(expand('%')) > 0 && !&diff
    :NERDTreeFind
    wincmd p
  endif
endfunction

autocmd BufEnter * call SyncTree()

" Mappings for Github Copilot (deactivated)
" imap <silent><script><expr> <C-l> copilot#Accept("\<CR>")
" imap <silent><script><expr> <C-h> copilot#Dismiss()
" imap <silent><script><expr> <C-k> copilot#Next()
" imap <silent><script><expr> <C-j> copilot#Previous()
" let g:copilot_no_tab_map = v:true

" Kicknvim config (kickassembly)
au BufRead,BufNewFile *.asm set filetype=kickass
lua require("kicknvim_config")
nnoremap <leader>ka :KickAssemble<CR>
nnoremap <leader>kr :KickRun<CR>
nnoremap <leader>km :KickMan<CR>
nnoremap <leader>kl :KickLibs<CR>
