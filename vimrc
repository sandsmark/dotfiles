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
set bg=dark			" gir ugly ugly farger, men men
set backup			" Keep a backup file
set backspace=2
set clipboard+=unnamed		" put yanks/etc on the clipboard
set errorbells			" beep/flash on errors, vil vi ha det da ???
set expandtab
set foldmethod=marker
set foldlevelstart=99		" start with all folds open
set foldopen-=search		" don't open folds when you search into them
set foldopen-=undo		" don't open folds when you undo stuff
set history=100			" keep 50 lines of command history
set hidden			" lukker ikke ei fil i et buffer når du forlater den ("abandon")
set hlsearch			" highlighter siste søk, kjekt....
"set incsearch			" noen syntes dette er nice, jeg synes ikke det :P
set nocompatible		" Use Vim defaults (much better!)
set nowrap			" vi liker da ikke wrap'ing... bare dritt
set number			" for å få linjenumrering... litt slitsomt i starten
set nowarn
set ruler			" Show the cursor position all the time
set suffixes+=.class,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc
set showcmd
set showmatch			" vise fold'a kode eller noe... ???
set smartcase			" lurt når man driver å søker...
set ignorecase          " ignore case by default when searching
set shortmess=at		"shortens messages to avoid 'press a key' prompt 
set shiftwidth=2		" two spaces per sw
set diffopt+=iwhite     " ignore trailing whitespace in vimdiff
" set smarttab			" sw at start, not tab
set sts=4
set sw=4
set ts=8
set tabstop=4			" The One True Tab
set softtabstop=4
set shiftwidth=4
set expandtab
set timeout			" allow keys to timeout
set ttimeoutlen=100		" Timeout of successive keys from keyboard driver
set novisualbell			" sørge for at vi bare får flash ihverfall
"set viminfo='20,\"50		" read/write a .viminfo file -- limit to only 50
set wildmode=list:longest	"(file-listing when opening a new file)

" latex-suite wants grep to always generate a file-name.
set grepprg=grep\ -nH\ $*

" Disable autoloading of vimspell
let loaded_vimspell = 1
let spell_insert_mode = 0
let spell_auto_type = "tex,mail"
let spell_language_list = "norsk,english"

" Setup Taglist plugin
let Tlist_Ctags_Cmd=$HOME . '/local/' . tolower(substitute(osys,"\n",'','')) . '/bin/ctags'

" F1 for help is really annoying.
:nmap <F1> :echo<CR>
:imap <F1> <C-o>:echo<CR>

:nmap q :echo<CR>

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


" Because I type this wrong all the time
:command Q q


" Highlight bogus whitespace at the end of files
highlight WhitespaceEOL ctermbg=red guibg=red
match WhitespaceEOL /\s\+$/

" Make spelling errors readable
highlight SpellBad ctermbg=0 ctermfg=1

