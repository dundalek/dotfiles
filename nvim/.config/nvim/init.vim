" vim: foldmethod=marker
" Press zM to close all folds to navigate the structure, zR to open all.
" Press zj / zk to jump to next / previous section.

" Global {{{1
" Set our leader key to space. This needs to be set first before all plugins
" are loaded.
let g:mapleader = "\<space>"
let g:maplocalleader = ","

" Plugins expect POSIX shell which can cause problems when closh is used
set shell=/usr/bin/env\ bash
let $SHELL = '/bin/bash'

" let g:sexp_filetypes = ''
" let g:parinfer_enabled = 0

let g:sexp_enable_insert_mode_mappings = 0

" Disable vim-sexp mappings that use localleader
let g:sexp_mappings = {
  \ 'sexp_round_head_wrap_list':      '',
  \ 'sexp_round_tail_wrap_list':      '',
  \ 'sexp_square_head_wrap_list':     '',
  \ 'sexp_square_tail_wrap_list':     '',
  \ 'sexp_curly_head_wrap_list':      '',
  \ 'sexp_curly_tail_wrap_list':      '',
  \ 'sexp_round_head_wrap_element':   '',
  \ 'sexp_round_tail_wrap_element':   '',
  \ 'sexp_square_head_wrap_element':  '',
  \ 'sexp_square_tail_wrap_element':  '',
  \ 'sexp_curly_head_wrap_element':   '',
  \ 'sexp_curly_tail_wrap_element':   '',
  \ 'sexp_insert_at_list_head':       '',
  \ 'sexp_insert_at_list_tail':       '',
  \ 'sexp_splice_list':               '',
  \ 'sexp_convolute':                 '',
  \ 'sexp_raise_list':                '',
  \ 'sexp_raise_element':             '',
  \
  \ 'sexp_swap_list_backward':        '',
  \ 'sexp_swap_list_forward':         '',
  \ 'sexp_swap_element_backward':     '',
  \ 'sexp_swap_element_forward':      '',
  \ 'sexp_emit_head_element':         '',
  \ 'sexp_emit_tail_element':         '',
  \ 'sexp_capture_prev_element':      '',
  \ 'sexp_capture_next_element':      '',
  \ }

" Disable word movement overrides for vim-sexp-mappings-for-regular-people
" let g:sexp_no_word_maps = 1

function! WithParinfer(op)
  " turn on parinfer to not interfere with sexp manipulation
  let g:parinfer_enabled = 0

  " run sexp command
  " maybe add <silent>
  execute "normal \<Plug>(" . a:op . ")"

  " switching back parinfer in paren mode will make it correct indentation
  let g:parinfer_mode = 'paren'
  let g:parinfer_enabled = 1

endfunction

function! s:map_parinfer_sexp(binding, op)
  " switching back parinfer to smart mode after indentation gets corrected
  execute 'nmap <buffer>' a:binding ':call WithParinfer("'.a:op.'")<cr>:let g:parinfer_mode="smart"<cr>'
endfunction

function! ToggleMovementX(firstOp, thenOp)
  let pos = getpos('.')
  let c = v:count > 0 ? v:count : ''
  execute "normal " . c . a:firstOp
  if pos == getpos('.')
    execute "normal! " . c . a:thenOp
  endif
endfunction

function! s:sexp_mappings() abort
  nmap <buffer> B   :call ToggleMovementX("\<Plug>(sexp_move_to_prev_element_head)", 'h')<cr>
  nmap <buffer> W   :call ToggleMovementX("\<Plug>(sexp_move_to_next_element_head)", 'l')<cr>
  nmap <buffer> gE  :call ToggleMovementX("\<Plug>(sexp_move_to_prev_element_tail)", 'h')<cr>
  nmap <buffer> E   :call ToggleMovementX("\<Plug>(sexp_move_to_next_element_tail)", 'l')<cr>

  " nmap <buffer> B   <Plug>(sexp_move_to_prev_element_head)
  " nmap <buffer> W   <Plug>(sexp_move_to_next_element_head)
  " nmap <buffer> gE  <Plug>(sexp_move_to_prev_element_tail)
  " nmap <buffer> E   <Plug>(sexp_move_to_next_element_tail)
  xmap <buffer> B   <Plug>(sexp_move_to_prev_element_head)
  xmap <buffer> W   <Plug>(sexp_move_to_next_element_head)
  xmap <buffer> gE  <Plug>(sexp_move_to_prev_element_tail)
  xmap <buffer> E   <Plug>(sexp_move_to_next_element_tail)
  omap <buffer> B   <Plug>(sexp_move_to_prev_element_head)
  omap <buffer> W   <Plug>(sexp_move_to_next_element_head)
  omap <buffer> gE  <Plug>(sexp_move_to_prev_element_tail)
  omap <buffer> E   <Plug>(sexp_move_to_next_element_tail)

  nmap <buffer> <I  <Plug>(sexp_insert_at_list_head)
  nmap <buffer> >I  <Plug>(sexp_insert_at_list_tail)
  call s:map_parinfer_sexp('<f', 'sexp_swap_list_backward')
  call s:map_parinfer_sexp('>f', 'sexp_swap_list_forward')
  call s:map_parinfer_sexp('<e', 'sexp_swap_element_backward')
  call s:map_parinfer_sexp('>e', 'sexp_swap_element_forward')
  call s:map_parinfer_sexp('>(', 'sexp_emit_head_element')
  call s:map_parinfer_sexp('<)', 'sexp_emit_tail_element')
  call s:map_parinfer_sexp('<(', 'sexp_capture_prev_element')
  call s:map_parinfer_sexp('>)', 'sexp_capture_next_element')

  call s:map_parinfer_sexp('<M-k>', 'sexp_swap_list_backward')
  call s:map_parinfer_sexp('<M-j>', 'sexp_swap_list_forward')
  call s:map_parinfer_sexp('<M-h>', 'sexp_swap_element_backward')
  call s:map_parinfer_sexp('<M-l>', 'sexp_swap_element_forward')
  call s:map_parinfer_sexp('<M-S-j>', 'sexp_emit_head_element')
  call s:map_parinfer_sexp('<M-S-k>', 'sexp_emit_tail_element')
  call s:map_parinfer_sexp('<M-S-h>', 'sexp_capture_prev_element')
  call s:map_parinfer_sexp('<M-S-l>', 'sexp_capture_next_element')


  call s:map_parinfer_sexp('<O', 'sexp_raise_list')
  call s:map_parinfer_sexp('<o', 'sexp_raise_element')
  call s:map_parinfer_sexp('>O', 'sexp_splice_list')
  call s:map_parinfer_sexp('>o', 'sexp_convolute')
