-- General
vim.g.mapleader = " "
vim.g.have_nerd_font = true

-- options

vim.opt.number = true
vim.opt.mouse = 'a'
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
-- Use CopyQ as clipboard provider
vim.g.clipboard = {
    name = 'CopyQ',
    copy = {
        ['+'] = { 'copyq', 'copy', '-' },
        ['*'] = { 'copyq', 'copy', '-' },
    },
    paste = {
        ['+'] = { 'copyq', 'clipboard' },
        ['*'] = { 'copyq', 'clipboard' },
    },
    cache_enabled = 0,
}
vim.schedule(function() vim.opt.clipboard = 'unnamedplus' end)

-- Enable break indent
vim.opt.breakindent = true

-- Enable undo/redo changes even after closing and reopening a file
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.relativenumber = true
vim.opt.wrap = false
vim.opt.termguicolors = true

-- Tabs / formatting
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- Disable clutter
vim.opt.signcolumn = "yes"
vim.opt.cursorline = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
--
--  Notice listchars is set using `vim.opt` instead of `vim.o`.
--  It is very similar to `vim.o` but offers an interface for conveniently interacting with tables.
--   See `:help lua-options`
--   and `:help lua-guide-options`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
vim.opt.confirm = true
