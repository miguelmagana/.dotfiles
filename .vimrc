" ============================================================================
" VIM CONFIGURATION - Hacker/Bug Bounty Optimized
" ============================================================================

" Disable compatibility with vi which can cause unexpected issues.
set nocompatible

" Enable type file detection. Vim will be able to try to detect the type of file in use.
filetype on

" Enable plugins and load plugin for the detected file type.
filetype plugin on

" Load an indent file for the detected file type.
filetype indent on

" Turn syntax highlighting on.
syntax on
set background=dark

" ============================================================================
" VISUAL SETTINGS
" ============================================================================

" Add numbers to each line on the left-hand side.
set number
set relativenumber          " Relative line numbers

" Highlight cursor line underneath the cursor horizontally.
set cursorline

" Highlight cursor line underneath the cursor vertically.
set cursorcolumn

" Show matching words during a search.
set showmatch

" Show the mode you are on the last line.
set showmode

" Show partial command you type in the last line of the screen.
set showcmd

" Enhanced command completion
set wildmenu                " Enable auto completion menu after pressing TAB.
set wildmode=list:longest   " Make wildmenu behave like similar to Bash completion.

" ============================================================================
" EDITING SETTINGS
" ============================================================================

" Set shift width to 4 spaces.
set shiftwidth=4

" Set tab width to 4 columns.
set tabstop=4

" Use space characters instead of tabs.
set expandtab

" Smart auto-indenting
set smartindent
set autoindent

" Backspace behavior
set backspace=indent,eol,start

" ============================================================================
" SEARCH SETTINGS
" ============================================================================

" While searching though a file incrementally highlight matching characters as you type.
set incsearch

" Use highlighting when doing a search.
set hlsearch

" Ignore capital letters during search.
set ignorecase

" Override the ignorecase option if searching for capital letters.
" This will allow you to search specifically for capital letters.
set smartcase

" ============================================================================
" PERFORMANCE
" ============================================================================

" Do not let cursor scroll below or above N number of lines when scrolling.
set scrolloff=10
set sidescrolloff=5

" Don't redraw during macros
set lazyredraw

" Fast terminal connection
set ttyfast

" Update time for plugins
set updatetime=300

" ============================================================================
" FILES
" ============================================================================

" Do not save backup files.
set nobackup
set nowritebackup

" Do not create swap files
set noswapfile

" Auto-reload changed files
set autoread

" ============================================================================
" LAYOUT
" ============================================================================

" Do not wrap lines. Allow long lines to extend as far as the line goes.
set nowrap

" Break at word boundaries if wrapping
set linebreak

" No text width limit
set textwidth=0

" ============================================================================
" HISTORY
" ============================================================================

" Set the commands to save in history default number is 20.
set history=1000

" Undo levels
set undolevels=1000

" ============================================================================
" WILDCARD IGNORE
" ============================================================================

" There are certain files that we would never want to edit with Vim.
" Wildmenu will ignore files with these extensions.
set wildignore=*.o,*.obj,*.exe,*.dll,*.so,*.pyc,*.class
set wildignore+=*.jpg,*.jpeg,*.png,*.gif,*.pdf,*.doc,*.docx
set wildignore+=*.zip,*.tar,*.gz,*.bz2,*.rar

" ============================================================================
" KEY MAPPINGS
" ============================================================================

" Clear search highlighting
nnoremap <leader><space> :nohlsearch<CR>

" Quick save
nnoremap <leader>w :w<CR>

" Quick quit
nnoremap <leader>q :q<CR>

" Move between windows
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" ============================================================================
" COLOR SCHEME
" ============================================================================

" Try to use a dark theme
try
    colorscheme desert
catch
    " Fallback to default
endtry

" ============================================================================
" STATUS LINE
" ============================================================================

" Always show status line
set laststatus=2

" Enhanced status line with file info
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}