endfunction

augroup parinfer_sexp
  autocmd!
  execute 'autocmd FileType' get(g:, 'sexp_filetypes', 'lisp,scheme,clojure') 'call s:sexp_mappings()'
  augroup END
augroup END

" Plugins {{{1
call plug#begin("~/.vim/plugged")
  " I like to specify full url of the plugin, because one can then press `gx` to open
  " the plugin home page in a web browser.

  " Defaults everyone can agree on
  Plug 'https://github.com/tpope/vim-sensible.git'

  " Syntax highlighting theme
  Plug 'https://github.com/ghifarit53/tokyonight-vim.git'
  Plug 'https://github.com/dracula/vim.git', { 'name': 'dracula' }
  " Plug 'https://github.com/haishanh/night-owl.vim.git'
  " Plug 'https://github.com/ntk148v/vim-horizon.git'
  " Plug 'https://github.com/arcticicestudio/nord-vim.git'
  " Plug 'https://github.com/drewtempelmeyer/palenight.vim.git'
  " Plug 'https://github.com/joshdick/onedark.vim.git'
  " Plug 'https://github.com/mhartington/oceanic-next.git'
  " Plug 'https://github.com/jacoborus/tender.vim.git'
  " Plug 'https://github.com/challenger-deep-theme/vim.git', { 'as': 'challenger-deep' }
  " Plug 'https://github.com/tomasiser/vim-code-dark.git'
  " Plug 'https://github.com/tomasr/molokai.git'

  " Light themes
  Plug 'https://github.com/sonph/onehalf.git', { 'rtp': 'vim' }
  Plug 'https://github.com/sainnhe/edge.git' " could use a bit more contrast otherwise pretty good
  Plug 'chiendo97/intellij.vim'
  Plug 'mvpopuk/inspired-github.vim'
  Plug 'Mofiqul/adwaita.nvim'
  Plug 'https://github.com/projekt0n/github-nvim-theme.git'
  " Plug 'https://github.com/NLKNguyen/papercolor-theme.git'
  " Plug 'Mofiqul/vscode.nvim'
  " Plug 'liuchengxu/space-vim-theme'
  " Plug 'https://github.com/cormacrelf/vim-colors-github.git'
  " Plug 'https://github.com/rakr/vim-one.git'
  " Plug 'https://github.com/ayu-theme/ayu-vim.git'
  " Plug 'https://github.com/reedes/vim-colors-pencil.git'
  " Plug 'https://github.com/arzg/vim-colors-xcode.git'
  " Plug 'https://github.com/axvr/photon.vim.git'
  " Plug 'https://github.com/jsit/toast.vim.git'
  " Plug 'https://github.com/kkga/vim-envy.git'
  " Plug 'chriskempson/tomorrow-theme'


  " Treesitter based - Dark and light themes
  " Plug 'Th3Whit3Wolf/one-nvim'
  " Plug 'lourenci/github-colors'
  " Plug 'marko-cerovac/material.nvim'
  Plug 'https://github.com/RRethy/nvim-base16.git'

  " Show colors for hex values
  Plug 'norcalli/nvim-colorizer.lua'

  " File tree sidebar with icons
  Plug 'https://github.com/scrooloose/nerdtree.git', { 'on': ['NERDTreeToggle', 'NERDTreeFind'] }
  Plug 'https://github.com/ryanoasis/vim-devicons.git', { 'on': ['NERDTreeToggle', 'NERDTreeFind'] }
  Plug 'https://github.com/tiagofumo/vim-nerdtree-syntax-highlight.git', { 'on': ['NERDTreeToggle', 'NERDTreeFind'] }

  " Alternative tree plugin in lua
  " Plug 'kyazdani42/nvim-web-devicons' " for file icons
  " Plug 'kyazdani42/nvim-tree.lua'

  " Another tree plugin
  Plug 'nvim-lua/plenary.nvim'
  Plug 'kyazdani42/nvim-web-devicons'
  Plug 'MunifTanjim/nui.nvim'
  Plug 'nvim-neo-tree/neo-tree.nvim'

  " Close buffers inteligently
  Plug 'https://github.com/mhinz/vim-sayonara.git', { 'on': 'Sayonara' }

  " Open file under cursor with gf relative to current file path
  Plug 'https://github.com/kkoomen/gfi.vim.git'

  " Fuzzy file serch
  Plug 'https://github.com/junegunn/fzf.git', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'https://github.com/junegunn/fzf.vim.git'

  " Lua-based fuzzy finder
  Plug 'nvim-lua/popup.nvim'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'

  " Auto completion
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-path'
  Plug 'hrsh7th/cmp-nvim-lua'
  Plug 'hrsh7th/nvim-cmp'
  " adds vscode-like pictograms to neovim built-in lsp
  Plug 'https://github.com/onsails/lspkind-nvim.git'

  " .editorconfig support
  Plug 'https://github.com/editorconfig/editorconfig-vim.git'
  " Heuristically set buffer options
  Plug 'https://github.com/tpope/vim-sleuth.git'

  " Faster horizontal screen navigation with f, t, F, T
  Plug 'https://github.com/unblevable/quick-scope.git'

  " Utilitity to surround text, alternative to vim-surround
  " Add sa{motion/textobject}{addition}
  " Delete sd{deletion} sdb searches a set of surrounding automatically.
  " Replace sr{deletion}{addition}
  Plug 'machakann/vim-sandwich'

  " Multiple cursors
  Plug 'mg979/vim-visual-multi', {'branch': 'master'}

  Plug 'terryma/vim-expand-region'

  " Toggling comments
  " Plug 'https://github.com/preservim/nerdcommenter.git'
  Plug 'numToStr/Comment.nvim'

  " Git show changes in gutter
  Plug 'https://github.com/mhinz/vim-signify.git'

  " Floating terminal, using it to run lazygit
  Plug 'numtostr/FTerm.nvim'
  " Git utilities, mostly using :GBrowse
  Plug 'https://github.com/tpope/vim-fugitive'
  " Add support for :GBrowse command from fugitive to work with github
  Plug 'https://github.com/tpope/vim-rhubarb.git'


  " Spacemacs-like menu
  Plug 'folke/which-key.nvim'

  " Dressing for improved selection UI that uses telescope
  Plug 'stevearc/dressing.nvim'
  Plug 'mrjones2014/legendary.nvim'

  " Language client
  Plug 'https://github.com/Olical/conjure.git', { 'for': 'clojure' }

  Plug 'https://github.com/eraserhd/parinfer-rust.git', { 'for': 'clojure', 'do': 'nix-shell --run \"cargo build --release \"' }

  " Structural editing of s-expressions ala paredit - barfing, slurping, etc.
  " Plug 'guns/vim-sexp'
  " Use snoe's fork which includes improvements to preserve cursor position and recursive capture.
  " https://github.com/guns/vim-sexp/pull/12
  " https://github.com/guns/vim-sexp/pull/15
  Plug 'snoe/vim-sexp', { 'commit': '4161f5c01504b77ab63f2957b943fca0c6e12e83' }
  Plug 'tpope/vim-repeat'
  " Plug 'tpope/vim-sexp-mappings-for-regular-people'

  Plug 'neovim/nvim-lspconfig'

  " Syntax highlighting for many languages, lazily loaded
  " Polyglot provides :Toc command for markdown, otherwise can remove it since
  " treesitter is now a thing.
  " Also seems to provide sections for markdown, so that ]] and [[ work to
  " jump to next / prev sections.
  " Plug 'https://github.com/sheerun/vim-polyglot.git'

  " Syntax highlighting based on treesitter
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update

  " Display treesitter parser tree, open with :TSPlaygroundToggle
  Plug 'nvim-treesitter/playground', { 'on': 'TSPlaygroundToggle' }

  " A tree like view for symbols in Neovim using the Language Server Protocol
  Plug 'https://github.com/simrat39/symbols-outline.nvim.git'

  " Plug 'https://github.com/shushcat/vim-minimd.git'

  " Plug 'https://github.com/plasticboy/vim-markdown.git'
  " Plug 'https://github.com/masukomi/vim-markdown-folding.git'

  " For generating markdown Table of Contents
  Plug 'mzlogin/vim-markdown-toc'

  " Markdown distraction free writing
  Plug 'https://github.com/junegunn/goyo.vim.git', { 'for': 'markdown' }
  " Markdown preview
  Plug 'https://github.com/iamcco/markdown-preview.nvim.git', { 'for': 'markdown', 'do': 'cd app && npm install' }

  " -- Experimental {{{1

  " Scrollbar with useful information like error/warning diagnostics
  Plug 'petertriho/nvim-scrollbar'

  " Better quickfix window - good for lsp references list with preview
  Plug 'kevinhwang91/nvim-bqf'

  " Lists open buffers in a top bar
  Plug 'akinsho/nvim-bufferline.lua'

  " Plug 'kyazdani42/nvim-web-devicons'
  " Plug 'romgrk/barbar.nvim'

  " Show list of issues from lsp for fixing
  Plug 'kyazdani42/nvim-web-devicons'
  Plug 'folke/trouble.nvim'

  " Show floating parts of a buffer
  Plug 'hoschi/yode-nvim'

  " Smooth scrolling for window movement commands
  " like <C-u>, <C-d>, <C-b>, <C-f>, <C-y>, <C-e>, zt, zz, zb.
  " Plug 'karb94/neoscroll.nvim'

  " List projects and jump to them via Telescope
  Plug 'ahmedkhalf/project.nvim'


