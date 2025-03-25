--[[

Set up:
1. Copy this file into ~/.config/nvim/init.lua
2. After opening nvim, run the command `:Lazy install`

]]--

-- Set misc configs START
vim.opt.number = true -- Turn on absolute line numbers
vim.opt.formatoptions:remove("o") -- Don't continue comments with 'o' or 'O'
vim.opt.formatoptions:remove("r") -- Don't continue comments when pressing Enter
vim.opt.formatoptions:remove("c") -- Don't auto-wrap comments
vim.opt.cursorline = true -- highlight cursorline
-- Set misc configs END

-- 🔥 Key Mappings START
vim.g.mapleader = " "
vim.keymap.set("n", "<Leader>w", ":w<CR>", { silent = true })
vim.keymap.set("n", "<Leader>q", ":q<CR>", { silent = true })
vim.keymap.set("n", "<C-z>", "<Nop>", { silent = true })
vim.keymap.set("i", ";;", "<Esc>", { silent = true })
-- 🔥 Key Mappings END

-- Bootstrap lazy.nvim START
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
-- Bootstrap lazy.nvim END


-- Setup lazy.nvim START
require("lazy").setup({
  spec = {
    {
      "nvim-tree/nvim-tree.lua",
      version = "*",
      lazy = false,
      dependencies = {
        "nvim-tree/nvim-web-devicons",
      },
      config = function()
        require("nvim-tree").setup {
          sort = { 
            sorter = "case_sensitive",
          },
          view = { 
            width = 30, 
          },  
          renderer = { 
            group_empty = true,
          },  
          filters = { 
            dotfiles = true,
          },
        }
      end,
    },
    {
      "junegunn/fzf.vim",
      dependencies = {
        "junegunn/fzf",
      },
    },
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})
-- Setup lazy.nvim END

-- nvim-tree/nvim-tree.lua START
-- disable netrw at the very start of your init.lua
-- ref: https://github.com/nvim-tree/nvim-tree.lua/blob/c09ff35de503a41fa62465c6b4ae72d96e7a7ce4/doc/nvim-tree-lua.txt#L2978
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true
vim.keymap.set("n", "<Leader>n", ":NvimTreeToggle<CR>", { silent = true })
-- nvim-tree/nvim-tree.lua END

-- junegunn/fzf.vim START
vim.keymap.set("n", "<Leader>f", ":FZF<CR>", { silent = true })  -- search for files
vim.keymap.set("n", "<Leader>r", ":Rg<CR>", { silent = true })  -- search for strings
-- junegunn/fzf.vim END
