" to use this vimrc, copy it to ~/.vimrc
" (make sure to back your's up if you want to save it first)
" in case you haven't noticed, " is the comment character in vim config files

"---------standard options--------------------------------------------------
set shiftwidth=4 tabstop=4 
    " tab sizes
"set number
    " use line numbers

set expandtab 
au FileType make,text :setlocal noexpandtab
    " expand tabs, but only if you are not editing a make file or a txt file

set tabpagemax=25

au BufRead,BufNewFile *.lcm set filetype=c
    " if reading an lcm file, treat it like a c file
au BufRead,BufNewFile *.dox set filetype=c
    " if reading an dox file, treat it like a c file
au FileType c,cpp,java,matlab,sh,make :setlocal cindent
    " if editing some form of code, use c indentation
au FileType text :setlocal smartindent
    " if reading a text file, use smart indenting

set foldmethod=syntax
inoremap <F1> <C-O>za
nnoremap <F1> za
onoremap <F1> <C-C>za
vnoremap <F1> zf

noremap <F2> <esc>:mksession! <C-R>="~/.vim_session" <CR>
    " Makes F2 save your vim session to ~/.vim_session (after you press enter)
noremap <F3> <esc>:source <C-R>="~/.vim_session" <CR>
    " Makes F3 load the vim session saved by F2 (after you press enter) 

noremap K <nop>
    " disable the shift K command because I hit it and it does annoying things

colorscheme ron "colorscheme elflord 
    " set the best color scheme
syntax on
    " turn on syntax highlighting
noremap <silent> <C-n> :noh<CR>
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
"noremap <silent> <C-j> L
    " <C-j> goes to bottom of page
"noremap <silent> <C-k> H
    " <C-k> goes to top of page
noremap <silent> L <nop>
    " L now does not go to bottom of page (use <C-d> for down)
noremap <silent> H <nop>
    " H now does not go to top of page (use <C-u> for up)
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
au FileType haskell,vhdl,ada let b:comment_leader = '--'
au FileType vim let b:comment_leader = '"'
au FileType c,cpp,java let b:comment_leader = '//'
au FileType sh,make let b:comment_leader = '#'
au FileType matlab,tex let b:comment_leader = '%'
    "set up comment characters for given filetypes

noremap <silent> ,c :<C-B>sil <C-E>s/^\(\s*\)/\1<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:noh<CR>
noremap <silent> ,u :<C-B>sil <C-E>s/^\(\s*\)\V<C-R>=escape(b:comment_leader,'\/')<CR>/\1/e<CR>:noh<CR>
    " maps ,c to comment out a line/section and ,u to uncomment a line/section

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

"-------Highlight Overlength------------------------------------------------
if exists('+colorcolumn')
    set colorcolumn=81
endif
