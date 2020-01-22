let mapleader = ","

" Specify a directory for plugins
call plug#begin('~/.local/share/nvim/plugged')

" Use nerdtree for file browsing
Plug 'scrooloose/nerdtree'
" Toggle NERDTree
nnoremap <leader>a :NERDTreeToggle<cr>

" Move to and from Tmux panes and Vim panes
Plug 'christoomey/vim-tmux-navigator'

" The language syntax package
Plug 'sheerun/vim-polyglot'
syntax on

" The status bar color scheme
Plug 'vim-airline/vim-airline'

" inserts quotes and parenthesis in pairs as type
Plug 'jiangmiao/auto-pairs'
" no space between symbols
let g:AutoPairsMapSpace=0
let g:AutoPairsMultilineClose=0

" Intensely orgasmic commenting
Plug 'scrooloose/nerdcommenter'

" Highlight trailing whitespaces
Plug 'ntpeters/vim-better-whitespace'
" Strip all trailing whitespace
nnoremap <leader>f :StripWhitespace<cr>

" show git stuff in gutter
Plug 'airblade/vim-gitgutter'

" Indicator for what yanked
Plug 'machakann/vim-highlightedyank'

" Git integration glore
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
" Git status
nnoremap <leader>w :Gstatus<cr>

" Language protocol server
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
" config server for specific language
Plug 'ryanolsonx/vim-lsp-javascript'
Plug 'ryanolsonx/vim-lsp-typescript'
Plug 'ryanolsonx/vim-lsp-python'
if executable('html-languageserver')
  au User lsp_setup call lsp#register_server({
    \ 'name': 'html-languageserver',
    \ 'cmd': {server_info->[&shell, &shellcmdflag, 'html-languageserver --stdio']},
    \ 'whitelist': ['html'],
  \ })
endif
if executable('rls')
  au User lsp_setup call lsp#register_server({
      \ 'name': 'rls',
      \ 'cmd': {server_info->['rustup', 'run', 'stable', 'rls']},
      \ 'workspace_config': {'rust': {'clippy_preference': 'on'}},
      \ 'whitelist': ['rust'],
      \ })
endif
" Lsp hover
nnoremap <leader>e :LspHover<cr>
" Jump to definition
nnoremap <leader>d :LspDefinition<cr>

" New completion framework
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'
" enable ncm2 for all buffers
autocmd BufEnter * call ncm2#enable_for_buffer()
set completeopt=noinsert,menuone,noselect
" Connecting language protocol server with completion framework
Plug 'ncm2/ncm2-vim-lsp'
" Function parameter expansion support
Plug 'ncm2/ncm2-ultisnips'
Plug 'SirVer/ultisnips'
" Press enter key to trigger snippet expansion
inoremap <silent> <expr> <CR> ncm2_ultisnips#expand_or("\<CR>", 'n')
" c-j c-k for moving in snippet
let g:UltiSnipsJumpForwardTrigger = "<c-j>"
let g:UltiSnipsJumpBackwardTrigger = "<c-k>"
let g:UltiSnipsRemoveSelectModeMappings = 0
" suppress the annoying 'match x of y', 'The only match' and 'Pattern not found' messages
set shortmess+=cI
" Use this mapping to close the menu and also start a new line
" inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")
let g:python3_host_prog="/usr/local/bin/python3"
" completion sources
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-path'
Plug 'ncm2/ncm2-cssomni'
Plug 'ncm2/ncm2-tern', {'do': 'npm install'}
Plug 'ncm2/nvim-typescript', {'do': './install.sh'}
Plug 'ncm2/ncm2-jedi'
Plug 'ncm2/ncm2-racer'
Plug 'ncm2/ncm2-go'
Plug 'ncm2/ncm2-vim' | Plug 'Shougo/neco-vim'

" Markdown specific
Plug 'plasticboy/vim-markdown'

" Aligning stuff
Plug 'junegunn/vim-easy-align'

" Fuzzy finder
Plug 'junegunn/fzf'
" Key bind for toggling fzf
if executable('fzf')
  nnoremap <C-p> :FZF<cr>
endif

" Better than grepprg and replacement of grep
Plug 'mileszs/ack.vim'
" config for ripgrep
if executable('rg')
  let g:ackprg = '/usr/local/bin/rg --vimgrep'
  nnoremap <leader>r :Ack!
endif

" Update &runtimepath and initialize plugin system
call plug#end()

" Command alias
cmap Wq wq

" No highlight
nnoremap <leader><space> :noh<cr>

" Display hidden characters
set list
set listchars=tab:▸\ ,eol:↲,nbsp:␣,trail:•,extends:⟩,precedes:⟨

" work with mouse
set mouse=a

" Switch to normal mode from inserting mode & saving from normal mode
inoremap <C-c> <Esc>
nnoremap <C-c> :wa<cr>

" Allow backspacing over everything in insert mode
set backspace=indent,eol,start

" Save file when switching buffers
set autowrite

" Read file when switching buffers
set autoread

" Tab settings
set shiftwidth=2
set tabstop=2
set softtabstop=2
set expandtab
set smarttab

" Better vertical movement for wrapped lines
nnoremap j gj
nnoremap k gk

" MacOs clipboard sharing
set clipboard=unnamed

" Automatic indentation
set autoindent

" Undo function after reopening/persist undos across sessions
set undofile
set undodir=/tmp

" accelerated scrolling
set scrolljump=-15

" Column limits
set textwidth=110
set colorcolumn=110
set formatoptions=qrnj1
highlight ColorColumn ctermbg=238
"let &colorcolumn = join(range(81,999), ',')

" Toggle between column widths
nnoremap <leader>c :call ToggleColumnWidth()<cr>
let g:wide_column = 1
function! ToggleColumnWidth()
  if g:wide_column
    set textwidth=80
    set colorcolumn=80
    let g:wide_column = 0
  else
    set textwidth=110
    set colorcolumn=110
    let g:wide_column = 1
  endif
endfunction

" Searching settings
nnoremap / /\v
vnoremap / /\v
set ignorecase
set smartcase

" Sort lines in alphabetical order
vnoremap <leader>s :'<,'>!sort -f<cr>

" Quickly insert a timestamp
nnoremap tt "=strftime("%F %T%z")<CR>p

" Keep cursor to stay in the middle line of screen
set scrolloff=0
nnoremap <Leader>zz :let &scrolloff=999-&scrolloff<CR>

" Toggle quickfix window
nnoremap <leader><leader> :call ToggleQuickFix()<cr>
function! ToggleQuickFix()
  for buffer in tabpagebuflist()
    if bufname(buffer) == ''
      " Then it should be quickfix window
      cclose
      return
    endif
  endfor
  copen
endfunction

" Make workflow
nnoremap <leader>m :let &makeprg=""<left>
nnoremap <silent> <leader>b :cclose<cr>:silent !clear<cr>:make<cr>

" List candidates in wildmenu after tabbling, complete longest common part in matched results.
" Tabbing again will trigger selection among the matches.
set wildmode=list:longest,full
