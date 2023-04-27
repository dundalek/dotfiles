-- vim: foldmethod=marker
-- Press zM to close all folds to navigate the structure, zR to open all.
-- Press zj / zk to jump to next / previous section.

---- Global {{{1

-- Set our leader key to space. This needs to be set first before all plugins are loaded.
vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- Plugins expect POSIX shell which can cause problems when closh is used
vim.o.shell = '/usr/bin/bash'

-- Plugins {{{1

local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim',
    install_path })
end

require('packer').startup(function(use)
  -- I like to specify full url of the plugin, because one can then press `gx` to open
  -- the plugin home page in a web browser.

  -- Packer manages itself, otherwise it tries to clean itself when not specified
  use 'wbthomason/packer.nvim'

  -- Defaults everyone can agree on
  -- use 'https://github.com/tpope/vim-sensible'

  -- Syntax highlighting theme
  use { 'folke/tokyonight.nvim', config = function()
    require("tokyonight").setup({
      style = "night",
      styles = { keywords = { italic = false } }
    })
  end }
  use 'https://github.com/ayu-theme/ayu-vim.git'
  use 'https://github.com/mhartington/oceanic-next.git'
  -- use 'https://github.com/haishanh/night-owl.vim.git'
  -- use 'https://github.com/arcticicestudio/nord-vim.git'
  -- use 'https://github.com/drewtempelmeyer/palenight.vim.git'
  -- use 'https://github.com/joshdick/onedark.vim.git'
  -- use 'https://github.com/tomasiser/vim-code-dark.git'

  -- Light themes
  use { 'https://github.com/sonph/onehalf.git', rtp = 'vim' }
  use 'https://github.com/sainnhe/edge.git'
  use 'chiendo97/intellij.vim'
  use 'Mofiqul/adwaita.nvim'
  use 'mvpopuk/inspired-github.vim'
  use 'https://github.com/projekt0n/github-nvim-theme.git'
  use 'https://github.com/habamax/vim-sugarlily'

  -- Show colors for hex values
  use 'norcalli/nvim-colorizer.lua'

  -- Tree plugin
  use {
    'nvim-neo-tree/neo-tree.nvim',
    requires = { 'nvim-lua/plenary.nvim', 'kyazdani42/nvim-web-devicons', 'MunifTanjim/nui.nvim' },
  }

  -- Close buffers inteligently
  use { 'https://github.com/mhinz/vim-sayonara.git', cmd = 'Sayonara' }

  -- Open file under cursor with gf relative to current file path
  use 'https://github.com/kkoomen/gfi.vim.git'

  -- Fuzzy file serch
  use { 'junegunn/fzf', run = ':call fzf#install()' }
  use 'https://github.com/junegunn/fzf.vim.git'

  -- Lua-based fuzzy finder
  use {
    'nvim-telescope/telescope.nvim',
    requires = { 'nvim-lua/popup.nvim', 'nvim-lua/plenary.nvim' },
  }

  use {
    'jvgrootveld/telescope-zoxide',
    requires = { 'nvim-telescope/telescope.nvim' },
  }

  -- Auto completion
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-nvim-lua'
  use 'hrsh7th/nvim-cmp'
  -- adds vscode-like pictograms to neovim built-in lsp
  use 'https://github.com/onsails/lspkind-nvim.git'

  -- .editorconfig support
  -- editor config included in 0.9+
  use 'https://github.com/editorconfig/editorconfig-vim.git'
  -- Heuristically set buffer options
  -- use 'https://github.com/tpope/vim-sleuth.git'

  -- The three "core" operations of add/delete/change can be done with the keymaps ys{motion}{char}, ds{char}, and cs{target}{replacement}
  use {
    "kylechui/nvim-surround",
    config = function()
      require("nvim-surround").setup {}
    end
  }

  -- Multiple cursors
  use { 'mg979/vim-visual-multi', branch = 'master' }


  -- Toggling comments
  -- use 'https://github.com/preservim/nerdcommenter.git'
  use 'numToStr/Comment.nvim'

  -- Git show changes in gutter
  use 'https://github.com/mhinz/vim-signify.git'

  -- Floating terminal, using it to run lazygit
  use 'numtostr/FTerm.nvim'
  -- Git utilities, mostly using :GBrowse
  use 'dinhhuy258/git.nvim'
  -- use 'https://github.com/tpope/vim-fugitive'
  -- Add support for :GBrowse command from fugitive to work with github
  -- use 'https://github.com/tpope/vim-rhubarb.git'

  -- Spacemacs-like menu
  use 'folke/which-key.nvim'

  -- Dressing for improved selection UI that uses telescope
  use 'stevearc/dressing.nvim'
  use 'mrjones2014/legendary.nvim'

  -- Language client
  use 'https://github.com/Olical/conjure.git'

  -- use { 'https://github.com/eraserhd/parinfer-rust.git', ft = 'clojure', run = 'nix-shell --run \"cargo build --release \"' }
  use 'gpanders/nvim-parinfer'

  -- Structural editing of s-expressions ala paredit - barfing, slurping, etc.
  -- use 'guns/vim-sexp'
  -- Use snoe's fork which includes improvements to preserve cursor position and recursive capture.
  -- https://github.com/guns/vim-sexp/pull/12
  -- https://github.com/guns/vim-sexp/pull/15
  -- use { 'snoe/vim-sexp', commit = '4161f5c01504b77ab63f2957b943fca0c6e12e83' }
  -- Enables use of the . command for repeating change operations in vim-sexp
  use 'tpope/vim-repeat'
  -- use 'tpope/vim-sexp-mappings-for-regular-people'

  use 'neovim/nvim-lspconfig'
  -- Auto install LSP servers
  use { 'dundalek/lazy-lsp.nvim', requires = { 'neovim/nvim-lspconfig' } }

  -- Syntax highlighting for many languages, lazily loaded
  -- Polyglot provides :Toc command for markdown, otherwise can remove it since
  -- treesitter is now a thing.
  -- Also seems to provide sections for markdown, so that ]] and [[ work to
  -- jump to next / prev sections.
  -- use 'https://github.com/sheerun/vim-polyglot.git'

  -- Syntax highlighting based on treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate', -- We recommend updating the parsers on update
  }

  -- Display treesitter parser tree, open with :TSPlaygroundToggle
  use { 'nvim-treesitter/playground', cmd = 'TSPlaygroundToggle' }

  -- A tree like view for symbols in Neovim using the Language Server Protocol
  use 'https://github.com/simrat39/symbols-outline.nvim.git'

  -- For generating markdown Table of Contents
  use 'mzlogin/vim-markdown-toc'

  -- Markdown preview
  use { "iamcco/markdown-preview.nvim", run = "cd app && npm install", setup = function()
    vim.g.mkdp_filetypes = {
      "markdown" }
  end, ft = { "markdown" }, }
  -- Useful markdown editing functionality
  -- <C-k> for creating links from selection
  -- <C-b> to bold selection (requires vim-surround)
  -- <C-Space> to toggle task list items
  use { 'walterl/downtools' }

  ---- Experimental {{{1

  -- Better quickfix window - good for lsp references list with preview
  use 'kevinhwang91/nvim-bqf'
  -- use { 'kevinhwang91/nvim-bqf', config = function() require('bqf').setup() end }

  -- status line
  use 'windwp/windline.nvim'

  use 'akinsho/toggleterm.nvim'

  -- Show list of issues from lsp for fixing
  use { 'folke/trouble.nvim', requires = 'kyazdani42/nvim-web-devicons' }

  -- Better mode to move windows
  use {
    'sindrets/winshift.nvim',
    cmd = { 'WinShift' },
    config = function()
      require("winshift").setup({})
    end,
  }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)

-- Experimental {{{1

require("toggleterm").setup {
  shell = "zellij",
}

-- `setup()` must be called before `require('which-key).register()`
require('legendary').setup {
  default_item_formatter = nil,
  -- formatter = function(item)
  --   -- require('legendary.formatter').get_default_format_values
  --   return { "a", "b", "x" }
  -- end,
}

require("trouble").setup {}

-- preset for windline status line
-- require('wlsample.airline')
require('wlsample.evil_line')

-- Globals {{{1

P = function(v)
  print(vim.inspect(v))
  return v
end

RELOAD = function(...)
  require("plenary.reload").reload_module(...)
end

R = function(name)
  RELOAD(name)
  return require(name)
end


vim.o.mouse = 'a'
vim.opt.guicursor:append { 'a:blinkon100' } -- blinking cursor to get more comfy

-- General settings {{{1

vim.cmd [[
set number  " Show line numbers
set scrolloff=3             " number of screen lines to show around the cursor
" Smart case sensitivity handling for / searches
set ignorecase smartcase

" Show search and replace subsctitions incrementally (Neovim only)
set inccommand=nosplit

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
nnoremap <silent> <C-s> :w<CR>
" <C-G>u to break undo sequence with save point
" experiment - also go to normal mode after save with <esc>
inoremap <silent> <C-s> <C-G>u<Cmd>:w<CR><esc>
vnoremap <silent> <C-s> <Cmd>:w<CR>

" Split to right and bottom
set splitright splitbelow

" soft wrap lines
set wrap
" do not break in the middle of a word
set linebreak nolist
" Indent wrapped lines
set breakindent breakindentopt=min:40

"" neovim defaults should be sensible
" Copy indent from current line when starting a new line
set autoindent
" Do smart autoindenting when starting a new line
set smartindent

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
autocmd! BufWritePost */nvim/init.lua
  \ source $MYVIMRC
  \| setlocal foldmethod=marker

"-- Window and buffer management {{{1

" TAB in general mode will move to next window
" nnoremap <silent> <TAB> :wincmd w<CR>
" SHIFT-TAB will go back
" nnoremap <silent> <S-TAB> :wincmd W<CR>

" TAB in general mode will move to next buffer
"nnoremap <silent> <TAB> :bnext<CR>
" SHIFT-TAB will go back
"nnoremap <silent> <S-TAB> :bprevious<CR>

" Delete (close) buffer, keep window, saner :bdelete
nnoremap <leader>d :Sayonara!<CR>
" Quit window, saner :quit
nnoremap <leader>q :Sayonara<CR>

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

"-- Movement {{{1

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
nnoremap gk k
nnoremap gj j
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

"-- Editing {{{1

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
map gf :e <cfile><CR>

"---- Comment.nvim {{{1
lua require('Comment').setup()
" nnoremap <silent> <C-_>  :lua require('Comment').toggle()<CR>
" vnoremap <silent> <C-_>  <cmd>:lua require('Comment').toggle()<CR>gv
nmap <silent> <C-_>  gcc
vmap <silent> <C-_>  gcgv

"-- Theme / Colorscheme {{{1
if has("termguicolors")
  set termguicolors
endif

" Set colorscheme only once so that manually switch colorscheme does not get
" overwritten after config hot-reload.
if !get(g:, 'initial_colorcheme_selected')
  " Browse through available themes with :Telescope colorscheme
  let g:initial_colorcheme_selected = 1

  set background=dark " for the dark version
  colorscheme tokyonight-night
  " colorscheme ayu
  " colorscheme adwaita
  " colorscheme onehalfdark

  " === light themes

  " set background=light

  " colorscheme onehalflight
  " colorscheme edge
  " colorscheme intellij
  " colorscheme inspired-github
  "
  " colorscheme adwaita
  " let g:adwaita_mode = "light"

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
]]

---- colorizer {{{1
-- Show colors for hex values
-- names=false to not highlight color names like Green
require('colorizer').setup(nil, { names = false })


-- File Explorer {{{1

---- neo-tree {{{1

vim.g.neo_tree_remove_legacy_commands = 1

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
  -- disable lsp diagnostics as they seem to cause lagging/freezing
  enable_diagnostics = false,
})

-- Fuzzy file search {{{1

---- fzf {{{1

vim.cmd [[
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
]]

---- Telescope {{{1
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
      layout_config = {
        prompt_position = "top",
        mirror = true,
        preview_height = 1,
        height = 15,
        anchor = "S",
      },
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


---- Telescope zoxide {{{1
require("telescope").load_extension('zoxide')

-- Add directory to zoxide when changed for example with `:cd`
local zoxide_group = vim.api.nvim_create_augroup("zoxide", {})
vim.api.nvim_create_autocmd({ "DirChanged" }, {
  group = zoxide_group,
  callback = function(ev)
    vim.fn.system({ "zoxide", "add", ev.file })
  end
})

-- Auto completion {{{1

---- nvim-cmp {{{1

-- nvim-cmp needs this
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }

-- Setup nvim-cmp.
local cmp = require 'cmp'
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
    { name = 'buffer',  keyword_length = 5 },
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

-- Language configs {{{1

---- treesitter {{{1

require 'nvim-treesitter.configs'.setup {
  ensure_installed = "all", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  -- ignore_install = { "javascript" }, -- List of parsers to ignore installing
  highlight = {
    enable = true, -- false will disable the whole extension
    -- disable = { "c", "rust" },  -- list of language that will be disabled
  },
}

vim.cmd [[
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

"---- conjure {{{1
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
]]

---- lspconfig {{{1

-- symbols-outline.nvim
require 'symbols-outline'.setup {
  keymaps = {
    -- besides enter also mouse double-click to go to location
    goto_location = { "<Cr>", "<2-LeftMouse>" },
  },
}

vim.g.disable_lsp_formatting = false

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Set blank formatexpr so that wrapping with `gq` works
  buf_set_option('formatexpr', '')

  -- Mappings.
  local opts = { noremap = true, silent = true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'gD', '<cmd>vsplit | lua vim.lsp.buf.definition()<CR>', opts)
  -- buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
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

  buf_set_keymap('n', '<localleader>o', '<cmd>lua require"symbols-outline".toggle_outline()<cr>', opts)

  -- Display code lenses which show for example number of references and tests of a funtion

  -- set tagfunc to use lsp to jump to definitions with the default key-bindings like CTRL-]
  vim.cmd [[
    setlocal tagfunc=v:lua.vim.lsp.tagfunc
  ]]

  if client.server_capabilities.codeLensProvider then
    vim.cmd [[
      augroup lsp_codelens
        autocmd! * <buffer>
        autocmd BufWritePost,CursorHold,CursorHoldI <buffer> lua vim.lsp.codelens.refresh()
      augroup END
    ]]
  end

  -- Maybe change lower the value (default 4s) like set updatetime=1000
  -- Auto highlight symbols under cursor and its references
  if client.server_capabilities.documentHighlightProvider then
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
  if not is_liz_source and client.server_capabilities.documentFormattingProvider then
    vim.cmd [[
      augroup lsp_format
        autocmd! * <buffer>
        autocmd BufWritePre  <buffer> lua vim.lsp.buf.format()
      augroup END
    ]]
  end

  -- if client.server_capabilities.documentFormattingProvider then
  --   local group = vim.api.nvim_create_augroup('lsp_format', {})
  --   vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  --     group = group,
  --     pattern = "<buffer>",
  --     callback = function()
  --       -- if not vim.g.disable_lsp_formatting then
  --           vim.lsp.buf.format()
  --       -- end
  --     end
  --   })
  -- end
end

local nvim_lsp = require('lspconfig')
local util = require 'lspconfig/util'
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

---- lazy-lsp {{{1

vim.opt.runtimepath:prepend("~/code/lazy-lsp.nvim")
require("plenary.reload").reload_module("lazy-lsp")

require "lazy-lsp".setup {
  excluded_servers = {
    -- prefer tsserver
    "denols", --"stylelint_lsp", "eslint",
    -- ghcide and hie seem to be deprecated in favor of haskell-language-server (hls)
    "ghcide", "hie",

    -- preferring rust_analyzer
    "rls",

    -- to avoid interference with markdown files
    "zk",
    -- interferes with efm for markdown files
    "diagnosticls",
    -- seems to get into infinite loop
    "marksman",

    -- prefer clangd
    "ccls",

    -- it is nice to offer grammar suggestions for markdown files, but uses too much CPU and noise for rough notes
    -- figure out a workflow to toggle it manually
    "ltex",

    -- causes error to be printed: E484: Can't open file /home/me/.m2/repository/com/fujitsu/lsp
    "vdmj",

    -- configured manually due to having issues installing it via nix
    "clojure_lsp",

    -- marked as deprecated
    "sqls",
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
      filetypes = { "markdown", "sh", "vim" },
      on_attach = function(client, bufnr)
        local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
        local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

        -- Mappings.
        local opts = { noremap = true, silent = true }

        buf_set_keymap('n', '<localleader>o', '<cmd>lua require"symbols-outline".toggle_outline()<cr>', opts)
      end,
      init_options = {
        documentFormatting = true,
        documentSymbol = true,
        hover = true,
      },
      settings = {
        rootMarkers = { ".git/" },
        languages = {
          markdown = {
            { symbolCommand = 'markdown-symbols' },
            -- add dummy hover command which symbols-outline plugin expects
            { hoverCommand = 'echo' },
          },
          sh = {
            {
              lintCommand = 'shellcheck -f gcc -x',
              lintSource = 'shellcheck',
              lintFormats = { '%f:%l:%c: %trror: %m', '%f:%l:%c: %tarning: %m', '%f:%l:%c: %tote: %m' }
            }
          },
          vim = {
            { symbolCommand = 'vim-marker-symbols' },
            -- add dummy hover command which symbols-outline plugin expects
            { hoverCommand = 'echo' },
          },
        },
      },
    },
    lua_ls = {
      settings = {
        Lua = {
          diagnostics = {
            -- Get the language server to recognize the `vim` global
            globals = { 'vim' },
          },
        },
      },
    },
    jdtls = {
      cmd = { "jdt-language-server" },
    },
    dartls = {
      cmd = { "dart", "language-server" },
    },
    -- tsserver = {
    --   cmd = { "typescript-language-server", "--stdio" },
    -- },
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


---- Markdown {{{1

-- Plugin with markdown folding is built-in, just enable folding support
vim.g.markdown_folding = 1

vim.cmd [[
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
  " `formatioptions` and `comments` to make it that hyphen is automatically
  " inserted to continue lists on newline https://www.reddit.com/r/neovim/comments/wdmmgc/comment/iimaym0/
  autocmd FileType markdown
    \  setlocal linebreak
    \| setlocal relativenumber
    \| setlocal formatoptions+=r
    \| setlocal comments-=fb:- comments+=:-
    \| lua require('cmp').setup.buffer { enabled = false }
    " \| setlocal foldmethod=expr
    " \| setlocal foldexpr=StackedMarkdownFolds()
    " \| normal zR

    " \ setlocal nonumber
    " \|  setlocal spell " spelling error highlights are too distracting, it
    " would be good to find out how to uderline only and then enable it
    " automatically again
augroup END
]]

-- Don't close current markdown preview window when switching away from buffer
-- let g:mkdp_auto_close = 0
vim.g.mkdp_auto_close = 0

vim.cmd [[
"---- Liz {{{1
augroup lang_liz
  autocmd! BufNewFile,BufRead *.liz
    \  setlocal syntax=clojure
    \| setlocal filetype=clojure
augroup END

"---- ClojureDart {{{1
augroup lang_clojuredart
  autocmd! BufNewFile,BufRead *.cljd
    \  setlocal syntax=clojure
    \| setlocal filetype=clojure
augroup END

"---- TypeScript {{{1

augroup lang_typescript
  autocmd!
  " Dim type annotations as comments for better code readability
  " TSParameter - but that also dims parameters for regular functions
  autocmd FileType typescript
    \ highlight! link TSType Comment
augroup END
]]

-- Space menu {{{1

---- Git {{{1

-- Open lazygit in a floating window
local lazygit = require('FTerm'):new({ cmd = 'lazygit', dimensions = { height = 1, width = 1 } })

---- legendary.nvim {{{1

vim.keymap.set("n", "<leader><leader>", ":Legendary<cr>", {
  silent = true,
  desc = "Command Palette (Legendary)",
})

-- Register non-frequent command without bindings with legendary to be searchable in command menu
require('legendary').commands({
  { ':g/^\\s*$/d',              description = 'Delete blank lines' },
  {
    ':! chmod +x %',
    description =
    'Make current file executable'
  },
  { ':%bd|e#',                  description = 'Close other buffers' },
  { ':ConjureShadowSelect app', description = 'Conjure shadow select app' },
  {
    ':ConjureShadowSelect {name}',
    description = 'Conjure shadow select',
    unfinished = true
  },
  {
    ':ConjureConnect 48888',
    description =
    'Conjure: Pitch Backend REPL'
  },
  {
    ':ConjureConnect 7888',
    description =
    'Conjure: Pitch Frontend REPL'
  },
  { ':ConjureConnect 1667',                                                     description = 'Conjure: Babashka REPL' },
  -- Evaling alert to verify REPL is working and locate which browser provides runtime
  { ':ConjureEval (js/alert "Hello!")',                                         description = 'Conjure eval alert' },
  { ':Telescope builtin',                                                       description = 'Telescope bultins' },
  -- { ':lua require("litee.ui").toggle_panel()', description = 'LSP Call Tree Hierarchy' },
  { ':lua vim.lsp.buf.incoming_calls()',                                        description = 'LSP incoming calls' },
  { ':lua vim.lsp.buf.outgoing_calls()',                                        description = 'LSP outgoing calls' },
  -- enew+execute is to pipe result into buffer to make it searchable
  { ":enew|pu=execute('lua print(vim.inspect(vim.lsp.get_active_clients()))')", description = 'LSP client capabilities' },
  {
    ':lua vim.g.disable_lsp_formatting = not vim.g.disable_lsp_formatting',
    description = 'LSP toggle formatting on save'
  },
  { ':DownToggleListItem',     description = 'Markdown: Toggle list item' },
  { ':DownMakeLink',           description = 'Markdown: Create link' },
  -- { ':split term://fish', description = 'Toggle Terminal' },
  { ':ToggleTerm',             description = 'Toggle Terminal' },
  { ':Neotree source=buffers', description = 'NeoTree: Opened buffers' },
})

require('legendary').funcs {
  {
    function() vim.opt_local.spell = not vim.opt_local.spell end,
    description = 'Toggle spell check'
  },
}

--[[
vim.lsp.set_log_level("debug")
]]
-- Add Telescope builtin to Command Pallete
for k, v in pairs(require "telescope.builtin") do
  require('legendary').command({ ':Telescope ' .. k, description = 'Telescope: ' .. k })
end

-- Add Telescope extensions to Command Pallete
for ext, funcs in pairs(require("telescope").extensions) do
  for func_name, func_obj in pairs(funcs) do
    -- Only include exported functions whose name doesn't begin with an underscore
    if type(func_obj) == "function" and string.sub(func_name, 0, 1) ~= "_" then
      require('legendary').command({
        ':Telescope ' .. ext .. " " .. func_name,
        description = 'Telescope: ' .. ext .. " : " .. func_name
      })
    end
  end
end

---- which-key.nvim {{{1

local wk = require("which-key")

vim.keymap.set('n', '<leader>b', '<cmd>:Neotree toggle=true<CR>', {
  silent = true,
  desc = 'NeoTree: Toggle file panel'
})

vim.keymap.set('n', '<C-bslash>', '<cmd>:Neotree reveal=true<CR>', {
  silent = true,
  desc = 'NeoTree: Revel current file'
})

vim.cmd [[
" TODO: rewrite using which-key
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
nnoremap <leader>fe :Telescope live_grep<cr>

" bind it outside of on_attach to use for debugging
nnoremap <space>ll :LspInfo<cr>
" :lua print(vim.lsp.get_log_path())
nnoremap <space>lL :e ~/.local/state/nvim/lsp.log<cr>

" Useful for the efm-markdown wrapper
nnoremap <space>ls :Telescope lsp_document_symbols<cr>
]]

wk.register({
  ["<leader>."] = { "<cmd>e $MYVIMRC<cr>", "open init" },
  ["gq"] = { "wrap text" },
  -- Prefer key sequence over chording
  -- it works but does not show which key menu for window
  ["<leader>w"] = { "<c-w>", "+window" },
})

wk.register({
  f = {
    name = "+find",
    h = { "<cmd>Telescope command_history<cr>", "Find in command history" }
    -- ["<leader>ff"] = { "<cmd>Telescope find_files<cr>", "Find File" },
    -- ["<leader>fr"] = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
    -- ["<leader>fh"] = { "<cmd>Telescope command_history<cr>", "Find in command history" },
    -- ["<leader>fn"] = { "<cmd>enew<cr>", "New File" },
  },
  g = {
    name = "Git",
    -- l = {"<cmd>Git blame<cr>", "Git: Blame" },
    b = { "<cmd>Telescope git_branches<cr>", "Git: Branches" },
    d = { "<cmd>:SignifyHunkDiff<cr>", "Git: Hunk Diff" },
    U = { "<cmd>:SignifyHunkUndo<cr>", "Git: Undo Hunk" },
    l = { function() require('git.blame').blame() end, "Git: Blame" },
    h = { function() require('git.browse').open(false) end, "Git: Browse" },
    g = { function() lazygit:toggle() end, "Git: Lazygit" },
  },
  j = {
    name = "Jump",
    j = { "<cmd>:Buffers<cr>", "Buffers" },
    k = { "<cmd>:Neotree toggle=true<cr>", "File Tree: Toggle" },
    l = { "<cmd>:Neotree reveal=true<cr>", "File Tree: Reveal current" },
    d = { "<cmd>:lua require('telescope').extensions.zoxide.list()<cr>", "Jump to directory" },
  },
  l = {
    name = "+lsp",
    c = { "<cmd>:ConjureConnect<cr>", "Conjure: Connect to REPL" },
  },
  -- TODO: Figure out how to bind these via autocmd
  m = {
    name = "+markdown",
    p = { "<cmd>MarkdownPreview<cr>", "Markdown: Preview" },
    t = { "<cmd>GenTocGFM<cr>", "Markdown: Generate TOC Table of Contents" },
  },
  t = {
    name = "Toggle",
    t = { "<cmd>:ToggleTerm<cr>", "Terminal" },
    -- replace cmd with chatgpt when new version supporting -n flag is tagged upstream and updated in nixpkgs
    c = { "<cmd>:lua require('FTerm').scratch({ cmd = {'/home/me/dl/git/chatgpt/chatgpt', '-n'} })<cr>", "ChatGPT" },
  },
  w = {
    m = { "<Cmd>:WinShift<CR>", "Move" },
  },
}, { prefix = "<leader>" })

wk.register({
  e = {
    -- Conjure omits exception stacktrace by default, add a shorthad eval the exception to get to the stacktrace
    x = { "<cmd>:ConjureEval *e<cr>", "Eval REPL exception" },
    t = { "<cmd>:ConjureEval (tap> *1)<cr>", "Eval: Tap last value" },
  },
  r = { "<cmd>:set relativenumber!<cr>", "Toggle relative line numbers" },
  t = {
    t = { "<cmd>:ConjureEval (kaocha.repl/run {:kaocha/reporter [kaocha.report/documentation]})<cr>",
      "Run tests in REPL with kaocha" },
  },
}, { prefix = "<localleader>" })