call plug#end()


" Experimental {{{1

lua << EOF

require("trouble").setup {}


EOF


" -- nvim-scrollbar {{{1
lua require('scrollbar').setup()

" -- neoscroll.nvim {{{1
" lua require('neoscroll').setup()

" -- nvim-bqf {{{1

" Better quickfix window - good for lsp references list with preview
lua require('bqf').setup()

" -- yode-nvim {{{1
lua require('yode-nvim').setup({})
map <Leader>yc :YodeCreateSeditorFloating<CR>
map <Leader>yr :YodeCreateSeditorReplace<CR>
" these commands fall back to overwritten keys when cursor is in split window
map <C-W>r :YodeLayoutShiftWinDown<CR>
map <C-W>R :YodeLayoutShiftWinUp<CR>
map <C-W>J :YodeLayoutShiftWinBottom<CR>
map <C-W>K :YodeLayoutShiftWinTop<CR>
" at the moment this is needed to have no gap for floating windows
set showtabline=2




" General settings {{{1
if has('mouse')
  set mouse=a
endif
set guicursor+=a:blinkon100  " blinking cursor to get more comfy

set number  " Show line numbers
set scrolloff=3             " number of screen lines to show around the cursor
" Smart case sensitivity handling for / searches
set ignorecase smartcase

" Show search and replace subsctitions incrementally (Neovim only)
set inccommand=nosplit

" Always use the clipboard for ALL operations
" set clipboard+=unnamedplus


