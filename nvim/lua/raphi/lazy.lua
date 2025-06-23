local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    -- -------
    -- General
    -- -------

    -- Fuzzy finder
	{
		'nvim-telescope/telescope.nvim',
		tag = '0.1.4',
		dependencies = { 'nvim-lua/plenary.nvim' }
	},
    -- AST repr, used for better syntax highlightin
	{"nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
    -- Colorscheme
	{'rose-pine/neovim', name = 'rose-pine' },

    -- tmux integration
    {
      "christoomey/vim-tmux-navigator",
      cmd = {
        "TmuxNavigateLeft",
        "TmuxNavigateDown",
        "TmuxNavigateUp",
        "TmuxNavigateRight",
        "TmuxNavigatePrevious",
        "TmuxNavigatorProcessList",
      },
      keys = {
        { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
        { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
        { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
        { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
        { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
      },
    },

	--- LSP config
	{'williamboman/mason.nvim'},
	{'williamboman/mason-lspconfig.nvim'},
	{'VonHeikemen/lsp-zero.nvim', branch = 'v3.x'},
	{'neovim/nvim-lspconfig'},
    -- Completion engine
	{'hrsh7th/cmp-nvim-lsp'},
	{'hrsh7th/nvim-cmp'},

    -- Snippets engine
	{'L3MON4D3/LuaSnip'},

    -- Nicer status line
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' }
    },
    -- Auto close paren, brackets, etc
    {'windwp/nvim-autopairs', event = "InsertEnter", opts = {}},
    -- Highlight and serach TODOes, FIXMEs, etc...
    {"folke/todo-comments.nvim", dependencies = { "nvim-lua/plenary.nvim" }, opts = {} },
    -- Quickfix window improvements
    {"folke/trouble.nvim", tag = 'v3.6.0' },
    -- Git integration
    {'tpope/vim-fugitive'},

    -- ------
    -- Python
    -- ------

    -- Venv handling
	{'jmcantrell/vim-virtualenv'},
})
