" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdtree'
Plug 'othree/html5.vim'
Plug 'mustache/vim-mustache-handlebars'
Plug 'dustinfarris/vim-htmlbars-inline-syntax'
Plug 'edouardp/myob-colorscheme'
Plug 'Siphalor/vim-atomified'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'terryma/vim-multiple-cursors'
Plug 'ntpeters/vim-better-whitespace'
Plug 'RRethy/vim-illuminate'
Plug 'sbdchd/neoformat'
Plug 'udalov/kotlin-vim'
Plug '~/.fzf'
Plug 'mxw/vim-jsx'
Plug 'tpope/vim-surround'
Plug 'mattn/webapi-vim'
Plug 'mattn/vim-gist'
Plug 'elixir-lsp/coc-elixir', {'do': 'yarn install && yarn prepack'}
call plug#end()

" Fair Vim
noremap <Left> <NOP>
noremap <Right> <NOP>
noremap <Up> <NOP>
noremap <Down> <NOP>

" inoremap <Left> <NOP>
" inoremap <Right> <NOP>
" inoremap <Up> <NOP>
" inoremap <Down> <NOP>

" Looks weird, but it could work
inoremap jj <Esc>

let g:airline_powerline_fonts = 1

" Normal configuration
set termguicolors
set background=dark
colorscheme myob
filetype on                 " Automatically detect file types.
filetype indent on          " vim-ruby plugin for indentation
filetype plugin on          " vim-ruby plugin
syntax enable
set autoindent
set fileformat=unix         " File format UNIX LIKE LF instead of CRLF
set encoding=utf-8          " file encoding
set ruler                   " Ruler on
set relativenumber          " Relative Line numbers on
set nowrap                  " Line wrapping off
set shell=/bin/bash
"set clipboard=unnamedplus     " Yanks level 99+ (take copy from system's clipboard)
set history=1024                " Number of things to remember in history.
set timeoutlen=250              " Time to wait after ESC (default causes an annoying delay)
set novisualbell                " No blinking .
set noerrorbells                " No noise.
set laststatus=2                " Always show status line.
set backspace=indent,eol,start  " delete key
set lcs=tab:\ \ ,eol:$,trail:~,extends:>,precedes:< " Show $ at end of line and trailing space as ~

" Searching Highlight with * or # (clean with space)
set hlsearch
set incsearch
set ignorecase    " searches are case insensitive...
set smartcase     " ... unless they contain at least one capital letter
:nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o " Don't add the comment prefix when I hit enter or o/O on a comment line.
au! FileType mkd setlocal syn=off                                              " Don't syntax highlight markdown because it's often wrong.
au! BufRead,BufNewFile *.markdown set filetype=mkd
au! BufRead,BufNewFile *.md       set filetype=mkd

" Searching Highlight with * or # (clean with space)
set hlsearch
set incsearch
set ignorecase    " searches are case insensitive...
set smartcase     " ... unless they contain at least one capital letter
:nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o " Don't add the comment prefix when I hit enter or o/O on a comment line.
au! FileType mkd setlocal syn=off                                              " Don't syntax highlight markdown because it's often wrong.
au! BufRead,BufNewFile *.markdown set filetype=mkd
au! BufRead,BufNewFile *.md       set filetype=mkd

" Remove trailing whitespace on save
au BufWritePre *.rb :%s/\s\+$//e
au BufWritePre *.java :%s/\s\+$//e
au BufWritePre *.php :%s/\s\+$//e
au BufWritePre *.css :%s/\s\+$//e
au BufWritePre *.js :%s/\s\+$//e

" Auto completion menu with matches list
set wildmenu "enable ctrl-n and ctrl-p to scroll thru matches
set wildmode=list:longest
set wildignore=*.o,*.obj,*~ "stuff to ignore when tab completing
set wildignore+=*vim/backups*
set wildignore+=*sass-cache*
set wildignore+=*DS_Store*
set wildignore+=vendor/rails/**
set wildignore+=vendor/cache/**
set wildignore+=*.gem
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=*app/cache/**
set wildignore+=*.png,*.jpg,*.gif
set wildignore+=*.so,*.swp,*.zip
set wildignore+=*.git/**,.svn/**,*.git,*.svn

" Scrolling settings
set scrolloff=8 "Start scrolling when we're 8 lines away from margins
set sidescrolloff=15
set sidescroll=1

" Formatting
autocmd Filetype ruby setlocal ts=2 sts=2 sw=2
autocmd Filetype php setlocal ts=4 sts=4 sw=4
autocmd Filetype javascript setlocal ts=2 sts=2 sw=2
set tabstop=2
set shiftwidth=2
set expandtab
set cinoptions=i2,+2,+p2
set cinwords=if,else,while,do,for,switch,case,class,def
set cindent
set autoindent
set smarttab

" Navigation
set showmatch   " Show matching brackets. (navigate always with %)
set mat=5       " Bracket blinking.

" Confgurations from old vimrc
set nu
set runtimepath^=~/.vim/bundle/ctrlp.vim

if &term =~ '256color'
    " disable Background Color Erase (BCE) so that color schemes
    " render properly when inside 256-color tmux and GNU screen.
    " see also http://snk.tuxfamily.org/log/vim-256color-bce.html
    set t_ut=
endif

" Plugin configs
" javascript:
" - highlight inline handlebars
" - run neoformat on save
autocmd BufRead,BufNewFile *.js HighlightInlineHbs
autocmd BufWritePre *.js Neoformat