" paste with ctrl+v - clashes with visual block mode
" nnoremap <C-V> "+gP
" <C-G>u is to break undo sequence when pasting so that undo will undo the
" paste but keeps previously typed text (:help i_CTRL-G_u)
" `] is to jump to mark after pasted text, then switch back to insert mode
" Buggy : When pasting at the beginning of line it pastes after first
" character. I guess make it work properly we would need to check if we are
" at the begging and do P otherwise p.
inoremap <C-v> <C-g>u<esc>"+p`]a
" copy with ctrl+c, make primary selection and clipboard content the same
" by coping first to primary selection, then set clipboard to that.
vnoremap <C-c> "*y :let @+=@*<cr>
" cut with ctrl x
vnoremap <C-x> "*x :let @+=@*<cr>

" highlight yanked area, useful as a feedback what text got yanked
augroup highlight_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank { higroup="IncSearch", timeout=500 }
augroup END

" Save file with ctrl+s out of habit
nnoremap <C-s> :w<CR>
" <C-G>u to break undo sequence with save point
" experiment - also go to normal mode after save with <esc>
inoremap <C-s> <C-G>u<Cmd>:w<CR><esc>
vnoremap <C-s> <Cmd>:w<CR>

" Split to right and bottom
set splitright splitbelow

" soft wrap lines
set wrap
" do not break in the middle of a word
set linebreak nolist
" Indent wrapped lines
set breakindent breakindentopt=min:40

" show a vertical column at 80 characters
set colorcolumn=80
" set colorcolumn=80,100

" Command :Wrap to turn on soft wrapping
command! -nargs=* Wrap set wrap linebreak nolist

" open help vertically
command! -nargs=* -complete=help Help vertical belowright help <args>
autocmd FileType help wincmd L

" Set sensible tab-completion for command mode: complete longest string and
" show vertical menu, press tab again to cycle through menu items
set wildmode=longest:full,full
" Case-insensitive command lookup
set wildignorecase

" Re-read files when changed externally (will not work when current file gets
" changed by a background process without leaving vim)
" will probably get improved in Nvim 0.5 - :help file-change-detect (:help watch-file).
set autoread
augroup autoread
  autocmd!
  autocmd FocusGained *
    \  checktime
    " \| stopinsert

  " When entering buffer switch to normal mode, this is useful when being in
  " insert mode, alt-tabbing to another app and the getting back
  " Has disadvantage that input via rofi cannot be done, so perhaps don't
  " include it by default.

  " consider hooking it also to BufEnter for inter-vim navigation
augroup END

" Automatically set terminal title: directory - file.ext - NVIM
augroup autotitle
  autocmd!
  autocmd BufEnter * let &titlestring = fnamemodify(getcwd(), ':t') . " - " . expand("%:t") . " - NVIM"
augroup END
set title

" Source the nvim config file after saving it
" After reloading folds are reset to expr for treesitter, so change it back to marker.
autocmd! BufWritePost init.vim
  \ source $MYVIMRC
  \| setlocal foldmethod=marker

" Window and buffer management {{{1

" TAB in general mode will move to next window
nnoremap <silent> <TAB> :wincmd w<CR>
" SHIFT-TAB will go back
nnoremap <silent> <S-TAB> :wincmd W<CR>

" TAB in general mode will move to next buffer
"nnoremap <silent> <TAB> :bnext<CR>
" SHIFT-TAB will go back
"nnoremap <silent> <S-TAB> :bprevious<CR>

" Delete (close) buffer, keep window, saner :bdelete
nnoremap <leader>d :Sayonara!<CR>
" Quit window, saner :quit
nnoremap <leader>q :Sayonara<CR>

" -- bufferline {{{1
" Experimental: Show list of buffers as tabs
lua << EOF
require("bufferline").setup{}
EOF

" Movement {{{1

" Save on need to hold shift for commands for convenience (conflicts with
" motion repeat)
" nnoremap ; :

" Move up and down on long wrapped lines
nnoremap k gk
nnoremap j gj
nnoremap <Up> gk
nnoremap <Down> gj
inoremap <Up> <C-o>gk
inoremap <Down> <C-o>gj
" nnoremap <silent> ^ g^
" nnoremap <silent> $ g$

" Convenient movements back and forth
" https://ddrscott.github.io/blog/2016/vim-toggle-movement/
function! ToggleMovement(firstOp, thenOp)
  let pos = getpos('.')
  let c = v:count > 0 ? v:count : ''
  execute "normal! " . c . a:firstOp
  if pos == getpos('.')
    execute "normal! " . c . a:thenOp
  endif
endfunction
" 0 is more reachable, make it behave like ^ to go to first non-whitespace on
" the line. Pres 0 again to go to the beginning.
nnoremap <silent> 0 :call ToggleMovement('^', '0')<CR>
" G goes to beginning, pressing G again goes to the end
nnoremap <silent> G :call ToggleMovement('G', 'gg')<CR>
" nnoremap <silent> gg :call ToggleMovement('gg', 'G')<CR>

" Trigger a highlight with quuick scope in the appropriate direction when pressing these keys:
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

" Editing {{{1

" maintain visual selection after un/indenting with > and <
vmap < <gv
vmap > >gv
" unindent with shift-tab for insert mode
inoremap <S-Tab> <C-d>
vmap <S-Tab> <gv
" unindent with shift-tab for command mode
" nnoremap <S-Tab> <<
vmap <Tab> >gv


