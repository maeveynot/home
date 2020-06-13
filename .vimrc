set textwidth=78
set tabstop=8
set expandtab
set smarttab
set autoindent
set backspace=indent,eol,start
set shiftwidth=4
set cinoptions=(s+s
set nojoinspaces

set ignorecase
set smartcase

set history=50
set more

set noshowmode
set hlsearch
set showmatch
set matchtime=5
set shortmess=finxotTIO
set laststatus=2
set background=dark

set pastetoggle=<F10>
set wildchar=<Tab>

set hidden

let g:bufferline_echo=0

if $TERM == "vt100"
  set noruler
  set list listchars=tab:-\ ,trail:_,extends:>,precedes:<
else
  set ruler ttyfast errorbells report=1 showcmd
  set list listchars=tab:-\ ,trail:_,extends:>,precedes:<
endif

if has("eval")
  let MRU_File = expand("~/.vim/mru_files")
  nmap <leader>r :MRU<CR>
end

if has("syntax")
  syn on
  let g:is_posix = 1
endif

if has("folding")
  set foldlevel=999
endif

if has("title")
  set title titlelen=256
  let &titlestring="vim@" . hostname() . ": %f %y"
endif

if has("cindent")
  let xdefaults_no_if0 = 1
  let c_syntax_for_h = 1
  let c_space_errors = 1
  let c_gnu = 1
  let perl_want_scope_in_variables = 1
  let perl_include_POD = 1
  let perl_extended_vars = 1
endif

highlight NonText ctermfg=7
highlight Search ctermbg=15
highlight MatchParen ctermbg=225

autocmd BufNewFile,BufRead *.md set filetype=markdown
autocmd FileType text setlocal textwidth=72
autocmd FileType markdown setlocal textwidth=72
autocmd BufNewFile,BufRead *.js,*.jsx,*.rb,*.yml setlocal shiftwidth=2
autocmd FileType ruby setlocal shiftwidth=2
autocmd FileType python setlocal textwidth=96
autocmd FileType gitconfig setlocal noexpandtab shiftwidth=8

highlight Title cterm=bold ctermfg=5

if filereadable(expand('~/.vimrc.local'))
  source ~/.vimrc.local
endif

let mapleader = ","
nnoremap <Leader>q gqap
nnoremap <Leader>b :w <bar> exe "! black -l 96 %" <bar> e <CR>
nnoremap <Leader>n :nohl <CR>
