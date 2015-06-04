" to use this vimrc, copy it to ~/.vimrc
" (make sure to back your's up if you want to save it first)
" in case you haven't noticed, " is the comment character in vim config files

"---------Latex_______--------------------------------------------------

command Ltx w|!pdflatex % && gnome-open %:r.pdf

inoremap <F4> <C-O>:Ltx
nnoremap <F4> :Ltx
onoremap <F4> <C-C>:Ltx
vnoremap <F4> :Ltx

noremap <F3> :w !detex \| wc <CR>

"---------standard options--------------------------------------------------

set hlsearch
set noincsearch
set smartcase

set expandtab 
set shiftwidth=4
set softtabstop=4
"set textwidth=80

set mouse=a

set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<

set ls=2
set statusline=%<%F\ %h%m%r%y%=%-14.(%l,%c%V%)\ %P

au FileType make,text :setlocal noexpandtab

set tabpagemax=25
set foldmethod=syntax
set foldlevelstart=99

" sudo to write
cnoremap w!! w !sudo tee % >/dev/nullndif

au BufRead,BufNewFile *.lcm set filetype=c
au BufRead,BufNewFile *.cfg set filetype=c
au BufRead,BufNewFile *.config set filetype=c
au BufRead,BufNewFile *.dox set filetype=c
"au FileType c,cpp,java,matlab,sh,make :setlocal cindent
"au FileType text :setlocal smartindent 
au FileType text :set foldmethod=indent 
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
iab teh the
iab tihs this
ca maek make
ca amek make
ca amke make
ca amk mak
ca mka mak

set shellcmdflag=-ic

" Completion
set wildmode=list:longest

set wildmenu
set wildignore=*.swp,*.bak,*.d
set wildignore+=*/.svn/*,/*.hg/*,/*.git/* " Version control
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
map H gT<esc>
map L gt<esc>


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

command Make cd `=startdir` | make
command MakeHere let startdir=getcwd() | Make
set autochdir 


noremap <F2> <esc>:mksession! <C-R>=".vim_session" <CR>
    " Makes F2 save your vim session to ~/.vim_session (after you press enter)
"noremap <F3> <esc>:source <C-R>=".vim_session" <CR>
    " Makes F3 load the vim session saved by F2 (after you press enter) 



noremap K <nop>
    " disable the shift K command because I hit it and it does annoying things
    "
set t_Co=256
set bg=dark

"colorscheme ir_black
colorscheme wombat256mod

"colorscheme ron
"colorscheme elflord 
"colorscheme xoria256
"colorscheme molokai_mac
"colorscheme peaksea
syntax on
    " turn on syntax highlighting
noremap <silent> <C-n> :let @/="azsfaesrgesdsdrswer"<CR>
    " maps ctrl+n to turn off highlighting of words from search

"inoremap {     {}<Left>
inoremap {<CR> {<CR>}<Esc>O
"inoremap {{    {
"inoremap {}    {}
    " remapping that makes { form an auto closed pair either on the 
    " same line or the next if you hit enter fast enough

inoremap <silent> <C-d> <esc>ddko
    " maps ctrl+d in insert mode to delete your current line and append to the
    " one above it
inoremap <silent> <C-f> <esc>kJi
    " maps ctrl+f in insert mode to merge your current line with the
    " one above it

"---------resizing splits----------------------------------------------------
noremap = <esc><C-w>>
    " = increase size of vertically split window  
noremap - <esc><C-w><
    " - decrease size of vertically split window  
noremap + <esc><C-w>+
    " + increase size of horizontally split window  
noremap _ <esc><C-w>-
    " _ decrease size of horizontally split window  

"----------moving between tabs and splits------------------------------------
noremap gh <esc><C-w><Left>
    " gh moves left one vertically split window
noremap gH <esc><C-w><Left>
    " gH moves left one vertically split window (in ex mode gh is overridden)
noremap gl <esc><C-w><Right>
    " gl moves right one vertically split window
noremap gj <esc><C-w><Down>
    " gj moves down one horizontally split window
noremap gk <esc><C-w><Up>
    " gk moves up one horizontally split window
noremap gu <esc>gT
    " gu moves left one tab
noremap gi <esc>gt
    " gi moves right one tab

"----------opening tabs and splits------------------------------------------
noremap <silent> g<C-e> <esc>:Ex<CR>
    " g<C-e> opens explorer mode
noremap <silent> g<C-t> <esc>:Tex<CR>
    " g<C-t> opens a new tab and enters explorer mode in it
noremap <silent> g= <esc><C-w>v<C-w><Right>
    " g= splits window vertically and enters the right one
noremap <silent> g- <esc><C-w>v
    " g- splits window vertically and enters the left one
noremap <silent> g+ <esc><C-w>s
    " g+ splits window horizontally and enters the top one
noremap <silent> g_ <esc><C-w>s<C-w><Down>
    " g_ splits window horizontally and enters the bottom one

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
noremap <silent> cw <esc>:cw<CR>
    " cw opens the compiler output window (must compile with :make in vim)
noremap <silent> cc <esc>:ccl<CR>
    " cc closes the compiler output window (must compile with :make in vim)

"---------don't fill buffer with single char delete-------------------------
noremap <silent> x "_x
    " sends characters deleted with x to the null buffer so they don't 
    " overwrite things in the default paste buffer

"-------comments ------------------------------------------------------------
let b:comment_leader = '//'
au FileType c,cpp,java let b:comment_leader = '//'
au FileType haskell,vhdl,ada let b:comment_leader = '--'
au FileType vim let b:comment_leader = '"'
au FileType sh,make,r,python let b:comment_leader = '#'
au FileType matlab,tex let b:comment_leader = '%'
    "set up comment characters for given filetypes

"noremap ,c :call Comment()<CR>
"noremap ,u :call UnComment()<CR>

noremap <silent> ,c :<C-B>sil <C-E>s/^\(\s*\)/\1<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:noh<CR>
noremap <silent> ,u :<C-B>sil <C-E>s/^\(\s*\)\V<C-R>=escape(b:comment_leader,'\/')<CR>/\1/e<CR>:noh<CR>

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
set dictionary-=/usr/share/dict/words 
set dictionary+=/usr/share/dict/words

set complete-=k 
set complete+=k

set completeopt=longest,menuone

inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

inoremap <expr> <C-n> pumvisible() ? '<C-n>' :
  \ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

inoremap <expr> <M-,> pumvisible() ? '<C-n>' :
  \ '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
