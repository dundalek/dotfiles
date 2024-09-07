-- vim: foldmethod=marker
-- Press zM to close all folds to navigate the structure, zR to open all.
-- Press zj / zk to jump to next / previous section.
--
---- Global {{{1

-- Set our leader key to space. This needs to be set first before all plugins are loaded.
vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- Plugins expect POSIX shell which can cause problems when closh is used
vim.o.shell = "/usr/bin/bash"

-- Plugins {{{1

local plugins = {
  -- I like to specify full url of the plugin, because one can then press `gx` to open
  -- the plugin home page in a web browser.

  -- Syntax highlighting theme
  -- Dark+Light
  -- Dark
  {
    "folke/tokyonight.nvim",
    lazy = false,    -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      require("tokyonight").setup {
        style = "night",
      }
      -- load the colorscheme here
      vim.cmd([[colorscheme tokyonight]])
    end,
  },
  "https://github.com/ayu-theme/ayu-vim.git",
  "https://github.com/mhartington/oceanic-next.git",

  -- 'https://github.com/haishanh/night-owl.vim.git',
  -- 'https://github.com/arcticicestudio/nord-vim.git',
  -- 'https://github.com/drewtempelmeyer/palenight.vim.git',
  -- 'https://github.com/joshdick/onedark.vim.git',
  -- 'https://github.com/tomasiser/vim-code-dark.git',

  -- Light themes
  -- { 'https://github.com/sonph/onehalf.git', rtp = 'vim' }, -- rtp needs to be migrated
  "https://github.com/sainnhe/edge.git",
  "chiendo97/intellij.vim",
  "Mofiqul/adwaita.nvim",
  "mvpopuk/inspired-github.vim",
  "https://github.com/projekt0n/github-nvim-theme.git",
  "https://github.com/habamax/vim-sugarlily",

  -- Show colors for hex values
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      -- Show colors for hex values
      -- names=false to not highlight color names like Green
      require("colorizer").setup(nil, { names = false })
    end,
  },

  ---- neo-tree {{{1

  -- Tree plugin
  {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "kyazdani42/nvim-web-devicons", "MunifTanjim/nui.nvim" },
    -- cmd = "Neotree", -- loading Neotree lazily breaks legendary paletter for some reason
    init = function() vim.g.neo_tree_remove_legacy_commands = 1 end,
    opts = {
      -- override to add the experimental "document_symbols" source
      sources = { "filesystem", "buffers", "git_status", "document_symbols", },
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
        mappings = {
          -- override to not use floating window for preview
          ["P"] = { "toggle_preview", config = { use_float = false } },
        }
      },
      filesystem = {
        group_empty_dirs = true, -- flatten empty nested folders
        scan_mode = "deep",      -- scan into directories to detect possible empty folders
        filtered_items = {
          -- show hidden files like dotfiles and git ignored
          visible = true,
        },
        commands = {
          -- Override delete to use trash instead of rm
          -- https://github.com/nvim-neo-tree/neo-tree.nvim/issues/202
          delete = function(state)
            local inputs = require "neo-tree.ui.inputs"
            local path = state.tree:get_node().path
            local msg = "Are you sure you want to trash " .. path
            inputs.confirm(msg, function(confirmed)
              if not confirmed then return end

              vim.fn.system { "gio", "trash", path }
              require("neo-tree.sources.manager").refresh(state.name)
            end)
          end,
        },
      },
      -- disable lsp diagnostics as they seem to cause lagging/freezing
      enable_diagnostics = false,
    },
    -- my efm markdown source does not work with neotree symbols, keep symbols-outline as default for now
    -- keys = {
    --   { "<localleader>o", '<cmd>:Neotree document_symbols<cr>',
    --     "Lsp: SYmbols outline" }
    -- }
  },

  -- Close buffers inteligently
  { "https://github.com/mhinz/vim-sayonara.git", cmd = "Sayonara" },

  -- Open file under cursor with gf relative to current file path
  "https://github.com/kkoomen/gfi.vim.git",

  -- Fuzzy file serch
  { "junegunn/fzf", build = ":call fzf#install()" },
  "https://github.com/junegunn/fzf.vim.git",

  -- Lua-based fuzzy finder
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/popup.nvim", "nvim-lua/plenary.nvim" },
  },

  {
    "jvgrootveld/telescope-zoxide",
    dependencies = { "nvim-telescope/telescope.nvim" },
  },

  -- Auto completion
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-path",
  "hrsh7th/cmp-nvim-lua",
  "hrsh7th/nvim-cmp",
  -- adds vscode-like pictograms to neovim built-in lsp
  "https://github.com/onsails/lspkind-nvim.git",

  -- .editorconfig support
  -- editor config included in 0.9+, not needed anymore?
  'https://github.com/editorconfig/editorconfig-vim.git',

  -- The three "core" operations of add/delete/change can be done with the keymaps ys{motion},{char}, ds{char}, and cs{target}{replacement}
  { "kylechui/nvim-surround", opts = {} },

  -- Multiple cursors
  { "mg979/vim-visual-multi", branch = "master" },

  -- automatically toggle between relative and absolute line numbers
  -- 'https://github.com/sitiom/nvim-numbertoggle',

  -- Editing {{{1
  ---- Toggling comments {{{1
  -- commenting included in 0.10, plugin no longer needed?
  {
    "numToStr/Comment.nvim",
    opts = {},
    keys = {
      -- nmap <silent> <C-_>  gcc
      -- vmap <silent> <C-_>  gcgv
      { "<C-_>", "gcc", silent = true, remap = true, desc = "Toggle Line Comment" },
      {
        "<C-_>",
        "gcgv",
        mode = "v",
        silent = true,
        remap = true,
        desc =
        "Toggle Visual Selection Comment"
      },
    },
  },

  -- Git show changes in gutter
  -- 'https://github.com/mhinz/vim-signify.git',
  "lewis6991/gitsigns.nvim",

  -- Floating terminal, using it to run lazygit
  -- 'numtostr/FTerm.nvim',
  -- Git utilities, mostly using :GBrowse and blame
  "dinhhuy258/git.nvim",
  -- In contrast to git.nvim, it opens permalinks for browsing (and possibly supports more hosts)
  {
    "https://github.com/ruifm/gitlinker.nvim",
    opts = { mappings = nil },
    keys = {
      {
        "<leader>go",
        '<cmd>lua require("gitlinker").get_buf_range_url("v", {action_callback = require("gitlinker.actions").open_in_browser})<cr>',
        mode = "v"
      },
      {
        "<leader>go",
        '<cmd>lua require("gitlinker").get_buf_range_url("n", {action_callback = require("gitlinker.actions").open_in_browser})<cr>',
        desc = "Git: Browse Permalink"
      },
    },
  },


  -- git diff and merge view
  {
    "sindrets/diffview.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory" },
  },

  -- Dressing for improved selection UI that uses telescope
  "stevearc/dressing.nvim",
  "mrjones2014/legendary.nvim",

  -- Spacemacs-like menu
  -- v3 is breaking key format - will need time to upgrade
  { "folke/which-key.nvim", tag = "v2.1.0" },

  -- bracketted key mappings like `[b` `]b` for switching buffers or `[q` `]q` for navigating quickfix list
  -- advantage over tpope/vim-unimpaired is that is sets mapping descriptions
  -- todo: it would be nice to add mappings to legendary  require('unimpaired.config').defaults.keymaps
  { "tummetott/unimpaired.nvim", opts = {} },

  -- Language client
  {
    "https://github.com/Olical/conjure.git",
    init = function()
      vim.g["conjure#client#clojure#nrepl#refresh#backend"] = "clj-reload"
    end,
  },
  -- Load CLojure exception trace into location list
  {
    "walterl/conjure-locstack",
    keys = {
      { "<localleader>es", "<cmd>:LocStack<cr>", desc = "Load exception stacktrace into location list" },
    }
  },

  -- Structural editing of s-expressions
  {
    -- "dundalek/parpar.nvim",
    dir = "~/code/parpar.nvim",
    dependencies = { "gpanders/nvim-parinfer", "julienvincent/nvim-paredit" },
    config = function()
      local paredit = require("nvim-paredit")
      local keys = vim.tbl_extend("force", require("nvim-paredit.defaults").default_keys, {
        -- custom bindings are automatically wrapped
        ["<A-H>"] = { paredit.api.slurp_backwards, "Slurp backwards" },
        ["<A-J>"] = { paredit.api.barf_backwards, "Barf backwards" },
        ["<A-K>"] = { paredit.api.barf_forwards, "Barf forwards" },
        ["<A-L>"] = { paredit.api.slurp_forwards, "Slurp forwards" },

        ["<o"] = { paredit.api.raise_form, "Raise form" },
        ["<O"] = { paredit.api.raise_element, "Raise element" },
        -- These are text object selection keybindings which can used with standard `d, y, c`, `v`
        -- ["af"] = {
        --   paredit.api.select_around_form,
        --   "Around form",
        --   repeatable = false,
        --   mode = { "o", "v" }
        -- },
        -- ["if"] = {
        --   paredit.api.select_in_form,
        --   "In form",
        --   repeatable = false,
        --   mode = { "o", "v" }
        -- },
      })
      keys["<localleader>o"] = nil
      keys["<localleader>O"] = nil

      require("parpar").setup {
        paredit = {
          use_default_keys = false,
          keys = keys
        }
      }

      -- Workaround for joining lines with J, https://github.com/gpanders/nvim-parinfer/issues/12#issuecomment-1534552172
      -- todo: map only for clojure files
      vim.cmd "nnoremap J A<space><esc>J"
    end
  },

  -- sets lua lsp for signature help, docs and completion for the nvim lua API
  -- IMPORTANT: make sure to setup neodev BEFORE lspconfig
  -- "folke/neodev.nvim",

  "neovim/nvim-lspconfig",
  -- Auto install LSP servers
  {
    -- "dundalek/lazy-lsp.nvim",
    dir = "~/code/lazy-lsp.nvim",
    dependencies = { "neovim/nvim-lspconfig", "b0o/schemastore.nvim", }
  },

  -- {
  --   "dundalek/lazy-lsp.nvim",
  --   dependencies = {
  --     "neovim/nvim-lspconfig",
  --     { "VonHeikemen/lsp-zero.nvim", branch = "v3.x" },
  --     "hrsh7th/cmp-nvim-lsp",
  --     "hrsh7th/nvim-cmp",
  --   },
  --   config = function()
  --     local lsp_zero = require("lsp-zero")
  --
  --     lsp_zero.on_attach(function(client, bufnr)
  --       -- see :help lsp-zero-keybindings to learn the available actions
  --       lsp_zero.default_keymaps({
  --         buffer = bufnr,
  --         preserve_mappings = false
  --       })
  --     end)
  --
  --     require("lazy-lsp").setup {}
  --   end,
  -- },

  -- Preview lsp definitions in floating windows
  {
    "rmagatti/goto-preview",
    opts = {},
    keys = {
      { "<leader>lp", function() require("goto-preview").goto_preview_definition() end,
        "Lsp: Preview Definition" },
      { "<leader>ly", function() require("goto-preview").goto_preview_type_definition() end,
        "Lsp: Preview Type Definition" },
      { "<leader>li", function() require("goto-preview").goto_preview_implementation() end,
        "Lsp: Preview Implementation" },
    }
  },

  -- Syntax highlighting based on treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate", -- We recommend updating the parsers on update
  },

  -- "https://github.com/Dkendal/nvim-treeclimber",

  -- A tree like view for symbols in Neovim using the Language Server Protocol
  -- plugin archived on on Jan 3, 2024, trying neotree with document_symbols source as an alternative
  {
    "https://github.com/simrat39/symbols-outline.nvim.git",
    opts = {
      autofold_depth = 1,
      keymaps = {
        -- besides enter also mouse double-click to go to location
        goto_location = { "<Cr>", "<2-LeftMouse>" },
      }
    },
    keys = {
      { "<localleader>o", '<cmd>lua require"symbols-outline".toggle_outline()<cr>',
        "Lsp: SYmbols outline" }
    }
  },

  -- For generating markdown Table of Contents
  "mzlogin/vim-markdown-toc",

  -- Markdown preview
  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && npx --yes yarn install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }

      -- Don't close current markdown preview window when switching away from buffer
      vim.g.mkdp_auto_close = 0
    end,
    ft = { "markdown" },
  },
  -- Useful markdown editing functionality
  -- <C-k> for creating links from selection
  -- <C-b> to bold selection (requires vim-surround)
  -- <C-Space> to toggle task list items
  { "walterl/downtools" },

  ---- Experimental {{{1

  -- Better quickfix window - good for lsp references list with preview
  "kevinhwang91/nvim-bqf",

  -- status line
  {
    "windwp/windline.nvim",
    config = function()
      -- preset for windline status line
      -- require('wlsample.airline')
      require("wlsample.evil_line")
    end,
  },

  -- { 'akinsho/toggleterm.nvim', config = function() end },
  { "rebelot/terminal.nvim", opts = {} },

  -- Show list of issues from lsp for fixing
  { "folke/trouble.nvim", dependencies = "kyazdani42/nvim-web-devicons", opts = {}, cmd = "TroubleToggle" },

  -- Better mode to move windows
  { "sindrets/winshift.nvim", cmd = { "WinShift" }, opts = {} },

  -- Closed unedited buffers
  -- Can also consider https://github.com/chrisgrieser/nvim-early-retirement
  -- for time based buffer clean up
  { "axkirillov/hbac.nvim", opts = { autoclose = false } },

  -- AI autocompletion
  {
    "Exafunction/codeium.vim",
    -- local fork to set option to disable autocomplete in comments
    -- https://github.com/Exafunction/codeium.vim/issues/29#issuecomment-1771907425
    -- but neither lua nor clojure have grammar so disabling comments does not work, but works e.g. for javascript
    -- dir = "/home/me/Downloads/git/codeium.vim",
    dependencies = { "parpar.nvim" },
    -- event = "BufEnter",
    init = function()
      vim.g.codeium_disable_bindings = 1
    end,
    config = function()
      vim.g.codeium_filetypes = {
        markdown = false,
        text = false,
        dotenv = false,
      }

      -- Disable completion in comments - does not work because the original implementation is likely kept in closure
      -- https://github.com/Exafunction/codeium.vim/issues/29#issuecomment-1771907425
      -- local original_get_editor_options = vim.fn["codeium#doc#GetEditorOptions"]
      -- vim.fn["codeium#doc#GetEditorOptions"] = function()
      --   local options = original_get_editor_options()
      --   options.disable_autocomplete_in_comments = true
      --   return options
      -- end

      -- Detection inspired by nvim-treesitter.configs.attach_module
      local ts_parsers = require "nvim-treesitter.parsers"
      local ts_configs = require 'nvim-treesitter.configs'
      local function treesitter_enabled(bufnr, lang)
        local mod_name = "highlight"
        bufnr = bufnr or vim.api.nvim_get_current_buf()
        lang = lang or ts_parsers.get_buf_lang(bufnr)

        if vim.g.codeium_filetypes[lang] ~= false and ts_configs.is_enabled(mod_name, lang, bufnr) then
          return true
        end
        return false
      end

      -- I don't want AI completions in non-code buffers like Telescope prompt or neo-tree inputs.
      -- I don't know all special buffer types upfront, so the the idea is to detect if a buffer is a source code.
      -- The heuristic is by checking if a treesitter grammar exists, then we consider it a code.
      vim.api.nvim_create_autocmd({ "BufEnter" }, {
        callback = function(ev)
          if not treesitter_enabled() then
            -- If not then set local buffer option to disable Codeium which is checked in codeium#Enabled()
            vim.b.codeium_enabled = false
          end
        end,
      })

      local parpar = require("parpar")
      local accept = function()
        -- codeium clashes with parinfer when running synchronously,
        -- but it seems to work when scheduling asynchronously
        -- (hypothesis: `vim.fn` run is deferred (:help fast-api))
        vim.schedule(parpar.pause())
        return vim.fn["codeium#Accept"]()
      end

      vim.keymap.set("i", "<Tab>", accept, { expr = true })
      -- vim.keymap.set("i", "<C-g>", accept, { expr = true })
      -- vim.keymap.set("i", "<c-;>", function() return vim.fn["codeium#CycleCompletions"](1) end, { expr = true })
      -- vim.keymap.set("i", "<c-,>", function() return vim.fn["codeium#CycleCompletions"](-1) end, { expr = true })
      -- vim.keymap.set("i", "<c-x>", function() return vim.fn["codeium#Clear"]() end, { expr = true })
    end
  },

  -- render a keyboard displaying which keys have assigned actions
  { 'jokajak/keyseer.nvim', version = false },
}

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

-- bisecting bad plugins
-- local from = 1
-- local to = 55 -- #plugins
-- print((from + to) / 2)
-- plugins = vim.list_slice(plugins, from, to)

require("lazy").setup(plugins, {})

-- Experimental {{{1

-- adding dotenv filetype so that can be ignored for Codeium completions
vim.filetype.add({
  filename = {
    [".env"] = "dotenv",
  },
  -- pattern does not seem to work
  -- maybe just do it using autocmd
  -- https://neovim.discourse.group/t/how-to-add-custom-filetype-detection-to-various-env-files/4272/4
  pattern = {
    [".*%.env.*"] = { "dotenv", { priority = 100 } },
  },
})

-- require("toggleterm").setup {
--   shell = "zellij",
-- }

-- Globals {{{1

P = function(v)
  print(vim.inspect(v))
  return v
end

RELOAD = function(...) require("plenary.reload").reload_module(...) end

R = function(name)
  RELOAD(name)
  return require(name)
end

vim.o.mouse = "a"
vim.opt.guicursor:append { "a:blinkon100" } -- blinking cursor to get more comfy

-- General settings {{{1

vim.o.number = true -- Show line numbers
vim.o.scrolloff = 3 -- number of screen lines to show around the cursor
-- Smart case sensitivity handling for / searches
vim.o.ignorecase = true
vim.o.smartcase = true

-- Show search and replace subsctitions incrementally (Neovim only)
vim.o.inccommand = "nosplit"

vim.cmd([[

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
" set smartindent

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

" use ctrl  +hjkl to move between split/vsplit panels
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
inoremap <C-h> <C-\><C-N><C-w>h
inoremap <C-j> <C-\><C-N><C-w>j
inoremap <C-k> <C-\><C-N><C-w>k
inoremap <C-l> <C-\><C-N><C-w>l

"-- Movement {{{1

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

" use :Inspect to figure out syntax highlight groups
" Code lens is an information line from LSP like number of references or tests
highlight link LspCodeLens Comment
" highlight link LspCodeLensSeparator Comment

" Make typescript type noise less prominent
highlight link @type.typescript Comment
highlight link @lsp.type.typeParameter.typescript Comment
highlight link @lsp.type.type.typescript Comment
highlight link @lsp.type.interface.typescript Comment

]])

local function map(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.silent = opts.silent ~= false
  vim.keymap.set(mode, lhs, rhs, opts)
end

-- Move Lines
map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move down" })
map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })

-- Fuzzy file search {{{1

---- fzf {{{1

vim.cmd([[
if executable('rg')
  " .gitignore is applied automatically, --hidden is to search in files
  " starting with a dot, but then we need the --glob parameter to exclude contents of .git
  let $FZF_DEFAULT_COMMAND = 'rg --files --follow --hidden --glob "!.git/*"'

  " user ripgrep for :grep
  set grepprg=rg\ --vimgrep\ --smart-case\ --follow

  " do not match file name when searching in files
  let spec = {'options': '--delimiter : --nth 4..'}

  function! RipgrepFzf(query, fullscreen)
    let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case --fixed-strings --follow --hidden --glob "!.git/*" -- %s || true'
    let initial_command = printf(command_fmt, shellescape(a:query))
    let reload_command = printf(command_fmt, '{q}')
    let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
    call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
  endfunction

  command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)
endif

" Preview window on the upper side of the window with 40% height,
" hidden by default, ctrl-/ to toggle
let g:fzf_preview_window = ['up:40%:hidden', 'ctrl-/']

let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit'
  \}

]])

---- Telescope {{{1
require("telescope").setup {
  defaults = {
    -- Using vertical strategy because not having cut-off list entries is more
    -- important for narrower window size. TODO: explore flex sizing to switch to
    -- horizontal layout for wider window size.
    layout_strategy = "vertical",
    -- Default cycle scroll strategy is confusing, don't wraparound at the end.
    -- One can also use gg and G to jump to the other end.
    scroll_strategy = "limit",
    -- layout_config = {
    --   vertical = { width = 0.9 }
    --   -- other layout configuration here
    -- },
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
    live_grep = {
      -- Args for ripgrep to follow links to search in linked files, e.g. Logseq pages vault
      additional_args = { "--follow" },
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
}

---- Telescope zoxide {{{1
require("telescope").load_extension("zoxide")

-- Add directory to zoxide when changed for example with `:cd`
local zoxide_group = vim.api.nvim_create_augroup("zoxide", {})
vim.api.nvim_create_autocmd({ "DirChanged" }, {
  group = zoxide_group,
  callback = function(ev) vim.fn.system { "zoxide", "add", ev.file } end,
})

-- Auto completion {{{1

---- nvim-cmp {{{1

-- nvim-cmp needs this
vim.opt.completeopt = { "menu", "menuone", "noselect" }

-- Setup nvim-cmp.
local cmp = require("cmp")
cmp.setup {
  mapping = cmp.mapping.preset.insert({
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.close(),
    -- Changed default for enter to behave as newline if no item is selected
    ["<CR>"] = cmp.mapping.confirm { select = false },
    -- Read :help ins-completion but stayed a lowly tab-completer
    -- disabling tab temporarily to avoid clashing with codeium
    -- ["<Tab>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "s" }),
    ["<C-n>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "s" }),
    ["<C-p>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "s" }),
  }),
  sources = {
    { name = "nvim_lsp" },
    { name = "nvim_lua" },
    { name = "path" },
    { name = "buffer", keyword_length = 5 },
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
  snippet = {
    expand = function(arg)
      vim.snippet.expand(arg.body)
    end,
  },
}

-- Terminal {{{1

require("terminal").setup()
local bottom_terminal = require("terminal").terminal:new {
  layout = { open_cmd = "botright new +resize15" },
  cmd = { "zellij" },
}

local lazygit_terminal = require("terminal").terminal:new {
  layout = { open_cmd = "float", height = 1, width = 1 },
  cmd = { "lazygit" },
  autoclose = true,
}

local chatgpt_terminal = require("terminal").terminal:new {
  -- nix-env -iA nixpkgs.chatgpt-cli
  cmd = { "chatgpt", "-n" },
  layout = { open_cmd = "float", border = "rounded" },
  autoclose = true,
}

-- Auto insert mode
vim.api.nvim_create_autocmd({ "WinEnter", "BufWinEnter", "TermOpen" }, {
  callback = function(args)
    if vim.startswith(vim.api.nvim_buf_get_name(args.buf), "term://") then
      vim.cmd("startinsert")
    end
  end,
})

-- terminal window highlight
vim.api.nvim_create_autocmd("TermOpen", {
  command = [[setlocal nonumber norelativenumber winhl=Normal:NormalFloat]],
})

vim.cmd([[
tnoremap <c-\><c-\> <c-\><c-n><c-w>k
]])

-- Language configs {{{1

---- treesitter {{{1

require("nvim-treesitter.configs").setup {
  ensure_installed = "all", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  -- ignore_install = { "javascript" }, -- List of parsers to ignore installing
  highlight = {
    enable = true, -- false will disable the whole extension
    -- disable = { "c", "rust" },  -- list of language that will be disabled
  },
}

-- Use folds based on treesitter parsing
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

-- https://stackoverflow.com/questions/8316139/how-to-set-the-default-to-unfolded-when-you-open-a-file
-- Following is to open all folds by default, they can be closed with zM if necessary
vim.opt.foldenable = false

---- lspconfig {{{1

vim.g.disable_lsp_formatting = false

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

  -- Set blank formatexpr so that wrapping with `gq` works
  buf_set_option("formatexpr", "")

  -- Mappings.
  local opts = { noremap = true, silent = true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
  buf_set_keymap("n", "gD", "<cmd>vsplit | lua vim.lsp.buf.definition()<CR>", opts)
  -- buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  -- buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
  buf_set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)

  buf_set_keymap("n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
  buf_set_keymap("n", "<leader>ld", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
  buf_set_keymap("n", "<leader>ln", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  buf_set_keymap("n", "<leader>lr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  buf_set_keymap("n", "<leader>li", "<cmd>lua vim.lsp.buf.implementations()<CR>", opts)
  buf_set_keymap("n", "<leader>lh", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  buf_set_keymap("n", "<leader>lq", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)

  -- Disable semantic highlighting (to just use treesitter)
  -- client.server_capabilities.semanticTokensProvider = nil

  -- Display code lenses which show for example number of references and tests of a funtion

  -- set tagfunc to use lsp to jump to definitions with the default key-bindings like CTRL-]
  vim.cmd([[
    setlocal tagfunc=v:lua.vim.lsp.tagfunc
  ]])

  -- if client.server_capabilities.codeLensProvider then
  if client.supports_method("textDocument/codeLens") then
    vim.cmd([[
      augroup lsp_codelens
        autocmd! * <buffer>
        autocmd BufWritePost,CursorHold,CursorHoldI <buffer> lua vim.lsp.codelens.refresh({bufnr = 0})
      augroup END
    ]])
  end

  -- Maybe change lower the value (default 4s) like set updatetime=1000
  -- Auto highlight symbols under cursor and its references
  if client.server_capabilities.documentHighlightProvider then
    vim.cmd([[
      augroup lsp_highlight
        autocmd! * <buffer>
        autocmd CursorHold  <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]])
  end

  -- format on save
  -- don't auto format Liz sources because the formatter messes them up
  local is_liz_source = vim.fn.bufname():find(".liz$")
  if not is_liz_source and client.server_capabilities.documentFormattingProvider then
    vim.cmd([[
      augroup lsp_format
        autocmd! * <buffer>
        autocmd BufWritePre  <buffer> lua if not vim.g.disable_lsp_formatting then vim.lsp.buf.format() end
      augroup END
    ]])
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

-- seems to show popup `Do you need to configure your work environment as `luv`?` disabling for now
-- require("neodev").setup {}

local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

---- lazy-lsp {{{1

-- vim.opt.runtimepath:prepend("~/code/lazy-lsp.nvim")
-- require("plenary.reload").reload_module("lazy-lsp")

require("lazy-lsp").setup {
  excluded_servers = {
    -- "als", -- getting warning, workaround for https://github.com/dundalek/lazy-lsp.nvim/issues/47

    -- Curated recommendations
    "ccls",                            -- prefer clangd
    "denols",                          -- prefer eslint and tsserver
    "docker_compose_language_service", -- yamlls should be enough?
    "flow",                            -- prefer eslint and tsserver
    -- "ltex",                            -- grammar tool using too much CPU
    "quick_lint_js",                   -- prefer eslint and tsserver
    "scry",                            -- archived on Jun 1, 2023
    "tailwindcss",                     -- associates with too many filetypes

    "solargraph", "syntax_tree",

    "bashls",

    "sourcekit",
    -- configured manually due to having issues installing it via nix
    "clojure_lsp",
  },
  preferred_servers = {
    markdown = { "efm", "ltex" },
    python = { "pyright", "ruff_lsp" },
  },
  prefer_local = true,
  default_config = {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    },
    capabilities = capabilities,
  },
  configs = {
    -- https://github.com/bash-lsp/bash-language-server/issues/104#issuecomment-848052436
    efm = {
      filetypes = { "markdown", "sh", "vim" },
      -- on_attach = function(client, bufnr)
      --   local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
      --   local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
      --
      --   -- Mappings.
      --   local opts = { noremap = true, silent = true }
      -- end,
      init_options = {
        documentFormatting = true,
        documentSymbol = true,
        hover = true,
      },
      settings = {
        rootMarkers = { ".git/" },
        languages = {
          markdown = {
            { symbolCommand = "markdown-symbols" },
            -- add dummy hover command which symbols-outline plugin expects
            { hoverCommand = "echo" },
          },
          sh = {
            {
              lintCommand = "shellcheck -f gcc -x",
              lintSource = "shellcheck",
              lintFormats = { "%f:%l:%c: %trror: %m", "%f:%l:%c: %tarning: %m",
                "%f:%l:%c: %tote: %m" },
            },
          },
          vim = {
            { symbolCommand = "vim-marker-symbols" },
            -- add dummy hover command which symbols-outline plugin expects
            { hoverCommand = "echo" },
          },
        },
      },
      on_new_config = function(new_config)
        -- Override used packages to add additional dependencies
        local nix_pkgs = { "efm-langserver", "shellcheck" }
        new_config.cmd = require("lazy-lsp").in_shell(nix_pkgs, new_config.cmd)
      end,
    },
    jsonls = {
      on_new_config = function(config)
        config.settings = {
          json = {
            schemas = require('schemastore').json.schemas(),
            validate = { enable = true },
          },
        }
      end,
    },
    lua_ls = {
      settings = {
        Lua = {
          -- shouldn't be needed with neodev.nvim
          diagnostics = {
            -- Get the language server to recognize the `vim` global
            globals = { 'vim' },
          },
          format = {
            enable = true,
            defaultConfig = {
              align_continuous_assign_statement = "false",
              align_continuous_rect_table_field = "false",
              align_array_table = "false",
            },
          },
        },
      },
    },
    ltex = {
      -- Have ltext enabled, but don't start it by default
      -- Can start it explicitly with :LspStart
      autostart = false,
    },
  },
}

lspconfig.clojure_lsp.setup {
  -- Override the defaut config to set root in the top-level of a monorepo
  root_dir = function(filename)
    return lspconfig.util.root_pattern(".git")(filename) or
        lspconfig.util.root_pattern("deps.edn", "project.clj")(filename)
  end,
  -- cmd = { "clojure-lsp", "--trace-level", "verbose", "--log-path", "/tmp/clojure-lsp.log" },
  on_attach = function(client, bufnr)
    -- Do not attach in conjure logs, inspired by
    -- https://github.com/Olical/conjure/issues/571
    local bufname = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(bufnr), ":t")
    local is_conjure_log = string.sub(bufname, 1, 12) == "conjure-log-"
    if is_conjure_log then
      vim.lsp.buf_detach_client(bufnr, client.id)
    else
      on_attach(client, bufnr)
    end
  end,
  flags = {
    debounce_text_changes = 150,
  },
  capabilities = capabilities,
}

---- Markdown {{{1

-- Plugin with markdown folding is built-in, just enable folding support
vim.g.markdown_folding = 1

vim.cmd([[
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
]])

---- Clojure {{{1

vim.cmd([[
augroup lang_clojure
  autocmd!
  " set nolinebreak because line break at words boundary bugs out with parinfer
  autocmd FileType clojure
    \ nnoremap <LocalLeader>s :ConjureShadowSelect
    \| nnoremap <LocalLeader>el :ConjureLogToggle<cr>
    \| nnoremap <LocalLeader>ev :ConjureLogVSplit<cr>
    \| set nolinebreak
augroup END
]])

vim.cmd([[
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
]])

-- Space menu {{{1

---- Git {{{1

-- Open lazygit in a floating window
-- local lazygit = require('FTerm'):new({ cmd = 'lazygit', dimensions = { height = 1, width = 1 } })

---- Command palette - legendary.nvim {{{1

-- clear out so there are no duplicates when config is reloaded
require("legendary.data.state").items = require("legendary.data.itemlist"):create()

-- `setup()` must be called before `require('which-key).register()`
local legendary_format = require("legendary.ui.format").default_format
require("legendary").setup {
  extensions = {
    which_key = {
      -- try to register only once to avoid duplicates on reload
      -- for some reason this workaround does not work completely, there are two duplicates after reload, but at least it does not grow unbounded
      auto_register = global_legendary_auto_registered == nil,
    },
  },
  default_item_formatter = function(item)
    -- swap description with command definition
    local icon, cmd, desc = table.unpack(legendary_format(item))
    return { icon, desc, cmd }
  end,
}
global_legendary_auto_registered = true

require("dressing").setup {
  select = {
    get_config = function(opts)
      -- the whole point of the override is to make the legendary window larger so that descriptions can fit and are visible
      if opts.kind == "legendary.nvim" then
        return {
          telescope = {
            sorting_strategy = "ascending",
            layout_strategy = "center",
            results_title = false,
            layout_config = {
              prompt_position = "top",
              width = 0.8,
              height = 0.6,
            },
          },
        }
      else
        return {}
      end
    end,
  },
}

vim.keymap.set("n", "<leader><leader>", ":Legendary<cr>", {
  silent = true,
  desc = "Command Palette (Legendary)",
})

-- Register non-frequent command without bindings with legendary to be searchable in command menu
require("legendary").commands {
  { ":g/^\\s*$/d", description = "Delete blank lines" },
  { ":! chmod +x %", description = "Make current file executable" },
  { description = "Buffers: Close other", ":%bd|e#" },
  { ":ConjureShadowSelect app", description = "Conjure shadow select app" },
  { ":ConjureShadowSelect {name}", description = "Conjure shadow select", unfinished = true },
  { ":ConjureConnect {port}", description = "Conjure: Connect", unfinished = true },
  { ":ConjureConnect 48888", description = "Conjure: Pitch Backend REPL" },
  { ":ConjureConnect 7888", description = "Conjure: Pitch Frontend REPL" },
  { ":ConjureConnect 1667", description = "Conjure: Babashka REPL" },
  -- Evaling alert to verify REPL is working and locate which browser provides runtime
  { ':ConjureEval (js/alert "Hello!")', description = "Conjure eval alert" },
  { ":Telescope builtin", description = "Telescope bultins" },
  { ":lua vim.lsp.buf.incoming_calls()", description = "LSP incoming calls" },
  { ":lua vim.lsp.buf.outgoing_calls()", description = "LSP outgoing calls" },
  -- enew+execute is to pipe result into buffer to make it searchable
  -- { ":enew|pu=execute('lua print(vim.inspect(vim.lsp.get_active_clients()))')", description = 'LSP client capabilities' },
  {
    ":lua vim.g.disable_lsp_formatting = not vim.g.disable_lsp_formatting",
    description = "LSP toggle formatting on save",
  },
  { description = "Diagnostics: Toggle document issues", ":TroubleToggle document_diagnostics" },
  { description = "Diagnostics: Toggle workspace issues", ":TroubleToggle workspace_diagnostics" },
  { ":DownToggleListItem", description = "Markdown: Toggle list item" },
  { ":DownMakeLink", description = "Markdown: Create link" },
  -- { ':split term://fish', description = 'Toggle Terminal' },
  { ":Neotree source=buffers", description = "NeoTree: Opened buffers" },
  { ":Neotree source=document_symbols", description = "NeoTree: LSP - Document Symbols" },
  { ":InspectTree", description = "Treesitter: Inspect tree" }, -- :help inspect_tree
  { ":DiffviewOpen", description = "Git: Diff View Open" },
  { ":DiffviewClose", description = "Git: Diff View Close" },
  { ":DiffviewFileHistory", description = "Git: Diff View File History" },
}

require("legendary").funcs {
  { description = "Buffers: Close unedited", require("hbac").close_unpinned },
  {
    function() vim.opt_local.spell = not vim.opt_local.spell end,
    description = "Toggle spell check",
  },
  {
    description = "Clojure: Open Portal",
    function()
      require("conjure.eval").command([[
        (do
          (ns dev)
          (def portal ((requiring-resolve 'portal.api/open)))
          (add-tap (requiring-resolve 'portal.api/submit)))
      ]])
    end,
  },
  {
    description = "Clojure: Close Portal",
    function()
      require("conjure.eval").command([[
        (do
          (remove-tap (requiring-resolve 'portal.api/submit))
          ((requiring-resolve 'portal.api/close)))
      ]])
    end,
  },
  {
    description = "Clojure: Open Morse",
    function()
      require("conjure.eval").command([[
        ((requiring-resolve 'dev.nu.morse/launch-in-proc))
      ]])
    end,
  },
  {
    description = "Toggle Dark/Light background",
    function()
      if vim.o.background == "light" then
        vim.cmd([[colorscheme tokyonight]])
        vim.o.background = "dark"
      else
        vim.cmd([[colorscheme github_light]])
        vim.o.background = "light"
      end
    end,
  },
  {
    description = "Toggle Diagnostics",
    function()
      if vim.diagnostic.is_disabled() then
        vim.diagnostic.enable()
      else
        vim.diagnostic.disable()
      end
    end,
  },
}

--[[
vim.lsp.set_log_level("debug")
]]
-- Add Telescope builtin to Command Pallete
for k, v in pairs(require("telescope.builtin")) do
  require("legendary").command { ":Telescope " .. k, description = "Telescope: " .. k }
end

-- Add Telescope extensions to Command Pallete
for ext, funcs in pairs(require("telescope").extensions) do
  for func_name, func_obj in pairs(funcs) do
    -- Only include exported functions whose name doesn't begin with an underscore
    if type(func_obj) == "function" and string.sub(func_name, 0, 1) ~= "_" then
      require("legendary").command {
        ":Telescope " .. ext .. " " .. func_name,
        description = "Telescope: " .. ext .. " : " .. func_name,
      }
    end
  end
end

---- which-key.nvim {{{1

local wk = require("which-key")

-- Register group labels separately so that legendary.nvim does not nest items but shows them in a flat list
wk.register({
  f = { name = "Find" },
  g = { name = "Git" },
  h = { name = "Git Hunks" },
  j = { name = "Jump" },
  l = { name = "Lsp" },
  m = { name = "Markdown" },
  t = { name = "Toggle" },
}, { prefix = "<leader>" })

-- other commands like moving forward/backward do not seem to work that well
-- local tc = require("nvim-treeclimber")
-- vim.keymap.set({ "n" }, "vv", tc.select_expand, { desc = "TreeClimber: Expand Selection" })
-- vim.keymap.set({ "v" }, "v", tc.select_expand, { desc = "TreeClimber: Expand Selection" })
-- vim.keymap.set({ "v" }, "z", tc.select_shrink, { desc = "TreeClimber: Shrink Selection" })


vim.keymap.set({ 'n' }, '<C-a>', 'ggVG', { noremap = true, silent = true, desc = "Select All Text" })

require("gitsigns").setup {
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map("n", "]c", function()
      if vim.wo.diff then
        return "]c"
      end
      vim.schedule(function() gs.next_hunk() end)
      return "<Ignore>"
    end, { expr = true })

    map("n", "[c", function()
      if vim.wo.diff then
        return "[c"
      end
      vim.schedule(function() gs.prev_hunk() end)
      return "<Ignore>"
    end, { expr = true })

    -- Actions
    map(
      "v",
      "<leader>hs",
      function() gs.stage_hunk { vim.fn.line("."), vim.fn.line("v") } end,
      { desc = "Git: Visual Stage Hunk" }
    )
    map(
      "v",
      "<leader>hr",
      function() gs.reset_hunk { vim.fn.line("."), vim.fn.line("v") } end,
      { desc = "Git: Visual Reset Hunk" }
    )

    -- Text object
    map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
  end,
}

local gs = require("gitsigns")
wk.register {
  ["<leader>hs"] = { gs.stage_hunk, "Git: Stage Hunk" },
  ["<leader>hr"] = { gs.reset_hunk, "Git: Reset Hunk" },
  ["<leader>hS"] = { gs.stage_buffer, "Git: Stage Buffer" },
  ["<leader>hu"] = { gs.undo_stage_hunk, "Git: Undo Stage Hunk" },
  ["<leader>hR"] = { gs.reset_buffer, "Git: Reset Buffer" },
  ["<leader>hp"] = { gs.preview_hunk, "Git: Preview Hunk" },
  ["<leader>hb"] = { function() gs.blame_line { full = true } end, "Git: Blame Line" },
  ["<leader>tb"] = { gs.toggle_current_line_blame, "Git: Toggle Current Line Blame" },
  ["<leader>hd"] = { gs.diffthis, "Git: Diff This" },
  ["<leader>hD"] = { function() gs.diffthis("~") end, "Git: Diff This Base" },
  ["<leader>td"] = { gs.toggle_deleted, "Git: Toggle Show Deleted Hunks" },
}
wk.register {
  ["<leader>."] = { "<cmd>e $MYVIMRC<cr>", "open init" },
  ["gq"] = { "Wrap text" },
  -- Prefer key sequence over chording
  -- it works but does not show which key menu for window
  ["<leader>w"] = { "<c-w>", "+Window" },
  ["<leader>b"] = { "<cmd>:Neotree toggle=true<CR>", "NeoTree: Toggle file panel" },
  ["<leader><bslash>"] = { "<cmd>:Neotree toggle=true<CR>", "NeoTree: Toggle file panel" },
  ["<C-bslash>"] = { "<cmd>:Neotree reveal=true<CR>", "NeoTree: Revel current file" },
  ["<C-p>"] = { ":FZF<cr>", "FZF: Find file" },
  ["<C-b>"] = { ":Buffers<cr>", "FZF: Switch Buffer" },
  ["<leader>fb"] = { ":Buffers<cr>", "Switch Buffer" },
  ["<leader>ff"] = { ":Files<cr>", "Find File" },
  ["<leader>fg"] = { ":RG<cr>", "Grep Files" },
  ["<leader>fc"] = { ":Commands<cr>", "Find Command" },
  ["<leader>fs"] = { ":Telescope lsp_workspace_symbols<cr>", "Find Workspace Symbol" },
  ["<leader>fo"] = { ":Telescope lsp_document_symbols<cr>", "Find document Symbol" },
  ["<leader>fe"] = { ":Telescope live_grep<cr>", "Telescope: Grep files" },
}

wk.register({
  ["/"] = { "<cmd>Telescope live_grep<cr>", "Telescope: Grep files" },
  [","] = { "<cmd>Telescope buffers<cr>", "Telescope: Find files" },
  [";"] = { "<cmd>Telescope find_files<cr>", "Telescope: Find files" },
  [":"] = { "<cmd>Telescope command_history<cr>", "Telescope: Command History" },
  f = {
    h = { "<cmd>Telescope help_tags<cr>", "Find in Help" },
    x = { require("telescope.builtin").resume, "Telescope: Resume last picker" },
    y = { "<cmd>Telescope command_history<cr>", "Find in command history" },
    -- ["<leader>ff"] = { "<cmd>Telescope find_files<cr>", "Find File" },
    -- ["<leader>fr"] = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
    -- ["<leader>fn"] = { "<cmd>enew<cr>", "New File" },
  },
  g = {
    -- l = {"<cmd>Git blame<cr>", "Git: Blame" },
    b = { "<cmd>Telescope git_branches<cr>", "Git: Branches" },
    -- d = { "<cmd>:SignifyHunkDiff<cr>", "Git: Hunk Diff" },
    -- U = { "<cmd>:SignifyHunkUndo<cr>", "Git: Undo Hunk" },
    l = { function() require("git.blame").blame() end, "Git: Blame" },
    h = { function() require("git.browse").open(false) end, "Git: Browse" },
    -- g = { function() lazygit:toggle() end, "Git: Lazygit" },
    g = { function() lazygit_terminal:toggle() end, "Git: Lazygit" },
  },
  j = {
    j = { "<cmd>:Buffers<cr>", "Buffers" },
    k = { "<cmd>:Neotree toggle=true<cr>", "File Tree: Toggle" },
    l = { "<cmd>:Neotree reveal=true<cr>", "File Tree: Reveal current" },
    d = { "<cmd>:lua require('telescope').extensions.zoxide.list()<cr>", "Jump to directory" },
  },
  l = {
    c = { "<cmd>:ConjureConnect<cr>", "Conjure: Connect to REPL" },
    -- bind it outside of on_attach to use for debugging
    l = { "<cmd>LspInfo<cr>", "Lsp: Show Info" },
    L = { function() vim.cmd(":e " .. vim.lsp.get_log_path()) end, "Lsp: Show Log" },
  },
  -- TODO: Figure out how to bind these via autocmd
  m = {
    p = { "<cmd>MarkdownPreview<cr>", "Markdown: Preview" },
    t = { "<cmd>GenTocGFM<cr>", "Markdown: Generate TOC Table of Contents" },
  },
  t = {
    l = { "<cmd>:Lazy<cr>", "Toggle Lazy package manager" },
    -- t = { "<cmd>:ToggleTerm<cr>", "Terminal" },
    t = { function() bottom_terminal:toggle() end, "Toggle Terminal" },
    -- c = { "<cmd>:lua require('FTerm').scratch({ cmd = {'chatgpt', '-n'} })<cr>", "ChatGPT" },
    c = { function() chatgpt_terminal:open() end, "ChatGPT" },
    -- f = { tc.show_control_flow, "TreeCliber: Show Control Flow" },
  },
  w = {
    m = { "<Cmd>:WinShift<CR>", "Move" },
  },
}, { prefix = "<leader>" })

wk.register({
  e = {
    -- mark some form with K, shortharnd to eval it with i<localleader>ek nstead of <localleader>emK (mainly avoiding need to hold shift)
    k = { function()
      vim.schedule(function() require("conjure.eval")["marked-form"]("K") end)
    end, "Eval marKed form K" },
    -- Conjure omits exception stacktrace by default, add a shorthad eval the exception to get to the stacktrace
    x = { "<cmd>:ConjureEval *e<cr>", "Eval REPL exception" },
    t = { "<cmd>:ConjureEval (tap> *1)<cr>", "Eval: Tap last value" },
  },
  r = { "<cmd>:set relativenumber!<cr>", "Toggle relative line numbers" },
  t = {
    t = {
      "<cmd>:ConjureEval (kaocha.repl/run {:kaocha/reporter [kaocha.report/documentation]})<cr>",
      "Run tests in REPL with kaocha",
    },
  },
}, { prefix = "<localleader>" })
