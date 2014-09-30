if has('vim_starting')
  set nocompatible               " Be iMproved

  " Required:
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('~/.vim/bundle'))


if neobundle#has_fresh_cache()
  NeoBundleLoadCache
else
  NeoBundle 'Valloric/YouCompleteMe.git' , {
       \ 'build': {
       \   'unix': './install.sh --clang-completer --system-libclang'
       \           .' || ./install.sh --clang-completer',
       \ 'directory': 'YouCompleteMe',
       \ }}

  " Let NeoBundle manage NeoBundle
  " Required:
  NeoBundleFetch 'Shougo/neobundle.vim'

  " Add or remove your Bundles here:
  " NeoBundle 'Shougo/neosnippet.vim'
  " NeoBundle 'Shougo/neosnippet-snippets'
  NeoBundle 'tpope/vim-fugitive'
  NeoBundle 'kien/ctrlp.vim'
  NeoBundle 'flazz/vim-colorschemes'
  NeoBundle 'SirVer/ultisnips'
  NeoBundle 'honza/vim-snippets'
  " You can specify revision/branch/tag.
  NeoBundle 'Shougo/vimshell', { 'rev' : '3787e5' }

  NeoBundle 'tpope/vim-sensible'
  NeoBundle 'tpope/vim-unimpaired'
  NeoBundle 'tpope/vim-surround'
  NeoBundle 'tpope/vim-endwise'
  NeoBundle 'tpope/vim-markdown'
  NeoBundle 'tpope/vim-ragtag'
  NeoBundle 'tpope/vim-repeat'
  NeoBundle 'tpope/vim-speeddating'
  NeoBundle 'tpope/vim-abolish'
"  NeoBundle 'tpope/vim-commentary'
  NeoBundle 'tomtom/tcomment_vim'
  NeoBundle 'embear/vim-localvimrc'
  NeoBundle 'bling/vim-airline'

  NeoBundle 'git://git.code.sf.net/p/vim-latex/vim-latex'

  NeoBundle 'mtth/cursorcross.vim.git'
  NeoBundleLazy 'blueyed/delimitMate.git', {
        \ 'autoload': { 'insert': 1 }}
  NeoBundle 'blueyed/file-line.git'
  NeoBundle 'blueyed/nerdtree.git', {
        \ 'augroup' : 'NERDTreeHijackNetrw' }
  NeoBundle 'kana/vim-operator-user.git'

  NeoBundle 'kana/vim-textobj-user.git'
  NeoBundle 'kana/vim-textobj-function.git'
  NeoBundle 'kana/vim-textobj-indent.git'
  NeoBundle 'mattn/vim-textobj-url'

  NeoBundle 'dbakker/vim-projectroot.git'
  NeoBundle 'tomtom/quickfixsigns_vim.git'
  NeoBundle 'chrisbra/SudoEdit.vim.git'
  NeoBundle 'kurkale6ka/vim-swap.git'
  NeoBundle 'scrooloose/syntastic.git'
  NeoBundle 'justinmk/vim-sneak.git'

  NeoBundle 'ervandew/eclim'

  NeoBundle 'blueyed/vim-colors-solarized.git'
endif

" Required:
call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck


let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"


" Use both , and Space as leader.
let mapleader = ","
" Not for imap!
" Sets the mapleader in normal mode on <space>
nmap <space> <leader>
" Sets the mapleader in visual mode on <space>
vmap <space> <leader>

nmap <leader>v "+p
nmap <leader>V "*P

" To Edit the configuration while using vim
function! MyEditConfig(path, ...)
  let cmd = a:0 ? a:1 : 'split'
  exec (WindowIsEmpty() ? 'e' : cmd) a:path
endfunction

" edit vimrc shortcut
" nnoremap <leader>ec <C-w><C-s><C-l>:exec "e ".resolve($MYVIMRC)<cr>
nnoremap <leader>ec :let sshm=&shm \| set shm+=A \| call MyEditConfig(resolve($MYVIMRC)) \| let &shm = sshm<cr>
nnoremap <leader>Ec :let sshm=&shm \| set shm+=A \| call MyEditConfig(resolve($MYVIMRC), 'vsplit') \| let &shm = sshm<cr>
" " edit zshrc shortcut
" nnoremap <leader>ez :call MyEditConfig(resolve("~/.zshrc"))<cr>
" " edit tmux shortcut
" nnoremap <leader>et :call MyEditConfig(resolve("~/.tmux.common.conf"))<cr>
" " edit .lvimrc shortcut (in repository root)
" nnoremap <leader>elv :call MyEditConfig(ProjectRootGuess().'/.lvimrc')<cr>
" nnoremap <leader>em :call MyEditConfig(ProjectRootGuess().'/Makefile')<cr>


" CR and BS mapping: call/setup various plugins manually. {{{
let g:endwise_no_mappings = 1  " NOTE: must be unset instead of 0
let g:cursorcross_no_map_CR = 1
let g:cursorcross_no_map_BS = 1
let g:delimitMate_expand_cr = 0
let g:SuperTabCrMapping = 0  " Skip SuperTab CR map setup (skipped anyway for expr mapping)

let g:cursorcross_mappings = 0  " No generic mappings for cursorcross.

" Force delimitMate mapping (gets skipped if mapped already).
fun! My_CR_map()
  " "<CR>" via delimitMateCR
  if len(maparg('<Plug>delimitMateCR', 'i'))
    let r = "\<Plug>delimitMateCR"
  else
    let r = "\<CR>"
  endif
  if len(maparg('<Plug>CursorCrossCR', 'i'))
    " requires vim 704
    let r .= "\<Plug>CursorCrossCR"
  endif
  if len(maparg('<Plug>DiscretionaryEnd', 'i'))
    let r .= "\<Plug>DiscretionaryEnd"
  endif
  return r
endfun
imap <expr> <CR> My_CR_map()

fun! My_BS_map()
  " "<BS>" via delimitMateBS
  if len(maparg('<Plug>delimitMateBS', 'i'))
    let r = "\<Plug>delimitMateBS"
  else
    let r = "\<BS>"
  endif
  if len(maparg('<Plug>CursorCrossBS', 'i'))
    " requires vim 704
    let r .= "\<Plug>CursorCrossBS"
  endif
  return r
endfun
imap <expr> <BS> My_BS_map()

" For endwise.
imap <C-X><CR> <CR><Plug>AlwaysEnd
" }}}


" Do not display "Pattern not found" messages during YouCompleteMe completion.
" Patch: https://groups.google.com/forum/#!topic/vim_dev/WeBBjkXE8H8
if 1 && exists(':try')
  try
    set shortmess+=c
  " Catch "Illegal character" (and its translations).
  catch /E539: /
  endtry
endif
