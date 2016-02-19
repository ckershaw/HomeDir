" to use this vimrc, copy it to ~/.vimrc
" (make sure to back your's up if you want to save it first)
" in case you haven't noticed, " is the comment character in vim config files
set autochdir
set nospell
filetype plugin on

"---------Latex_______--------------------------------------------------

command Ltx w|!pdflatex % && gnome-open %:r.pdf

inoremap <F4> <C-O>:Ltx
nnoremap <F4> :Ltx
onoremap <F4> <C-C>:Ltx
vnoremap <F4> :Ltx

noremap <F3> :w !detex \| wc <CR>

"---------standard options--------------------------------------------------

set hlsearch
set smartcase

set expandtab
set shiftwidth=4
set softtabstop=4

vnoremap > >gv
vnoremap < <gv

set mouse=a

set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<

" Show last status all the time
set ls=2
set statusline=%<%F\ %h%m%r%y%=%-14.(%l/%L,%c%V%)\ %P
:let g:buftabs_in_statusline=1

nmap ,d :b#<bar>bd#<cr>

set tabpagemax=1
set foldmethod=syntax
set foldlevelstart=99

highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
match ExtraWhitespace /\s\+$/ " Match trailing whitespac

" sudo to write
cnoremap w!! w !sudo tee % >/dev/null

au BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} set filetype=markdown
au BufRead,BufNewFile *.lcm     setfiletype c
au BufRead,BufNewFile *.cfg     setfiletype c
au BufRead,BufNewFile *.config  setfiletype c
au BufRead,BufNewFile *.conf    setfiletype c
au BufRead,BufNewFile *.dox     setfiletype c
au FileType text :set foldmethod=indent
au FileType tex :set foldmethod=marker
au FileType tex :let g:tex_indent_items = 1
au FileType tex :set foldmarker=\begin,\end
set autoindent
filetype plugin indent on

