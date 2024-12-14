" ===== Basic Settings =====
set number                    " Show line numbers
set relativenumber             " Show relative line numbers
set expandtab                  " Use spaces instead of tabs
set shiftwidth=4               " Indent by 4 spaces
set tabstop=4                  " Set tab size to 4 spaces
set smartindent                " Automatically indent
set cursorline                 " Highlight the current line
set clipboard=unnamedplus      " Use system clipboard
set ignorecase                 " Ignore case when searching
set smartcase                  " Case-sensitive if uppercase is used
set wrap                       " Enable line wrapping
set mouse=a                    " Enable mouse support

" ===== Plugin Manager (vim-plug) =====

" Disable Neovim's default startup message
set shortmess+=I
" Install dashboard-nvim using vim-plug
call plug#begin('~/.vim/plugged')
Plug 'glepnir/dashboard-nvim'
call plug#end()


" Everforest theme
Plug 'sainnhe/everforest'
" Transparent background
augroup transparent_bg
  autocmd!
  autocmd ColorScheme * highlight Normal ctermbg=none guibg=none
  autocmd ColorScheme * highlight NonText ctermbg=none guibg=none
  autocmd ColorScheme * highlight SignColumn ctermbg=none guibg=none
  autocmd ColorScheme * highlight StatusLine ctermbg=none guibg=none
  autocmd ColorScheme * highlight LineNr ctermbg=none guibg=none
augroup END







" ===== Dashboard Configuration =====
let g:dashboard_default_executive = 'telescope'    " Use Telescope for file searching
let g:dashboard_custom_header = [
\   '     _____   _    _   ____     _____    ______   _____  ',
\   '    |  __ \ | |  | | / __ \   |  __ \  |  ____|/ ____| ',
\   '    | |  | || |  | || |  | |  | |  | | | |__  | (___    ',
\   '    | |  | || |  | || |  | |  | |  | | |  __|  \___ \   ',
\   '    | |__| || |__| || |__| |  | |__| | | |____ ____) |  ',
\   '    |_____/  \____/  \____/   |_____/  |______|_____/   ',
\ ]

" Set the recent files section
let g:dashboard_custom_section = {
\   'a': { 'description': '[E]nter File', 'command': 'e ' },
\   'b': { 'description': '[S]earch Files', 'command': 'Telescope find_files' },
\   'c': { 'description': '[R]ecent Files', 'command': 'Telescope oldfiles' },
\   'd': { 'description': '[Q]uit', 'command': 'quit' },
\ }

" Customize the dashboard layout
let g:dashboard_custom_footer = [
\   '                   Welcome to Neovim!                     ',
\ ]










" LSP support (for Python, C, and C++)
Plug 'neovim/nvim-lspconfig'  " LSP Configurations
Plug 'hrsh7th/nvim-cmp'       " Completion plugin
Plug 'hrsh7th/cmp-nvim-lsp'   " LSP Completion source
Plug 'hrsh7th/cmp-buffer'     " Buffer Completion source
Plug 'hrsh7th/cmp-path'       " Path Completion source
Plug 'saadparwaiz1/cmp_luasnip' " LuaSnip completion source
Plug 'L3MON4D3/LuaSnip'        " Snippet engine

" Python, C, and C++ linters and formatters
Plug 'dense-analysis/ale'      " Asynchronous Lint Engine
Plug 'jiangmiao/auto-pairs'    " Auto pairs for parentheses, brackets, etc.

" ===== Initialize Plugins =====
call plug#end()

" ===== Theme Configuration =====
colorscheme everforest         " Set Everforest theme
set background=dark            " Dark background for the theme

" ===== Language Server Protocol (LSP) Setup =====
" Python (using pyright)
lua << EOF
require'lspconfig'.pyright.setup{}
EOF

" C/C++ (using clangd)
lua << EOF
require'lspconfig'.clangd.setup{}
EOF

" ===== Auto-completion Configuration =====
lua << EOF
local cmp = require'cmp'

cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<Tab>'] = cmp.mapping(function(fallback)
      if vim.fn.pumvisible() == 1 then
        -- Complete with Tab if completion is visible
        cmp.mapping.select_next_item()(fallback)
      else
        -- Otherwise, use Tab to indent
        fallback()
      end
    end, {'i', 's'}),    -- Insert mode and select mode for Tab

    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if vim.fn.pumvisible() == 1 then
        -- Select previous item in completion
        cmp.mapping.select_prev_item()(fallback)
      else
        -- Otherwise, Shift+Tab to decrease indent
        fallback()
      end
    end, {'i', 's'}),    -- Insert mode and select mode for Shift+Tab

    ['<C-Space>'] = cmp.mapping.complete(),  -- Trigger completion manually with Ctrl+Space
    ['<C-e>'] = cmp.mapping.close(),         -- Close completion
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'buffer' },
    { name = 'path' },
  })
})
EOF

" ===== ALE Configuration (Linter and Formatter) =====
let g:ale_linters = {
\   'python': ['flake8', 'pylint'],
\   'c': ['clang'],
\   'cpp': ['clang'],
\}
let g:ale_fixers = {
\   'python': ['autopep8', 'black'],
\   'c': ['clang-format'],
\   'cpp': ['clang-format'],
\}
let g:ale_fix_on_save = 1
let g:ale_lint_on_text_changed = 'never'

" ===== Auto Pairs for Parentheses =====
let g:AutoPairs = {'(': ')', '[': ']', '{': '}', '"': '"', "'": "'"}

" ===== Additional Settings =====
set updatetime=300             " Faster updates
set timeoutlen=500             " Time for key mappings

