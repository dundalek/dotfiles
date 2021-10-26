" vim: foldmethod=marker
" Set our leader key to space. This needs to be set first before all plugins
" are loaded.
let g:mapleader = "\<space>"
let g:maplocalleader = ","

" Plugins expect POSIX shell which can cause problems when closh is used
set shell=/usr/bin/env\ bash
let $SHELL = '/bin/bash'

" let g:polyglot_disabled = ['markdown']

" Plugins {{{1
call plug#begin("~/.vim/plugged")
  " I like to specify full url of the plugin, because one can then press `gx` to open
  " the plugin home page in a web browser.


  " Experimental area

  " Lists open buffers in a top bar
  Plug 'akinsho/nvim-bufferline.lua'

  " Utilitity to surround text, alternative to vim-surround
  " Add sa{motion/textobject}{addition}
  " Delete sd{deletion} sdb searches a set of surrounding automatically.
  " Replace sr{deletion}{addition}
  Plug 'machakann/vim-sandwich'


  " Defaults everyone can agree on
  Plug 'https://github.com/tpope/vim-sensible.git'

  " Plug 'https://github.com/adelarsq/vim-matchit.git'

  Plug 'https://github.com/xolox/vim-misc.git'
  Plug 'https://github.com/xolox/vim-colorscheme-switcher.git' " F8 / Shiftt-F8 next/previous theme
  " Syntax highlighting theme
  Plug 'https://github.com/ghifarit53/tokyonight-vim.git'
  Plug 'https://github.com/dracula/vim.git'
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
  " Plug 'chiendo97/intellij.vim'
  " Plug 'chriskempson/tomorrow-theme'
  "
  Plug 'https://github.com/projekt0n/github-nvim-theme.git'

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
  Plug 'kyazdani42/nvim-web-devicons' " for file icons
  Plug 'kyazdani42/nvim-tree.lua'

  " Close buffers inteligently
  Plug 'https://github.com/mhinz/vim-sayonara.git', { 'on': 'Sayonara' }

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

  " Multiple cursors
  Plug 'mg979/vim-visual-multi', {'branch': 'master'}

  " Toggling comments
  Plug 'https://github.com/preservim/nerdcommenter.git'

  " Git show changes in gutter
  Plug 'https://github.com/mhinz/vim-signify.git'

  " Git utilities, mostly using :GBrowse
  Plug 'https://github.com/tpope/vim-fugitive'
  " Add support for :GBrowse command from fugitive to work with github
  Plug 'https://github.com/tpope/vim-rhubarb.git'


  " Spacemacs-like menu
  Plug 'folke/which-key.nvim'

  " Language client
  " Plug 'https://github.com/neoclide/coc.nvim.git', {'branch': 'release'}
  " let g:coc_global_extensions = ['coc-css', 'coc-html', 'coc-json', 'coc-prettier', 'coc-tsserver', 'coc-conjure']

  " Plug 'https://github.com/tpope/vim-fireplace.git', { 'for': 'clojure' }
  Plug 'https://github.com/Olical/conjure.git', { 'for': 'clojure' }
  Plug 'https://github.com/eraserhd/parinfer-rust.git', { 'for': 'clojure', 'do': 'nix-shell --run \"cargo build --release \"' }

  Plug 'neovim/nvim-lspconfig'

  " Syntax highlighting for many languages, lazily loaded
  " Polyglot provides :Toc command for markdown, otherwise can remove it since
  " treesitter is now a thing.
  " Also seems to provide sections for markdown, so that ]] and [[ work to
  " jump to next / prev sections.
  " Plug 'https://github.com/sheerun/vim-polyglot.git'

  " Syntax highlighting based on treesitter
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update


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
  " Plug 'https://github.com/tpope/vim-markdown.git'
call plug#end()





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
inoremap <C-V> <C-G>u<esc>"+p`]a
" copy with ctrl+c
vnoremap <C-C> "+y
" cut with ctrl x
vnoremap <C-X> "+x

" Save file with ctrl+s out of habit
nnoremap <C-s> :w<CR>
" <C-G>u to break undo sequence with save point
inoremap <C-s> <C-G>u<Cmd>:w<CR>
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

