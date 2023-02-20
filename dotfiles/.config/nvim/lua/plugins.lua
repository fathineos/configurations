local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Install your plugins here
return packer.startup(function(use)
  -- My plugins here
  use "wbthomason/packer.nvim" -- Have packer manage itself
  use "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins
  use "scrooloose/nerdcommenter"
  use "kyazdani42/nvim-web-devicons"
  use "kyazdani42/nvim-tree.lua"
  use "scrooloose/nerdtree"
  use "ruanyl/vim-gh-line"
  use "majutsushi/tagbar"
  use "tmhedberg/SimpylFold"
  use "airblade/vim-gitgutter"
  use "lukas-reineke/indent-blankline.nvim"
  
  -- Tmux integration
  -- Navigate between tmux panes and vim splits seamlessly
  use "christoomey/vim-tmux-navigator"

  -- FocusGained and FocusLost autocommand events while in tmux. To
  -- autoreload externally modified files
  use "tmux-plugins/vim-tmux-focus-events"

  use "junegunn/fzf.vim"
  use "junegunn/fzf"

  -- Colorschemes
  use "morhetz/gruvbox"
  use "arcticicestudio/nord-vim"
  use "rakr/vim-two-firewatch"
  use "endel/vim-github-colorscheme"
  use "wimstefan/Lightning"

  -- snippets
  use "L3MON4D3/LuaSnip"                     --snippet engine
  use "rafamadriz/friendly-snippets"

  -- Completion
  use {
    "ms-jpq/coq_nvim",
    branch = "coq",
    event = "VimEnter",
    opt = true,
    run = ":COQdeps",
    config = function()
      require("config.coq").setup()
    end,
    requires = {
      { "ms-jpq/coq.artifacts", branch = "artifacts" },
      { "ms-jpq/coq.thirdparty", branch = "3p", module = "coq_3p" },
    },
    disable = false,
  }

  use {
      "hrsh7th/nvim-cmp",
      event = "InsertEnter",
      opt = true,
      config = function()
        require("config.cmp").setup()
      end,
      wants = { "LuaSnip" },
      requires = {
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-cmdline",
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-nvim-lsp",
        {
          "L3MON4D3/LuaSnip",
          wants = "friendly-snippets",
          config = function()
            require("config.luasnip").setup()
          end,
        },
        "rafamadriz/friendly-snippets",
      },
      disable = true,
    }

  use {
    "neovim/nvim-lspconfig",
    opt = true,
    event = "BufReadPre",
    wants = { "nvim-lsp-installer", "lsp_signature.nvim", "coq_nvim" },  -- for coq.nvim
    config = function()
      require("config.lsp").setup()
    end,
    requires = {
      "williamboman/nvim-lsp-installer",
      "ray-x/lsp_signature.nvim",
    },
  }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
