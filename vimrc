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


set ai				" Always set auto-indenting on
set bs=2		    " Allow backspacing over everything in insert mode
set bg=dark			" dark background good
set backup			" Keep a backup file
set backspace=2     " 'make backspace work like most other programs' says the documentation
set errorbells			" beep/flash on errors
set expandtab           " expand tabs to spaces
set foldmethod=manual   " I don't trust people
set foldlevelstart=99		" start with all folds open
set foldopen-=search		" don't open folds when you search into them
set foldopen-=undo		" don't open folds when you undo stuff
set history=100			" keep 50 lines of command history
set hlsearch			" highlight last search
set nocompatible		" Use Vim defaults, not annoying vi
set nowrap			" fuckg wrapping
set number			" show line numbers
set nowarn          " I don't care
set ruler			" Show the cursor position all the time
set suffixes+=.class,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc
set showcmd         " show last command
set showmatch			" show matching brace when inserting
set smartcase			" search good
set shortmess=at		"shortens messages to avoid 'press a key' prompt 
set shiftwidth=2		" two spaces per sw
set diffopt+=iwhite     " ignore trailing whitespace in vimdiff
set tabstop=8			" be very explicit when people are annoying
set softtabstop=4
set shiftwidth=4
set timeout			" allow keys to timeout
set ttimeoutlen=100		" Timeout of successive keys from keyboard driver
set novisualbell			" just let the terminal blink
set wildmode=list:longest	"(file-listing when opening a new file)

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


" Highlight bogus whitespace at the end of files
highlight WhitespaceEOL ctermbg=red guibg=red
match WhitespaceEOL /\s\+$/

" Make spelling errors readable
highlight SpellBad ctermbg=0 ctermfg=1