" Automatically set terminal title
augroup autoread
  autocmd!
  autocmd BufEnter * let &titlestring = fnamemodify(getcwd(), ':t') . " - " . expand("%:t") . " - NVIM"
augroup END
set title

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

" Add spaces after comment delimiters by default (nerdcommenter)
let g:NERDSpaceDelims = 1
" Toggle comments with ctrl+/
nmap <C-_>   <Plug>NERDCommenterToggle
vmap <C-_>   <Plug>NERDCommenterToggle<CR>gv

" Clear search highlighting on escape in normal mode (press esc twice to make
" it disappear faster)
nnoremap <silent> <esc> :nohlsearch<return><esc>
nnoremap <esc>^[ <esc>^[
" Replace all is aliased to S.
nnoremap S :%s//g<Left><Left>
" Search visually selected text with // https://vim.fandom.com/wiki/Search_for_visually_selected_text
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>

" Window and buffer management {{{1

" TAB in general mode will move to next window
nnoremap <silent> <TAB> :wincmd w<CR>
" SHIFT-TAB will go back
nnoremap <silent> <S-TAB> :wincmd W<CR>

" TAB in general mode will move to next buffer
"nnoremap <silent> <TAB> :bnext<CR>
" SHIFT-TAB will go back
"nnoremap <silent> <S-TAB> :bprevious<CR>

" Delete (close) buffer
nnoremap <leader>d :Sayonara<CR>
" Quit window
nnoremap <leader>q :quit<CR>

" Experimental: Show list of buffers as tabs
lua << EOF
require("bufferline").setup{}
EOF

" Theme {{{1
if has("termguicolors")
  set termguicolors
endif
syntax enable

set background=dark " for the dark version
colorscheme tokyonight

" set background=light " for the light version
" colorscheme onehalflight


" colorscheme one-nvim
" colorscheme edge
" colorscheme github-colors
" `
" colorscheme base16-cupertino
" colorscheme base16-edge-light
" colorscheme base16-github
" colorscheme base16-google-light
" colorscheme base16-one-light
" colorscheme base16-unikitty-light

" colorscheme base16-zenburn



" lua <<EOF
" require("github-theme").setup({
  " themeStyle = "light",
  " -- ... your github-theme config
" })
" EOF


" Because colorscheme can be only set globally, there is autocmd to set
" default theme back in when using override for specific lang (e.g. markdown)
" augroup lang_all
  " autocmd!
  " autocmd BufEnter * colorscheme tokyonight
  " " autocmd! FileType * colorscheme tokyonight
" augroup END

" Show colors for hex values
" names=false to not highlight color names like Green
lua require'colorizer'.setup(nil, {names=false})

" File Explorer {{{1
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

lua << END
require('telescope').setup({
  defaults = {
    layout_strategy = "vertical",

    --layout_config = {
      -- vertical = { width = 0.5 }
      -- other layout configuration here
    --},
    -- other defaults configuration here
  },
  -- other configuration values here
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

" Source the nvim config file after saving it
autocmd! BufWritePost init.vim source $MYVIMRC


" Auto completion {{{1

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
      ['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's' }),
    },
    sources = {
      { name = 'nvim_lsp' },
      { name = 'nvim_lua' },
      { name = 'buffer' },
      { name = 'path' },
    },
    formatting = {
      -- Show icons for completion items
      format = require("lspkind").cmp_format({with_text = true, menu = ({
          buffer = "[Buffer]",
          nvim_lsp = "[LSP]",
          nvim_lua = "[Lua]",
        })}),
    },
  })
EOF

" Language configs {{{1


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

" bind it outside of on_attach to use for debugging
nnoremap <space>ll :LspInfo<cr>
nnoremap <space>lL :e ~/.cache/nvim/lsp.log<cr>

lua << EOF

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

  -- format on save
  -- don't auto format Liz sources because the formatter messes them up
  local is_liz_source = vim.fn.bufname():find('.liz$');
  if not is_liz_source and client.resolved_capabilities.document_formatting then
        vim.cmd [[augroup lsp_format]]
        vim.cmd [[autocmd! BufWritePre <buffer> lua vim.lsp.buf.formatting_sync(nil, 1000)]]
        vim.cmd [[augroup END]]
  end

end



local nvim_lsp = require('lspconfig')
local util = require 'lspconfig/util'
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

nvim_lsp.clojure_lsp.setup{
  -- Override the defaut config to set root in the top-level of a monorepo
  root_dir = util.root_pattern(".git"),
  on_attach = on_attach,
  flags = {
    debounce_text_changes = 150,
  },
  capabilities = capabilities
}


local on_efm_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Mappings.
  local opts = { noremap=true, silent=true }

  buf_set_keymap('n', '<localleader>o', '<cmd>SymbolsOutline<CR>', opts)

end


-- https://github.com/bash-lsp/bash-language-server/issues/104#issuecomment-848052436
nvim_lsp.efm.setup{
  on_attach = on_efm_attach,
  flags = {
    debounce_text_changes = 150,
  },
  init_options = {documentFormatting = true, documentSymbol = true},
  filetypes = {"sh", "markdown"},
  settings = {
      rootMarkers = {".git/"},
      languages = {
          sh = {
            {lintCommand = 'shellcheck -f gcc -x',
             lintSource = 'shellcheck',
             lintFormats= {'%f:%l:%c: %trror: %m', '%f:%l:%c: %tarning: %m', '%f:%l:%c: %tote: %m'}}
          },
          markdown = {
            {symbolCommand = 'markdown-symbols'}
          }
      }
  }
}


local servers = { 'tsserver' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    },
    capabilities = capabilities,
  }
end


--[[
vim.lsp.set_log_level("debug")
]]




EOF


" autocmd! QuickFixCmdPost * wincmd p

" Markdown


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
  " Table of contents, for now o shortcut for Outline
  autocmd FileType markdown
    \  setlocal linebreak
    \| lua require('cmp').setup.buffer { enabled = false }
    " \| nnoremap <LocalLeader>o <Cmd>:Toc<CR>
    " \| setlocal foldmethod=expr
    " \| setlocal foldexpr=StackedMarkdownFolds()
    " \| normal zR

    " let g:markdown_folding = 1

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


" Liz
augroup lang_liz
  autocmd! BufNewFile,BufRead *.liz
    \  setlocal syntax=clojure
    \| setlocal filetype=clojure
augroup END

" Space menu {{{1
" Using which-key plugin


" Open current line on Github
" V is to select current line otherwise only the file is opened without location
nnoremap <space>gg V :GBrowse<cr><esc>
" Make :GBrowse command from fugitive work
" By default it depends in netrw, which is disabled in neovim
augroup ft_fugitive
    au!
    au User Fugitive command! -bar -nargs=1 Browse silent! exe '!xdg-open' shellescape(<q-args>, 1)
augroup END


lua << EOF

local wk = require("which-key")

wk.register({
  ["<leader>."] = { "<cmd>e $MYVIMRC<cr>", "open init" },
  ["<leader>l"] = { "+lsp" },
  ["gq"] = { "wrap text" },
  -- ["<leader>f"] = { name = "+file" },
  -- ["<leader>ff"] = { "<cmd>Telescope find_files<cr>", "Find File" },
  -- ["<leader>fr"] = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
  -- ["<leader>fn"] = { "<cmd>enew<cr>", "New File" },
})

EOF


" nnoremap <silent> <leader>      :<c-u>WhichKey '<Space>'<CR>
" nnoremap <silent> <localleader> :<c-u>WhichKey  ','<CR>

" " Hide status line while space menu is open
" autocmd! FileType which_key
" autocmd  FileType which_key set laststatus=0 noshowmode noruler
  " \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

" let g:which_key_timeout = 100

" let g:which_key_map =  {}

" let g:which_key_map['.'] = [ ':e $MYVIMRC', 'open init' ]



" " let g:which_key_map.l = {
  " " \ 'name' : '+lsp' ,
  " " \ 'r' : ['<cmd>lua vim.lsp.buf.references()<cr>', 'references'],
  " " \ 'g' : [':lua vim.lsp.buf.definition()', 'defition'],
  " " \ 'n' : [':lua vim.lsp.buf.rename()', 'rename'],
  " " \ 'i' : [':LspInfo<CR>', 'info'],
  " " \ }

" " Register which key map
" call which_key#register('<Space>', "g:which_key_map")



