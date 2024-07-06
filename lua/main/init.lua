--Plug
vim.cmd([[
call plug#begin()


" LSP Support
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'L3MON4D3/LuaSnip'
Plug 'VonHeikemen/lsp-zero.nvim', {'branch': 'v3.x'}

" Vim devfonts
Plug 'ryanoasis/vim-devicons'

" Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#show_splits = 1
let g:airline_theme = 'distinguished'

" nvim-web-devicons
Plug 'nvim-tree/nvim-web-devicons'

" Nerd comments
Plug 'scrooloose/nerdcommenter'
let g:NERDCreateDefaultMappings = 1
let g:NERDSpaceDelims = 1
let g:NERDDefaultAlign = 'left'

" Comment.nvim
Plug 'numToStr/Comment.nvim'

" Bufdelete
Plug 'moll/vim-bbye'

" Scrollbar
Plug 'petertriho/nvim-scrollbar'

" nvim-tree
Plug 'nvim-tree/nvim-tree.lua'

" Nerdtree
"Plug 'scrooloose/nerdtree'

" Make yank highlighted
Plug 'machakann/vim-highlightedyank'

" Zoom win
Plug 'troydm/zoomwintab.vim'

" Intend blankline
Plug 'lukas-reineke/indent-blankline.nvim'

" Gitsigns
Plug 'lewis6991/gitsigns.nvim'

" Black
Plug 'psf/black', { 'branch': 'stable'}
let g:black_linelength = 120

" Colortheme
Plug 'EdenEast/nightfox.nvim'

" Telescope
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
" Plug 'nvim-telescope/telescope-file-browser.nvim'

" Treesitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-textobjects'

" Ansible
Plug 'pearofducks/ansible-vim'

" Marks
Plug 'chentoast/marks.nvim'

" Github copilot
Plug 'github/copilot.vim'

" Suround brackets
Plug 'kylechui/nvim-surround'

" Toggle terminal
Plug 'akinsho/toggleterm.nvim', {'tag' : '*'}

call plug#end()
]])

-- Set notimeout
vim.g.notimeout = true

-- Set encoding
vim.opt.encoding = "utf-8"

-- disable netrw at the very start
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- realtive number
vim.opt.number = true
vim.opt.relativenumber = true

-- Extra options
vim.opt.hidden = true
vim.opt.hlsearch = true
-- vim.opt.autochdir = true

-- Set mapleader
vim.g.mapleader = " "

-- Set ex mapping
-- vim.keymap.set("n", "<leader>e", vim.cmd.Ex)

-- Copy to clipboard
vim.keymap.set("v", "<leader>y", "\"+y", {noremap = true})
vim.keymap.set("n", "<leader>y", "\"+y", {noremap = true})
vim.keymap.set("v", "<leader>p", "\"+P", {noremap = true})
vim.keymap.set("n", "<leader>p", "\"+p", {noremap = true})

-- Move between windows in terminal
-- disabled cause it's triggers when I try to delete word in terminal
-- vim.keymap.set("t", "<C-w>", "<C-\\><C-n><C-w>", {noremap = true})
-- Exit terminal input mode
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", {noremap = true})

-- Telescope file browser
-- require("telescope").setup {
--   extensions = {
--     file_browser = {
--       -- theme = "ivy",
--       -- disables netrw and use telescope-file-browser in its place
--       hijack_netrw = true,
--       mappings = {
--         ["i"] = {
--           -- your custom insert mode mappings
--         },
--         ["n"] = {
--           -- your custom normal mode mappings
--         },
--       },
--     },
--   },
-- }


-- Find files and grep files
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>fm', builtin.marks, {})
vim.keymap.set('n', '<leader>fr', builtin.registers, {})
-- vim.keymap.set('n', '<leader>fd', ":Telescope file_browser<CR>", {noremap = true})

-- Window zoom
vim.keymap.set("n", "<C-w>z", vim.cmd.ZoomWinTabToggle, {noremap = true})


-- NERDTree
-- vim.keymap.set("n", "<leader>b", vim.cmd.NERDTreeToggle)
vim.keymap.set("n", "<leader>b", vim.cmd.NvimTreeToggle)

-- Buffer switching
vim.keymap.set("n", "<C-h>", vim.cmd.bprev)
vim.keymap.set("n", "<C-l>", vim.cmd.bnext)
vim.keymap.set("n", "<C-q>", vim.cmd.Bdelete)

-- LSP config
local lsp_zero = require('lsp-zero')
lsp_zero.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp_zero.default_keymaps({buffer = bufnr})
end)
require'lspconfig'.pylsp.setup{
  settings = {
    pylsp = {
      configurationSources = {'flake8', 'pycodestyle', 'mccabe', 'pyflakes'},
      plugins = {
        flake8 = {
          enabled = true,
          -- ignore = {'E501'},
          perFileIgnores = {
            '/home/alex/Projects/ansible_collections/community/general/plugins/modules/*: E501,E402',
            '/home/alex/Projects/ansible_collections/community/general/tests/unit/plugins/modules/*: E501,E402'
          }
        },
        pycodestyle = {
          enabled = false
        },
        mccabe = {
          enabled = false
        },
        pyflakes = {
          enabled = false
        },
        black = {
          enabled = true,
          lineLength = 120
        }
      }
    }
  }
}
-- Formatting keymap
vim.keymap.set('n', '<leader>df', ': lua vim.lsp.buf.format()<CR>', {noremap = true})

-- Golang lsp
require'lspconfig'.gopls.setup{}


-- Ansible lsp
require'lspconfig'.ansiblels.setup{
  ansible = {
    ansible = {
      path = "ansible"
    },
    executionEnvironment = {
      enabled = false
    },
    python = {
      interpreterPath = "python3"
    },
    validation = {
      enabled = true,
      lint = {
        enabled = true,
        path = "ansible-lint"
      }
    }
  }
}


-- Treesitter
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
  ensure_installed = { "python", "yaml", "bash", "lua", "json", "toml", "dockerfile", "html", "css", "go"},

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,


  highlight = {
    enable = true,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}

-- toggleterm setup
require("toggleterm").setup{
 direction = "tab",
 open_mapping = [[<c-\>]],
 autochdir = true,
 start_in_insert = true,
}

-- Git signs
require('gitsigns').setup()

-- Indent-blankline
require("ibl").setup()

-- colorscheme
vim.cmd.colorscheme('carbonfox')

-- scrollbar
require("scrollbar.handlers.gitsigns").setup()
require("scrollbar").setup()

-- nvim-surround
require("nvim-surround").setup({})

-- empty setup using defaults
require("nvim-tree").setup({
  diagnostics = {
    enable = true,
  }
})

-- Comment.nvim
require('Comment').setup()

