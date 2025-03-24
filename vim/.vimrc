" GENERAL SETTING -------------------------------------------------------- {{{

" disable compatability with vi
set nocompatible

" enable type file detection
filetype on

" enable plugins
filetype plugin on

" load indent file for detetced file type
filetype indent on

" turn syntax highlighing on
syntax on

" add line numbers
set number

" set shift widht to 2 spaces
set shiftwidth=2

" set tab width to 2 colums
set tabstop=2

" use space characters instead of tabs
set expandtab

" do not safe backup files
set nobackup

" incremently highligh matching characters when searching
set incsearch

" ignore capital leters during search
set ignorecase

" override ignore case if searching capitel letters
set smartcase

" show current mode
set showmode

" show matching words during search
set showmatch

" use highlight during search
set hlsearch

" set command history
set history=1000

" enable autocompletion menu
set wildmenu

" make wildmenu behave like bash completion
set wildmode=list:longest

" ignore thos filetypes
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx

hi CocFloating ctermbg=DarkGrey  " Floating menu bg color
hi CocMenuSel ctermbg=Blue       " Menu selection bg color
hi CocSearch ctermfg=Cyan        " Text color of the matching text

" }}}


" PLUGINS ---------------------------------------------------------------- {{{

call plug#begin('~/.vim/plugged')

  Plug 'dense-analysis/ale'

  Plug 'preservim/nerdtree'

  Plug 'catppuccin/vim', { 'as': 'catppuccin' }

  Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

" }}}


" MAPPINGS --------------------------------------------------------------- {{{

" insert new line below
nnoremap o o<esc>
nnoremap O O<esc>

nnoremap <c-n> :NERDTreeToggle<cr>

" Have nerdtree ignore certain files and directories.
let NERDTreeIgnore=['\.git$', '\.jpg$', '\.mp4$', '\.ogg$', '\.iso$', '\.pdf$', '\.pyc$', '\.odt$', '\.png$', '\.gif$', '\.db$']

" }}}


" VIMSCRIPT -------------------------------------------------------------- {{{

" This will enable code folding.
" Use the marker method of folding.
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END

" More Vimscripts code goes here.

" }}}


" STATUS LINE ------------------------------------------------------------ {{{

" Status bar code goes here.

" }}}
