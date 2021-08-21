call plug#begin('~/.vim/plugged')

" Autocomplete & Linting
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'dense-analysis/ale'
Plug 'dylon/vim-antlr'

" Theme
Plug 'vim-airline/vim-airline'
Plug 'tomasr/molokai'
Plug 'flazz/vim-colorschemes'

" Misc
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
" Plug 'jiangmiao/auto-pairs'

" Latex
Plug 'lervag/vimtex'

" Python
Plug 'Vimjas/vim-python-pep8-indent'

" Haskell
Plug 'neovimhaskell/haskell-vim'


call plug#end()

" Appearance
let g:airline_powerline_fonts=1
colorscheme gruvbox
highlight lineNr ctermfg=blue


highlight colorcolumn ctermbg=8 guibg=lightgrey

" Line Numbers
set number
set relativenumber

" Indentation
set autoindent
set smartindent

set tabstop=4
set shiftwidth=4
set expandtab

filetype indent on

" Folding
set foldmethod=syntax
set foldenable
set foldnestmax=1

" Misc
set scrolloff=5
set undofile
set wildmenu
set timeoutlen=500
set mouse=a

" Search
set ignorecase smartcase incsearch hlsearch
nnoremap <silent> <Esc><Esc> <Esc>:nohlsearch<CR><Esc>

" Coc stuff
set updatetime=300
set signcolumn=yes
set cmdheight=2

" Ctrl+c/v
vnoremap <C-c> "+y
inoremap <C-v> <esc>"+pa

" Clipboard yanks
vnoremap  <leader>y  "+y
nnoremap  <leader>Y  "+yg_
nnoremap  <leader>y  "+y
nnoremap  <leader>yy  "+yy

vnoremap  <leader>d  "+d
nnoremap  <leader>D  "+Dg_
nnoremap  <leader>d  "+d
nnoremap  <leader>dd  "+dd

nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P

map Y y$

" Custom shortcuts
autocmd FileType python nnoremap <buffer> <localleader>c :!python3 %<CR>
autocmd FileType tex nnoremap <buffer> <localleader>c :VimtexCompile<CR>
autocmd FileType c nnoremap <buffer> <localleader>c :!gcc %<CR>:!./a.out<CR>
autocmd FileType c setlocal colorcolumn=81<CR>
autocmd FileType cpp nnoremap <buffer> <localleader>c :!g++ %<CR>:!./a.out<CR>
autocmd FileType markdown nnoremap <buffer> <localleader>c :!pandoc % --pdf-engine=xelatex -o output.pdf<CR> :!evince output.pdf &<CR>

nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" Vimtex
let g:tex_flavor='latex'
let g:vimtex_compiler_latexmk = {
    \ 'options' : [
    \   '-pdf',
    \   '-shell-escape',
    \   '-verbose',
    \   '-file-line-error',
    \   '-synctex=1',
    \   '-interaction=nonstopmode',
    \ ],
    \}

" ALE
let g:ale_linters = {
            \ 'c': ['clangd'],
            \ 'tex': ['lacheck'],
            \}
" COC.NVIM
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

inoremap <silent><expr> <C-Space>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)
