" Random vim config collected and handed over through the years at the Student
" Society in Trondheim
" Now mine.

filetype plugin indent on
syntax on

let osys=system('uname -s')
let vimdir=$HOME . '/.vim/'

" Store all backup files in a central folder instead of cluttering
let &viminfo="'20," . '%,n' . vimdir . 'viminfo'
let &backupdir=vimdir . 'tmp'

" Stop whining when setting up on a new machine
if !isdirectory(&backupdir)
    call mkdir(&backupdir, "p")
endif


" If we have a saved position in the file, go there.
autocmd BufReadPost *
            \ if line("'\"") > 0 && line("'\"") <= line("$") |
            \   exe "normal g`\"" |
            \ endif


set backup              " Keep a backup file
set errorbells          " beep/flash on errors
set history=100         " keep 100 lines of command history
set nocompatible        " Use Vim defaults, not annoying vi
set nowrap              " fuckg wrapping
set number              " show line numbers
set nowarn              " I don't care
set ruler               " Show the cursor position all the time
set suffixes+=.class,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc
set showcmd             " show last command
set showmatch           " show matching brace when inserting
set shortmess=at        " shortens messages to avoid 'press a key' prompt
set diffopt+=iwhite     " ignore trailing whitespace in vimdiff
set novisualbell        " just let the terminal blink
set wildmode=list:longest   " file-listing when opening a directory

" Folding
set foldmethod=manual   " I don't trust people
set foldlevelstart=99   " start with all folds open
set foldopen-=search    " don't open folds when you search into them
set foldopen-=undo      " don't open folds when you undo stuff

" Input
set timeout             " allow keys to timeout
set ttimeoutlen=100     " Timeout of successive keys from keyboard driver, avoid annoying delays

" Indentation
set ai              " Always set auto-indenting on
set backspace=2     " Allow backspacing over everything in insert mode
set expandtab       " expand tabs to spaces
set tabstop=8       " be very explicit when people are annoying
set softtabstop=4
set shiftwidth=4

" Search
set hlsearch            " highlight last search
set smartcase           " search good
set ignorecase          " ignore case by default
set scrolloff=5         " show some context around the search result

" latex-suite wants grep to always generate a file-name.
set grepprg=grep\ -nH\ $*

" Disable autoloading of vimspell
let loaded_vimspell = 1
let spell_insert_mode = 0
let spell_auto_type = "tex,mail"
let spell_language_list = "norsk,english"

" F1 for help is really annoying.
:nmap <F1> :echo<CR>
:imap <F1> <C-o>:echo<CR>

:nmap q :echo<CR>

" Misstyping ; is annoying
:nnoremap ; :
" Because I type this wrong all the time
:command Q q
:command Qall qall


" Redraw screen and clear search highlight
nnoremap <silent> <C-l> :nohl<CR><C-l>

"" Change directory to the directory of the file I'm working on.
"autocmd BufEnter * 
"	    \ if isdirectory( '%:p:h' ) |
"	    \	lcd %:p:h |
"	    \ endif

" Set a satusline that gives some cool information.
set statusline=%<%F%h%m%r%=\[%B\]\ %l,%c%V\ %P
" Always show the statusline
set laststatus=2

" Don't use Ex mode, use Q for formatting
map Q gq

let g:Tex_DefaultTargetFormat="dvi"

" We play utf-8
set fileencoding=utf-8
set encoding=utf-8
set termencoding=utf-8
au BufNewFile,BufRead mutt*    set tw=77 ai nocindent fileencoding=utf-8
au BufNewFile,BufRead psql.edit.*    set tw=77 ai nocindent fileencoding=utf-8 filetype=sql

" Open multiple files in new tabs
au VimEnter * if !&diff | tab all | tabfirst | endif

" Colors
" dark background good
set background=dark

" Highlight bogus whitespace at the end of files
highlight WhitespaceEOL ctermbg=red guibg=red
match WhitespaceEOL /\s\+$/


" Make spelling errors readable
highlight SpellBad ctermbg=0 ctermfg=1

" Make diffs readable, darker backgrounds
"  - darkest red
highlight DiffText ctermbg=88
"  - dark pink
highlight DiffChange ctermbg=54
"  - navy blue, darkest blue I could find
highlight DiffAdd ctermbg=17
"  - dark green
highlight DiffDelete ctermbg=22
