" vundle:
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Bundle 'gmarik/vundle'
Bundle 'Valloric/YouCompleteMe'
Bundle 'plasticboy/vim-markdown'

call vundle#end()
filetype plugin indent on

" vim-markdown:
let g:vim_markdown_folding_disabled=1
"let g:vim_markdown_initial_foldlevel=1
"
:setlocal spell spelllang=en_us
set nospell

" mine:
set autoread " changes to file automatically read w/o warning
set nobackup
set noswapfile

" if you don't disable writing backups file are touched twice per save
" messing with "watch" commands.  See http://stackoverflow.com/questions/21608480/gulp-js-watch-task-runs-twice-when-saving-files
set nowritebackup

syntax enable

colors desert
set spl=en_ca
set wildmode=longest,list
set nohlsearch
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent smartindent nocindent " last two added recently
set copyindent
" set shiftround
set ignorecase
set smartcase
set incsearch
set hls
set hidden " allows open file without save, and preserves undo buffer
set scrolloff=3
"set cursorline

set wildmode=longest,list,full
set wildmenu
set ruler

set formatoptions=croqlj " :help fo-table

function! CleverTab()
   if strpart( getline('.'), 0, col('.')-1 ) =~ '^\s*$'
      return "\<C-T>"
   else
      return "\<C-P>"
endfunction
inoremap <Tab> <C-R>=CleverTab()<CR>

function! CleverBackspace()
   if strpart( getline('.'), 0, col('.')-1 ) =~ '^\s+$'
      return "\<C-D>"
   else
      return "\<C-H>"
endfunction
"inoremap <C-H> <C-R>=CleverBackspace()<CR>
"inoremap <C-?> <C-R>=CleverBackspace()<CR>

set clipboard=unnamed,autoselect,exclude:cons\|linux

"nmap <C-S-v> "+gp
"imap <C-S-v> <ESC><C-S-v>i
"vmap <C-S-c> "+y
"vmap <C-S-x> "+d

" allows for :w!! to write to a file you need root for!
cmap w!! w !sudo tee % >/dev/null

" The following maps Alt+Up/Down to move line Up/Down one
" mapping up in terms of down fixes several bugs
nmap <silent> <A-Down> ddp
imap <silent> <A-Down> <Esc>ddpA
nmap <silent> <A-Up> k<A-Down>k
imap <silent> <A-Up> <Esc>k<A-Down>kA

"map <silent> <F1> <Esc>:set hls!<CR>
"map! <silent> <F1> <Esc>:set hls!<CR>a
map <silent> <F1> <Esc>:let @/=""<CR>
map! <silent> <F1> <Esc>:let @/=""<CR>a

"set listchars=tab:>-
set listchars=tab:>-,trail:.,extends:#,nbsp:.
set list " :set list to turn on tab highlighting

map  <silent> <F2> <Esc>:set list!<CR>
map! <silent> <F2> <Esc>:set list!<CR>a

map  <silent> <F3> <Esc>:set spell!<CR>
map! <silent> <F3> <Esc>:set spell!<CR>a
"set pastetoggle=<F3>
"map  <silent> <F3> <Esc>:set paste!<CR>
"map! <silent> <F3> <Esc>:set paste!<CR>a

function! NumberToggle()
  " Want to go from none -> number -> relative -> ..repeat
  if (&relativenumber == 1)
    set norelativenumber
    set nonumber
  elseif (&number == 1)
    set relativenumber
  else
    set number
  endif
endfunc

":set number!<CR>
":set number!<CR>a
noremap  <silent> <F4> <Esc>:call NumberToggle()<cr>
noremap! <silent> <F4> <Esc>:call NumberToggle()<cr>a

"noremap  <silent> <F5> <Esc>mPyypVr*0r/$r/k`P
"noremap! <silent> <F5> <Esc>mPyypVr*0r/$r/k`Pa
"
"noremap  <silent> <F6> <Esc>mPo<Esc>a//<Esc>78i*<Esc>`P
"noremap! <silent> <F6> <Esc>mPo<Esc>a//<Esc>78i*<Esc>`Pa
"
"noremap  <silent> <S-F7> <Esc>mPOprintf("   [%i - %p] %s\n", getpid(), this, __PRETTY_FUNCTION__);<Esc>`P
"noremap  <silent> <F7> <Esc>mPoprintf("   [%i - %p] %s\n", getpid(), this, __PRETTY_FUNCTION__);<Esc>`P
"noremap! <silent> <F7> printf("   [%i - %p] %s\n", getpid(), this, __PRETTY_FUNCTION__);

noremap  <silent> <F8> <Esc>:source ~/.vimrc<CR>
noremap! <silent> <F8> <Esc>:source ~/.vimrc<CR>a

" tab navigation like firefox
:map! <C-S-tab> <Esc>:tabprevious<CR>
:map  <C-S-tab>      :tabprevious<CR>
:map! <C-tab>   <Esc>:tabnext<CR>
:map  <C-tab>        :tabnext<CR>
:map! <C-t>     <Esc>:tabnew<CR>
:map  <C-t>          :tabnew<CR>
:map! <C-F4>    <Esc>:tabclose<CR>
:map  <C-F4>         :tabclose<CR>

nnoremap <leader>S ?{<CR>jV/^\s*\}?$<CR>k:sort<CR>:noh<CR>

nnoremap <leader>w <C-w>v<C-w>l
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

map ;; <Esc>:%s///g<Left><Left><Left>
map ;' <Esc>:%s///gc<Left><Left><Left><Left>

"nnoremap / /\v "\v means regular regex
"vnoremap / /\v

nnoremap Y y$

nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

nnoremap <Home> g0
nnoremap <End> g$
vnoremap <Home> g0
vnoremap <End> g$
inoremap <Home> <C-o>g0
inoremap <End> <C-o>g$

nnoremap <Down> gj
nnoremap <Up> gk
vnoremap <Down> gj
vnoremap <Up> gk
inoremap <Down> <C-o>gj
inoremap <Up> <C-o>gk

" Abbreviations

" Code
iab #d #define
iab #i #include
"iab #bark std::cout << __PRETTY_FUNCTION__ << std::endl
"iab #cpp #include <iostream><CR>#include <algorithm><CR><CR>int main(int argc, char const *argv[])<CR>{<CR><TAB>BARK;<CR>}<CR>

" Command abreviations
" Note: these abbreviations affect search as well so /W will search /w Need to fix this..
cab W w
cab Wq wq
cab WQ wq
cab Q q
" :map :Q :q
" :map :W :w
" :map :Wq :wq
" :map :WQ :wq

" Cange tabwidth with N<Leader><Tab>, e.g. 4\Tab 2\Tab
nmap <silent> <Leader><Tab> :<C-U>exe "set ts=" . v:count1 . " sts=" . v:count1 . " sw=" . v:count1<CR>

"call indent_guides#enable()
"IndentGuidesEnable
