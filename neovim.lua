--[[

Set up:
1. Copy this file into ~/.config/nvim/init.lua
```
mkdir -p ~/.config/nvim
cp ./neovim.lua ~/.config/nvim/init.lua
```
2. After opening nvim, run the command `:Lazy install`

]]--

-- Set misc configs START
vim.opt.number = true -- Turn on absolute line numbers
vim.opt.formatoptions:remove("o") -- Don't continue comments with 'o' or 'O'
vim.opt.formatoptions:remove("r") -- Don't continue comments when pressing Enter
vim.opt.formatoptions:remove("c") -- Don't auto-wrap comments
vim.opt.cursorline = true -- highlight cursorline
vim.opt.tabstop = 8       -- A tab character is 8 spaces wide
vim.opt.shiftwidth = 4    -- Indent levels are 4 spaces
vim.opt.expandtab = true  -- Use spaces instead of tabs
vim.opt.smarttab = true
vim.opt.softtabstop = 0
vim.opt.hlsearch = true  -- Highlight matching search patterns
vim.opt.ignorecase = true  -- Include matching uppercase words with lowercase search term
vim.opt.smartcase = true  -- Include only uppercase words with uppercase search term
vim.opt.mouse = ""  -- enable mouse for all modes
-- Set misc configs END

-- 🔥 Key Mappings START
vim.g.mapleader = " "
vim.keymap.set("n", "<Leader>w", ":w<CR>", { silent = true })
vim.keymap.set("n", "<Leader>W", ":wall<CR>", { silent = true, desc = "save all edited files" })
vim.keymap.set("n", "<Leader>e", ":bufdo e<CR>", { silent = true, desc = "reload all opened files" })
vim.keymap.set("n", "<Leader>q", ":q<CR>", { silent = true })
vim.keymap.set("n", "<Leader>Q", ":qa<CR>", { silent = true, desc = "close all windows and tabs" })
vim.keymap.set("n", "<C-z>", "<Nop>", { silent = true, desc = "prevent freezing of vim when you press ctrl-z" })
vim.keymap.set("i", ";;", "<Esc>", { silent = true })
vim.keymap.set("v", "<Leader>c", '"+y', { silent = true, desc = "copy from clipboard" })
vim.keymap.set("n", "<Leader>v", '"+p', { silent = true, desc = "paste from clipboard" })
vim.keymap.set("n", "<Leader>p", '<Cmd>wall<CR><Cmd>Prettier<CR><Cmd>bufdo e<CR>', { silent = true, desc = "Save all files, run custom command Prettier, reload all opened files" })
-- 🔥 Key Mappings END


-- Custom logging functions START
local function ConsoleLogGo()
  local trace = 'fmt.Println("@@@ PING")'
  vim.api.nvim_put({trace}, "l", true, true)
end

local function ConsoleLogJs()
  local lines = {
    "console.log('@@@ ');",
    "console.log(JSON.stringify(, null, 4));",
  }
  vim.api.nvim_put(lines, "l", true, true)
end

local function InsertPDB()
  local trace = "__import__('pdb').set_trace()"
  vim.api.nvim_put({trace}, "l", true, true)
end

vim.keymap.set("n", "<Leader>3", ConsoleLogGo)
vim.keymap.set("n", "<Leader>2", ConsoleLogJs)
vim.keymap.set("n", "<Leader>1", InsertPDB)
-- Custom logging functions END

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
    {  -- adds folder tree in editor
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
            dotfiles = false,
          },
        }
      end,
    },
    {  -- allows us to jump to different pages. also rg's root directory and jumps to results
      "junegunn/fzf.vim",
      dependencies = {
        "junegunn/fzf",
      },
    },
      {  -- jump to definition
        -- requires running `npm install -g typescript typescript-language-server` for typescript
        "pmizio/typescript-tools.nvim",
        dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
        event = { "BufReadPre", "BufNewFile" },
        opts = {
          -- Optional: Enable formatting if you want ts-ls to handle it
          -- You might want to set this false if you're using prettier or eslint
          settings = {
            tsserver_file_preferences = {
              includeCompletionsForModuleExports = true,
            },
            tsserver = {
                disable_diagnostics = true,
            },
          },
          on_attach = function(client, bufnr)
            local map = function(mode, lhs, rhs)
              vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, { noremap = true, silent = true })
            end

            -- LSP keymaps
            map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
            map("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>")
            map("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>")
            map("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>")
            map("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>")
            map("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>")
          end,
        },
      },
    {  -- save tabs and windows when quitting sessions, reopening when neovim is running again
      "rmagatti/auto-session",
      config = function()
        require("auto-session").setup({
          log_level = "error",
          auto_session_enabled = true,
          auto_save_enabled = true,
          auto_restore_enabled = true,
          auto_session_suppress_dirs = { "~/" }, -- optional: don't auto-save in home dir
        })
      end,
    }
  },

  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "habamax" } },
  -- disable check for plugin updates cos of spam and noise
  checker = { enabled = false },
})
   
--[[
      {  -- autocomplete
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
          -- Sources for cmp
          "hrsh7th/cmp-nvim-lsp",
          "hrsh7th/cmp-buffer",
          "hrsh7th/cmp-path",
          "hrsh7th/cmp-cmdline",
          "saadparwaiz1/cmp_luasnip",
          -- Snippet engine
          "L3MON4D3/LuaSnip",
          "rafamadriz/friendly-snippets",
        },
        config = function()
          local cmp = require("cmp")
          local luasnip = require("luasnip")

          require("luasnip.loaders.from_vscode").lazy_load()

          cmp.setup({
            snippet = {
              expand = function(args)
                luasnip.lsp_expand(args.body)
              end,
            },
            mapping = cmp.mapping.preset.insert({
              ["<C-b>"] = cmp.mapping.scroll_docs(-4),
              ["<C-f>"] = cmp.mapping.scroll_docs(4),
              ["<C-Space>"] = cmp.mapping.complete(),
              ["<C-e>"] = cmp.mapping.abort(),
              ["<CR>"] = cmp.mapping.confirm({ select = true }),
              ["<Tab>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                  cmp.select_next_item()
                elseif luasnip.expand_or_jumpable() then
                  luasnip.expand_or_jump()
                else
                  fallback()
                end
              end, { "i", "s" }),
              ["<S-Tab>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                  cmp.select_prev_item()
                elseif luasnip.jumpable(-1) then
                  luasnip.jump(-1)
                else
                  fallback()
                end
              end, { "i", "s" }),
            }),
            sources = cmp.config.sources({
              { name = "nvim_lsp" },
              { name = "luasnip" },
            }, {
              { name = "buffer" },
              { name = "path" },
            }),
          })
        end,
      },
]]--
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

-- Custom commands START
-- Run prettier on all files that are edited since the HEAD of the current branch START
vim.api.nvim_create_user_command("Prettier", function()
  local handle = io.popen("git ls-files --modified --others --exclude-standard | grep -E '\\.(js|ts|jsx|tsx|css|scss|html|json|md)$'")
  local result = handle:read("*a")
  handle:close()

  for file in result:gmatch("[^\r\n]+") do
    vim.fn.jobstart({ "prettier", "--write", file }, {
      stdout_buffered = true,
      on_stdout = function(_, data)
        if data then
          print(table.concat(data, "\n"))
        end
      end,
      on_stderr = function(_, data)
        if data then
          vim.api.nvim_err_writeln(table.concat(data, "\n"))
        end
      end,
    })
  end
end, {})
-- Run prettier on all files that are edited since the HEAD of the current branch END
-- Custom commands END

-- for jump to definition, set up go language server
require('lspconfig').gopls.setup({})