set cinoptions=l1,(0,u0,j1
"remove trailing whitespace from all files
autocmd BufWritePre * : :%s/\s\+$//e

"Fold
inoremap <F1> <C-O>za
nnoremap <F1> za
onoremap <F1> <C-C>za
vnoremap <F1> zf

"abbreviations
iab #i #include
iab #d #define

set shellcmdflag=-ic

" Completion
set wildmode=list:longest

set wildmenu
set wildignore=*.swp,*.bak,*.d
"set wildignore+=*/.svn/*,/*.hg/*,/*.git/* " Version control
set wildignore+=*/.virtualenvs/*
set wildignore+=*.aux,*.out,*.toc " LaTeX stuff
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg "Pics
set wildignore+=*.o,*.obj,*.pyc,*.class "compiled files, bytecode
set wildignore+=*.DS_Store
set wildignore+=*.pdf,*.xls,*.xlsx,*.doc
set wildignore+=*.jar


inoremap <F5> <C-O>:make
nnoremap <F5> :make
onoremap <F5> <C-C>:make
vnoremap <F5> :make

"avoid escape!
:imap jk <Esc>
:imap Jk <Esc>
:imap jK <Esc>
:imap JK <Esc>

"tab next/previous
map H :bp!<CR>
map L :bn!<CR>
noremap <C-PageUp> :bp!<CR>
noremap <C-PageDown> :bn!<CR>


"quick edit/source vimrc
nmap ,v :tabnew ~/.vimrc<return>
nmap ,s :source ~/.vimrc<return>

nmap ,m :make -j<return>

"time out on key codes but not mappings
set notimeout
set ttimeout
set ttimeoutlen=10

"delete gets lot"
set bs=2

"backups
set backup
set backupdir=~/.vim/backup
set backupext=~


noremap K <nop>
    " disable the shift K command because I hit it and it does annoying things
    "
set t_Co=256
set bg=dark

colorscheme wombat256mod

syntax on
noremap <silent> <C-n> :let @/="azsfaesrgesdsdrswer"<CR>

inoremap {<CR> {<CR>}<Esc>O
inoremap <silent> <C-d> <esc>ddko
inoremap <silent> <C-f> <esc>kJi

"---------resizing splits----------------------------------------------------
"noremap = <esc><C-w>>
    " = increase size of vertically split window
noremap - <esc><C-w><
    " - decrease size of vertically split window
noremap + <esc><C-w>+
    " + increase size of horizontally split window
noremap _ <esc><C-w>-
    " _ decrease size of horizontally split window

"----------moving between splits------------------------------------
noremap gh <esc><C-w><Left>
    " gh moves left one vertically split window
noremap gl <esc><C-w><Right>
    " gl moves right one vertically split window
noremap gj <esc><C-w><Down>
    " gj moves down one horizontally split window
noremap gk <esc><C-w><Up>
    " gk moves up one horizontally split window

"---------home, end, pgup, pgdn-----------------------------------------------
noremap <silent> <C-l> $
    " <C-l> goes to end of line
noremap <silent> <C-h> ^
    " <C-h> goes to beginning of line
inoremap <silent> <C-l> <esc>A
    " <C-l> goes to end of line in insert mode
inoremap <silent> <C-h> <esc>^i
    " <C-h> goes to beginning of line in insert mode

"---------compiler error window---------------------------------------------
noremap <silent> cn <esc>:cn<CR>
    " cn goes to the next compiler error (must compile with :make in vim)
noremap <silent> cp <esc>:cp<CR>
    " cp goes to the previous compiler error (must compile with :make in vim)

"---------don't fill buffer with single char delete-------------------------
noremap <silent> x "_x

"-------comments ------------------------------------------------------------
let b:comment_leader = '//'
au FileType c,cpp,java,javascript let b:comment_leader = '//'
au FileType haskell,vhdl,ada let b:comment_leader = '--'
au FileType vim let b:comment_leader = '"'
au FileType sh,make,r,python,cmake,conf let b:comment_leader = '#'
au FileType matlab,tex let b:comment_leader = '%'
    "set up comment characters for given filetypes

noremap ,c mC :call Comment()<cr> 'C
noremap ,u mC :call Uncomment()<cr> 'C

function! Comment() range
    for lineno in range(a:firstline, a:lastline)
        let line = getline(lineno)
        if strlen(line) > 2
            let nonws = matchend(line, '^\s*')
            let sbegin = strpart(line, 0, nonws)
            let send   = strpart(line, nonws)
            let cleanLine = sbegin . b:comment_leader . send
            call setline(lineno, cleanLine)
        endif
    endfor
endfunction

function! Uncomment() range
    for lineno in range(a:firstline, a:lastline)
        let line = getline(lineno)
        let nonws = matchend(line, '^\s*')
        let com = match(line, b:comment_leader, nonws)
        if com == nonws
            let cleanLine = substitute(line, b:comment_leader, "", 'e')
            call setline(lineno, cleanLine)
        endif
    endfor
endfunction


"noremap <silent> ,c :<C-B>sil <C-E>s/^\(\s*\)/\1<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:noh<CR>
"noremap <silent> ,u :<C-B>sil <C-E>s/^\(\s*\)\V<C-R>=escape(b:comment_leader,'\/')<CR>/\1/e<CR>:noh<CR>

"-------tags----------------------------------------------------------------
set tags=./tags;/
    "sets default tag file name
noremap <silent> th <esc>:pclose<CR>
    " th closes preview window
noremap <silent> tJ <esc>:exec("tag ".expand("<cword>"))<CR>
    " tJ to open the tag
noremap <silent> tj <esc>:exec("ptag ".expand("<cword>"))<CR>
    " tj preview the tag
noremap <silent> t<C-j> <esc>:tab split<CR>:exec("tag ".expand("<cword>"))<CR>
    " t<C-j> opens the destination of following the tag in a new tab
noremap <silent> t<A-j> <esc>:vsp <CR>:exec("tag ".expand("<cword>"))<CR>
    " t<A-j> opens the destination of following the tag in a vsplit window
noremap <silent> tK <esc>:exec("tselect ".expand("<cword>"))<CR>
    " tK executes tag select
noremap <silent> tk <esc>:exec("ptselect ".expand("<cword>"))<CR>
    " tk previews the tag select
noremap <silent> t<C-k> <esc>:tab split<CR>:exec("tselect ".expand("<cword>"))<CR>
    " t<C-k> opens the tselect of the tag in a new tab
noremap <silent> t<A-k> <esc>:vsp <CR>:exec("tselect ".expand("<cword>"))<CR>
    " t<A-k> opens the tselect of the tag in a vsplit window

"------DICT----------------
"set dictionary-=/usr/share/dict/words
"set dictionary+=/usr/share/dict/words

set complete-=k
set complete+=k

set completeopt=longest,menuone

"inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
"
inoremap <expr> <C-n> pumvisible() ? '<C-n>' :
  \ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
"
inoremap <expr> <C-e> pumvisible() ? '<C-n>' :
  \ '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

set tags=./.tags;
set omnifunc=syntaxcomplete#Complete