" Clear search highlighting on escape in normal mode (press esc twice to make
" it disappear faster)
nnoremap <silent> <esc> :nohlsearch<return><esc>
nnoremap <esc>^[ <esc>^[
" Replace all is aliased to S.
nnoremap S :%s//g<Left><Left>
" Search visually selected text with // https://vim.fandom.com/wiki/Search_for_visually_selected_text
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>

" Make gf create a new file if it not exists
:map gf :e <cfile><CR>

" -- Comment.nvim {{{1
" Add spaces after comment delimiters by default (nerdcommenter)
" let g:NERDSpaceDelims = 1
" Toggle comments with ctrl+/
"nmap <C-_>   <Plug>NERDCommenterToggle
"vmap <C-_>   <Plug>NERDCommenterToggle<CR>gv

lua require('Comment').setup()
" nnoremap <silent> <C-_>  :lua require('Comment').toggle()<CR>
" vnoremap <silent> <C-_>  <cmd>:lua require('Comment').toggle()<CR>gv
nmap <silent> <C-_>  gcc
vmap <silent> <C-_>  gcgv

" ====


" Theme / Colorscheme {{{1
if has("termguicolors")
  set termguicolors
endif
syntax enable

" Set colorscheme only once so that manually switch colorscheme does not get
" overwritten after config hot-reload.
if !get(g:, 'initial_colorcheme_selected')
  " Browse through available themes with :Telescope colorscheme
  let g:initial_colorcheme_selected = 1

  set background=dark " for the dark version
  colorscheme tokyonight
  " colorscheme base16-zenburn

  " === light themes

  " set background=light
  " colorscheme adwaita
  let g:adwaita_mode = "light"

  " colorscheme intellij
  " colorscheme onehalflight

  " colorscheme inspired-github
  " colorscheme github_light

  " colorscheme one-nvim
  " colorscheme edge
  " colorscheme github-colors

  " colorscheme base16-cupertino
  " colorscheme base16-edge-light
  " colorscheme base16-github
  " colorscheme base16-google-light
  " colorscheme base16-one-light
  " colorscheme base16-unikitty-light
endif


" Code lens is an information line from LSP like number of references or tests
highlight link LspCodeLens Comment
" highlight link LspCodeLensSeparator Comment

" Provides :SyntaxQuery command to print syntax group for a location under
" cursor to debug syntax highlighting
function! s:syntax_query() abort
  for id in synstack(line("."), col("."))
    echo synIDattr(id, "name")
  endfor
endfunction
command! SyntaxQuery call s:syntax_query()

" Because colorscheme can be only set globally, there is autocmd to set
" default theme back in when using override for specific lang (e.g. markdown)
" augroup lang_all
  " autocmd!
  " autocmd BufEnter * colorscheme tokyonight
  " " autocmd! FileType * colorscheme tokyonight
" augroup END

" -- colorizer {{{1
" Show colors for hex values
" names=false to not highlight color names like Green
lua require'colorizer'.setup(nil, {names=false})


" Project management {{{1

lua << EOF
  require("project_nvim").setup {
    -- defaults seem to be overall pretty good

    -- don't manually change directory - it seems to get clojure-lsp confused and makes it spinning
    manual_mode = true,

    -- Don't calculate root dir on specific directories
    exclude_dirs = { "~/Dropbox/*" },

    -- show a message when project.nvim changes directory
    silent_chdir = false,
  }

  -- TODO bind :Telescope projects to some shortcut
  require('telescope').load_extension('projects')
EOF

" File Explorer {{{1

" -- NERDTree {{{1
let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeIgnore = []
let g:NERDTreeStatusline = ''
let g:NERDTreeWinPos = 'right'  " show file tree on the right
augroup nerdtree
  autocmd!
  " Automaticaly close nvim if NERDTree is only thing left open
  autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
augroup END
" Toggle
nnoremap <silent> <leader>b :NERDTreeToggle<CR>
nnoremap <silent> <C-bslash> :NERDTreeFind<CR>

" -- neo-tree {{{1

" Shows opened buffers in a tree, maybe bind it to some shortcut
" :Neotree source=buffers

lua << END

vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

require("neo-tree").setup({
  default_component_configs = {
    indent = {
      indent_size = 1,
      padding = 0, -- extra padding on left hand side
      -- indent guides
      with_markers = false,
    },
  },
  window = {
    position = "right",
    width = 30,
  },
  filesystem = {
    filtered_items = {
      -- show hidden files like dotfiles and git ignored
      visible = true,
    },
  },
})
END

nnoremap <silent> <leader>b :Neotree toggle=true<CR>
nnoremap <silent> <C-bslash> :Neotree reveal=true<CR>


" -- nvimtree {{{1
let g:nvim_tree_side = 'right'
" Automatically close if the tree is the last window
" let g:nvim_tree_auto_close = 1
" let g:nvim_tree_show_icons = {
    " \ 'git': 1,
    " \ 'folders': 1,
    " \ 'files': 1,
    " \ 'folder_arrows': 1,
    " \ }

" Show icons for unknown file types
let g:nvim_tree_icons = {
    \ 'default': '',
    \ 'symlink': '',
    \ }

" g? for help
" nnoremap <silent> <leader>b :NvimTreeToggle<CR>
" nnoremap <silent> <C-bslash> :NvimTreeFindFile<CR>




" Fuzzy file search {{{1

" -- fzf {{{1
if executable('rg')
  " .gitignore is applied automatically, --hidden is to search in files
  " starting with a dot, but then we need the --glob parameter to exclude contents of .git
  let $FZF_DEFAULT_COMMAND = 'rg --files --follow --hidden --glob "!.git/*"'

  " user ripgrep for :grep
  set grepprg=rg\ --vimgrep\ --smart-case\ --follow

  " do not match file name when searching in files
  let spec = {'options': '--delimiter : --nth 4..'}
  " let spec = {'options': ['--delimiter :', '--nth 4..']}
  " command! -bang -nargs=* RgFind call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --color=always --smart-case --follow --hidden --glob "!.git/*" '.shellescape(<q-args>), 1, fzf#vim#with_preview(spec), <bang>0)


  function! RipgrepFzf(query, fullscreen)
    let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case --fixed-strings --follow --hidden --glob "!.git/*" -- %s || true'
    let initial_command = printf(command_fmt, shellescape(a:query))
    let reload_command = printf(command_fmt, '{q}')
    let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
    call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
  endfunction

  command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

  command! -bang -nargs=* RgGrep call fzf#vim#grep('rg --column --line-number --no-heading --color=always --smart-case --follow --hidden --glob "!.git/*" '.shellescape(<q-args>), 1, fzf#vim#with_preview(spec), <bang>0)

  " command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)
  " command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".(<q-args>), 1, {'options': '--delimiter : --nth 4..'}, <bang>0)
endif

" Preview window on the upper side of the window with 40% height,
" hidden by default, ctrl-/ to toggle
let g:fzf_preview_window = ['up:40%:hidden', 'ctrl-/']

let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit'
  \}

" -- Telescope {{{1
lua << END
require('telescope').setup({
  defaults = {
    -- Using vertical strategy because not having cut-off list entries is more
    -- important for narrower window size. TODO: explore flex sizing to switch to
    -- horizontal layout for wider window size.
    layout_strategy = "vertical",
    -- Default cycle scroll strategy is confusing, don't wraparound at the end.
    -- One can also use gg and G to jump to the other end.
    scroll_strategy = "limit",
    --layout_config = {
      -- vertical = { width = 0.5 }
      -- other layout configuration here
    --},
  },
  pickers = {
    colorscheme = {
      enable_preview = true,
    },
    lsp_document_symbols = {
      -- For document symbols (which is used also for markdown heading jumping)
      -- have the ascending sorting so that entries matcher order in the file
      sorting_strategy = "ascending",
      layout_strategy = "vertical",
      layout_config = {
        prompt_position = "top",
        mirror = true,
        preview_height = 0.3,
      },
    },
  },
})
END

nnoremap <C-p> :FZF<CR>
nnoremap <C-b> :Buffers<cr>
nnoremap <leader>fb :Buffers<cr>
nnoremap <leader>ff :Files<cr>
" find (grep) in files
" nnoremap <leader>fg :RgFind<cr>
nnoremap <leader>fg :RG<cr>
nnoremap <leader>fr :RgGrep<cr>
nnoremap <leader>fc :Commands<cr>
" nnoremap <silent> <Leader>fa :Find<CR>
" nnoremap <leader>fh :Helptags<cr>
" nnoremap <leader>fm :Maps<cr>
" nnoremap <leader>f: :History:<cr>
" nnoremap <leader>ft :Filetypes<cr>
" nnoremap <leader>fr :History<cr>
" nnoremap <leader>* :Rg <c-r><c-w><cr>
nnoremap <leader>fs :Telescope lsp_workspace_symbols<cr>
nnoremap <leader>fo :Telescope lsp_document_symbols<cr>

"" Split
noremap <Leader>h :<C-u>split<CR>
noremap <Leader>v :<C-u>vsplit<CR>

" use ctrl  +hjkl to move between split/vsplit panels
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
inoremap <C-h> <C-\><C-N><C-w>h
inoremap <C-j> <C-\><C-N><C-w>j
inoremap <C-k> <C-\><C-N><C-w>k
inoremap <C-l> <C-\><C-N><C-w>l
" tnoremap <C-h> <C-\><C-n><C-w>h
" tnoremap <C-j> <C-\><C-n><C-w>j
" tnoremap <C-k> <C-\><C-n><C-w>k
" tnoremap <C-l> <C-\><C-n><C-w>l
" tnoremap <Esc> <C-\><C-n>



" Auto completion {{{1

" -- nvim-cmp {{{1
" nvim-cmp needs this
set completeopt=menu,menuone,noselect

lua <<EOF
  -- Setup nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    mapping = {
      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.close(),
      -- Changed default for enter to behave as newline if no item is selected
      ['<CR>'] = cmp.mapping.confirm({ select = false }),
      -- Read :help ins-completion but stayed a lowly tab-completer
      ['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's' }),
    },
    sources = {
      { name = 'nvim_lsp' },
      { name = 'nvim_lua' },
      { name = 'path' },
      { name = 'buffer', keyword_length = 5 },
    },
    formatting = {
      -- Show icons for completion items
      format = require("lspkind").cmp_format {
        with_text = true,
        menu = {
          buffer = "[Buf]",
          nvim_lsp = "[LSP]",
          nvim_lua = "[Lua]",
        },
      },
    },
  })
EOF

" Language configs {{{1

" -- treesitter {{{1

lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  -- ignore_install = { "javascript" }, -- List of parsers to ignore installing
  highlight = {
    enable = true,              -- false will disable the whole extension
    -- disable = { "c", "rust" },  -- list of language that will be disabled
  },
}
EOF

" Use folds based on treesitter parsing
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()

" Following is to open all folds by default, they can be closed with zM if necessary
" augroup open_folds
  " autocmd! BufWinEnter * silent! :%foldopen!
" augroup END

" https://stackoverflow.com/questions/8316139/how-to-set-the-default-to-unfolded-when-you-open-a-file
" Have folds opened by default
set nofoldenable

" -- conjure {{{1
" Clojure

augroup lang_clojure
  autocmd!
  " set nolinebreak because line break at words boundary bugs out with parinfer
  autocmd FileType clojure
    \ nnoremap <LocalLeader>s :ConjureShadowSelect
    \| nnoremap <LocalLeader>el :ConjureLogSplit<cr>
    \| nnoremap <LocalLeader>ev :ConjureLogVSplit<cr>
    \| set nolinebreak
augroup END

" -- lspconfig {{{1

" bind it outside of on_attach to use for debugging
nnoremap <space>ll :LspInfo<cr>
nnoremap <space>lL :e ~/.cache/nvim/lsp.log<cr>

" Useful for the efm-markdown wrapper
nnoremap <space>ls :Telescope lsp_document_symbols<cr>

lua << EOF

-- symbols-outline.nvim
vim.g.symbols_outline = {
  keymaps = {
    -- besides enter also mouse double-click to go to location
    goto_location = { "<Cr>", "<2-LeftMouse>" },
  },
}

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  -- buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)

  buf_set_keymap('n', '<leader>la', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', '<leader>ld', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', '<leader>ln', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<leader>lr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<leader>li', '<cmd>lua vim.lsp.buf.implementations()<CR>', opts)
  buf_set_keymap('n', '<leader>lh', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<leader>lq', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)

  -- buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  -- buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  -- buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)

  -- (nvim.buf_set_keymap bufnr :n :<leader>ld "<Cmd>lua vim.lsp.buf.declaration()<CR>" {:noremap true})
  -- (nvim.buf_set_keymap bufnr :n :<leader>lt "<cmd>lua vim.lsp.buf.type_definition()<CR>" {:noremap true})
  -- (nvim.buf_set_keymap bufnr :n :<leader>le "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>" {:noremap true})
  -- (nvim.buf_set_keymap bufnr :n :<leader>lq "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>" {:noremap true})
  -- (nvim.buf_set_keymap bufnr :n :<leader>lf "<cmd>lua vim.lsp.buf.formatting()<CR>" {:noremap true})
  -- (nvim.buf_set_keymap bufnr :n :<leader>lj "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>" {:noremap true})
  -- (nvim.buf_set_keymap bufnr :n :<leader>lk "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>" {:noremap true})
  -- ;telescope
  -- (nvim.buf_set_keymap bufnr :n :<leader>la ":lua require('telescope.builtin').lsp_code_actions(require('telescope.themes').get_cursor())<cr>" {:noremap true})
  -- (nvim.buf_set_keymap bufnr :v :<leader>la ":lua require('telescope.builtin').lsp_range_code_actions(require('telescope.themes').get_cursor())<cr>" {:noremap true})
  -- (nvim.buf_set_keymap bufnr :n :<leader>lw ":lua require('telescope.builtin').lsp_workspace_diagnostics()<cr>" {:noremap true})
  -- (nvim.buf_set_keymap bufnr :n :<leader>li ":lua require('telescope.builtin').lsp_implementations()<cr>" {:noremap true})))]

  buf_set_keymap('n', '<localleader>o', '<cmd>SymbolsOutline<CR>', opts)
  -- nnoremap <space>lo :SymbolsOutline<cr>

  -- Display code lenses which show for example number of references and tests of a funtion

  if client.resolved_capabilities.code_lens then
    vim.cmd [[
      augroup lsp_codelens
        autocmd! * <buffer>
        autocmd BufWritePost,CursorHold,CursorHoldI <buffer> lua vim.lsp.codelens.refresh()
      augroup END
    ]]
  end

  -- Maybe change lower the value (default 4s) like set updatetime=1000
  -- Auto highlight symbols under cursor and its references
  if client.resolved_capabilities.document_highlight then
    vim.cmd [[
      augroup lsp_highlight
        autocmd! * <buffer>
        autocmd CursorHold  <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]]
  end

  -- format on save
  -- don't auto format Liz sources because the formatter messes them up
  local is_liz_source = vim.fn.bufname():find('.liz$');
  if not is_liz_source and client.resolved_capabilities.document_formatting then
    vim.cmd [[
      augroup lsp_format
         autocmd! BufWritePre <buffer> lua vim.lsp.buf.formatting_sync(nil, 1000)
      augroup END
    ]]
  end

end

local nvim_lsp = require('lspconfig')
local util = require 'lspconfig/util'
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

-- auto-lsp {{{1

vim.opt.runtimepath:append("~/code/nvim-auto-lsp")
require("plenary.reload").reload_module("auto-lsp")
local auto_lsp = require "auto-lsp"

require "auto-lsp".setup{
  excluded_servers = {
    -- following produce noise when servers not installed:
    "tailwindcss", "vimls",
    -- prefer tsserver
    "rome", "ember", "denols",
    -- ghcide and hie seem to be deprecated in favor of haskell-language-server (hls)
    "ghcide", "hie",
    -- preferring rls
    "rust_analyzer",
    -- to avoid interference with markdown files
    "zeta_note", "zk",
    -- prefer clangd
    "ccls",

    "flux-lsp",

    "ngserver",

    -- configured manually due to having issues installing it via nix
    "clojure_lsp" ,
  },
  default_config = {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    },
    capabilities = capabilities,
  },
  configs = {
    -- clojure_lsp = { }
    -- https://github.com/bash-lsp/bash-language-server/issues/104#issuecomment-848052436
    efm = {
      filetypes = { "markdown", "sh",  "vim" },
      on_attach = function(client, bufnr)
        local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
        local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

        -- Mappings.
        local opts = { noremap=true, silent=true }

        buf_set_keymap('n', '<localleader>o', '<cmd>SymbolsOutline<CR>', opts)
      end,
      flags = {
        debounce_text_changes = 150,
      },
      init_options = {
        documentFormatting = true,
        documentSymbol = true,
        hover = true,
      },
      settings = {
          rootMarkers = {".git/"},
          languages = {
              markdown = {
                { symbolCommand = 'markdown-symbols' },
                -- add dummy hover command which symbols-outline plugin expects
                { hoverCommand = 'echo' },
              },
              sh = {
                {lintCommand = 'shellcheck -f gcc -x',
                 lintSource = 'shellcheck',
                 lintFormats= {'%f:%l:%c: %trror: %m', '%f:%l:%c: %tarning: %m', '%f:%l:%c: %tote: %m'}}
              },
              vim = {
                { symbolCommand = 'vim-marker-symbols' },
                -- add dummy hover command which symbols-outline plugin expects
                { hoverCommand = 'echo' },
              },
          },
      },
      capabilities = capabilities,
    },
    sumneko_lua = {
      cmd = {"lua-language-server"},
      on_attach = on_attach,
      flags = {
        debounce_text_changes = 150,
      },
      capabilities = capabilities,
    },
    dartls = {
      cmd = {"dart", "language-server"},
    }
  },
}


nvim_lsp.clojure_lsp.setup {
  -- Override the defaut config to set root in the top-level of a monorepo
  root_dir = util.root_pattern(".git"),
  on_attach = on_attach,
  flags = {
    debounce_text_changes = 150,
  },
  capabilities = capabilities,
}

--[[
vim.lsp.set_log_level("debug")
]]




EOF


" autocmd! QuickFixCmdPost * wincmd p

" -- Markdown {{{1

" Plugin with markdown folding is built-in, just enable folding support
let g:markdown_folding = 1

" Turn spellcheck on for markdown files
" Look how to do it better with :help ftplugin
augroup lang_markdown
  " autocmd! BufNewFile,BufRead *.md setlocal spell
  " autocmd! FileType markdown
  " Don't break lines in the middle of a word
  autocmd!
  " autocmd BufEnter *.md
    " \ colorscheme edge
    " \| setlocal background=light


  " Have all folds expanded by default
  " Don't open autocomplete buffer by default
  autocmd FileType markdown
    \  setlocal linebreak
    \| lua require('cmp').setup.buffer { enabled = false }
    " \| setlocal foldmethod=expr
    " \| setlocal foldexpr=StackedMarkdownFolds()
    " \| normal zR

    " \ setlocal nonumber
    " \|  setlocal spell " spelling error highlights are too distracting, it
    " would be good to find out how to uderline only and then enable it
    " automatically again
augroup END

" Don't close current markdown preview window when switching away from buffer
let g:mkdp_auto_close = 0

" TODO: Figure out how to bind these via autocmd
lua << EOF
require("which-key").register({
  ["<leader>m"] = { "+markdown" },
  ["<leader>mp"] = { "<cmd>MarkdownPreview<cr>", "preview" },
  ["<leader>mt"] = { "<cmd>GenTocGFM<cr>", "generate TOC" },
})
EOF


" -- Liz {{{1
augroup lang_liz
  autocmd! BufNewFile,BufRead *.liz
    \  setlocal syntax=clojure
    \| setlocal filetype=clojure
augroup END

" -- TypeScript {{{1

augroup lang_typescript
  autocmd!
  " Dim type annotations as comments for better code readability
  " TSParameter - but that also dims parameters for regular functions
  autocmd FileType typescript
    \ highlight! link TSType Comment
augroup END

" Space menu {{{1

" -- Git {{{1

" Open current line on Github
" V is to select current line otherwise only the file is opened without location
nnoremap <leader>gh V :GBrowse<cr><esc>
" Make :GBrowse command from fugitive work
" By default it depends in netrw, which is disabled in neovim
augroup ft_fugitive
    au!
    au User Fugitive command! -bar -nargs=1 Browse silent! exe '!xdg-open' shellescape(<q-args>, 1)
augroup END

lua << EOF

local lazygit = require('FTerm'):new({ cmd = 'lazygit', dimensions  = { height = 1, width = 1 } })

function _G.__fterm_lazygit()
    lazygit:toggle()
end

EOF

" Open lazygit in a floating window
" nnoremap <silent> <leader>gg :lua require('FTerm'):new({ cmd = 'lazygit', dimensions  = { height = 1, width = 1 } }):open()<cr>
nnoremap <silent> <leader>gg :lua __fterm_lazygit()<cr>

nnoremap <silent> <leader>gb = :Telescope git_branches<cr>
nnoremap <silent> <leader>gl = :Git blame<cr>

" -- legendary.nvim {{{1

map <leader><leader> :Legendary<CR>
" :Legendary " search keymaps, commands, and autocmds
" :Legendary keymaps " search keymaps
" :Legendary commands " search commands
" :Legendary autocmds " search autocmds
"
lua << EOF

-- `setup()` must be called before `require('which-key).register()`
require('legendary').setup()

require('legendary').bind_commands({
  { ':g/^\\s*$/d', description = 'Delete blank lines' },
  { ':! chmod +x %', description = 'Make current file executable' },
  { ':%bd|e#', description = 'Close other buffers' },
  { ':ConjureShadowSelect app', description = 'Conjure shadow select app' },
  { ':ConjureShadowSelect {name}', description = 'Conjure shadow select', unfinished = true },
  { ':ConjureConnect 48888', description = 'Conjure: Pitch Backend REPL' },
  { ':ConjureConnect 7888', description = 'Conjure: Pitch Frontend REPL' },
  { ':ConjureConnect 1667', description = 'Conjure: Babashka REPL' },
  -- Evaling alert to verify REPL is working and locate which browser provides runtime
  { ':ConjureEval (js/alert "Hello!")', description = 'Conjure eval alert' },
  { ':Telescope builtin', description = 'Telescope bultins' },

})

-- which-key.nvim {{{1

local wk = require("which-key")

wk.register({
  ["<leader>."] = { "<cmd>e $MYVIMRC<cr>", "open init" },
  ["<leader>l"] = { "+lsp" },
  ["gq"] = { "wrap text" },
  ["<leader>f"] = { "find" },
  ["<leader>g"] = { "git" },
  -- ["<leader>f"] = { name = "+file" },
  -- ["<leader>ff"] = { "<cmd>Telescope find_files<cr>", "Find File" },
  -- ["<leader>fr"] = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
  -- ["<leader>fn"] = { "<cmd>enew<cr>", "New File" },
})

wk.register({
  j = {
    name = "Jump",
    j = { "<cmd>:Buffers<cr>", "Buffers" },
    k = { "<cmd>:Neotree toggle=true<cr>", "File Tree: Toggle" },
    l = { "<cmd>:Neotree reveal=true<cr>", "File Tree: Reveal current" },
  },
}, { prefix = "<leader>" })

wk.register({
  r = { "<cmd>:set relativenumber!<cr>", "Toggle relative line numbers" },
}, { prefix = "<localleader>" })

EOF
