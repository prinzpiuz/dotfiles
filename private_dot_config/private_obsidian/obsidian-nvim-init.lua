-- ~/.config/obsidian/nvim-init.lua
--
-- Obsidian-specific Neovim config, loaded by the Vim Motions plugin's
-- Neovim RPC backend under `nvim --clean`.
--
-- Lives OUTSIDE the vault on purpose: Remotely Save never touches it, and
-- the plugin supports absolute/tilde paths for the config file (desktop only).
--
-- Design: reuse ~/.config/nvim/lua/config/options.lua as the single source of
-- truth, then override the handful of options that are wrong for prose notes.
-- config/autocmds.lua is deliberately NOT loaded (see notes at the bottom).

--------------------------------------------------------------------------
-- 1. Make the real config requirable under --clean
--------------------------------------------------------------------------
-- `--clean` strips user config off 'runtimepath', so require("config.options")
-- would fail. Point package.path at the real config tree.

local nvim_config = vim.fn.expand("~/.config/nvim")

package.path = table.concat({
	nvim_config .. "/lua/?.lua",
	nvim_config .. "/lua/?/init.lua",
	package.path,
}, ";")

vim.opt.runtimepath:prepend(nvim_config)

-- Automatically fold YAML proprtties when opening a note
vim.opt.foldenable = true
vim.opt.foldlevel = 0

--------------------------------------------------------------------------
-- 2. Shared options
--------------------------------------------------------------------------
-- Brings across: leader (space), relativenumber, cursorline, scrolloff=10,
-- ignorecase/smartcase, timeoutlen=300, undofile, swapfile=false,
-- breakindent, confirm, and the CopyQ clipboard provider.

local ok, err = pcall(require, "config.options")
if not ok then
	vim.notify("obsidian init: could not load config.options: " .. tostring(err), vim.log.levels.WARN)
end

--------------------------------------------------------------------------
-- 3. Obsidian-specific overrides
--------------------------------------------------------------------------

-- Prose wraps. Your main config sets wrap=false, which is right for code and
-- wrong here. linebreak wraps at word boundaries instead of mid-word.
vim.opt.wrap = true
vim.opt.linebreak = true

-- breakindent is already on from config.options and now actually matters:
-- wrapped list items stay visually indented under their bullet.

-- Trailing-space dots and tab arrows are noise in prose. The Obsidian Linter
-- strips trailing whitespace anyway.
vim.opt.list = false

-- Vim Motions' gq/gw hard-wrap uses the mirrored buffer's textwidth.
-- 0 = no hard wrapping (soft wrap only). Set to 80 if you prefer your
-- markdown source hard-wrapped at a column.
vim.opt.textwidth = 0

-- Live substitution preview opens a split; noisy in a note pane.
vim.opt.inccommand = "nosplit"

-- Indentation: your main config is expandtab with 4 spaces. Obsidian has its
-- own "Indent using tabs" setting (Settings > Editor). If that is ON, leave
-- the line below uncommented so indentation matches what Obsidian writes;
-- if you switched Obsidian to spaces, delete it.
vim.opt.expandtab = false
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

--------------------------------------------------------------------------
-- 4. mini.ai and mini.surround
--------------------------------------------------------------------------
-- Loaded straight from the existing lazy.nvim install directory. No lazy
-- bootstrap, no network. If mini is missing, this is skipped silently rather
-- than erroring on startup.

local mini_path = vim.fn.stdpath("data") .. "/lazy/mini.nvim"

if vim.uv.fs_stat(mini_path) then
	vim.opt.runtimepath:append(mini_path)

	pcall(function()
		require("mini.ai").setup({ n_lines = 500 })
	end)

	-- sa / sd / sr, same as your main config.
	-- Note: Vim Motions ships its own surround, but under RPC mode Neovim owns
	-- editor keys, so mini.surround is what actually runs. That is intended.
	pcall(function()
		require("mini.surround").setup()
	end)

	-- mini.indentscope is omitted: its indent guides are meaningless in prose
	-- and it draws via extmarks on every cursor move. Add it back if you want it.
end

--------------------------------------------------------------------------
-- 5. Keymaps
--------------------------------------------------------------------------
-- config/keymaps.lua is NOT required wholesale. Roughly two thirds of it
-- targets LSP, Telescope, conform, ZenMode and ToggleTerm, none of which exist
-- here. Those maps would not error on load, but would fail silently on press.
-- What follows keeps the muscle memory and repoints it at Obsidian equivalents.

local map = vim.keymap.set

-- ---- Carried over unchanged --------------------------------------------

-- Clear search highlight
map("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Arrow key training wheels
map("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
map("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
map("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
map("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')

-- Split navigation. Vim Motions implements <C-w> workspace navigation, so
-- these map onto Obsidian panes.
map("n", "<C-h>", "<C-w><C-h>", { desc = "Focus left pane" })
map("n", "<C-l>", "<C-w><C-l>", { desc = "Focus right pane" })
map("n", "<C-j>", "<C-w><C-j>", { desc = "Focus lower pane" })
map("n", "<C-k>", "<C-w><C-k>", { desc = "Focus upper pane" })

-- Yank paths. vim.fn.expand("%") resolves against the mirrored buffer, so
-- these give you the note path.
map("n", "<leader>yp", function()
	vim.fn.setreg("+", vim.fn.expand("%:p"))
	vim.notify("Copied: " .. vim.fn.expand("%:p"))
end, { desc = "Copy full path" })

map("n", "<leader>yr", function()
	vim.fn.setreg("+", vim.fn.expand("%"))
	vim.notify("Copied: " .. vim.fn.expand("%"))
end, { desc = "Copy relative path" })

map("n", "<leader>yn", function()
	vim.fn.setreg("+", vim.fn.expand("%:t"))
	vim.notify("Copied: " .. vim.fn.expand("%:t"))
end, { desc = "Copy filename" })

-- ---- Repointed ---------------------------------------------------------
-- VERIFY THESE THREE. `:Picker` / `:Pick` exist, but I have not confirmed the
-- exact source-argument names. Run `:Pick` with no arguments to list sources,
-- then correct the strings below. Until then they may be no-ops.

-- <leader>f was Telescope find_files
map("n", "<leader>f", "<cmd>Pick files<CR>", { desc = "Find notes" })

-- <leader><leader> was Telescope buffers
map("n", "<leader><leader>", "<cmd>Pick buffers<CR>", { desc = "Open notes" })

-- <leader>sg was Telescope live_grep
map("n", "<leader>sg", "<cmd>Pick live_grep<CR>", { desc = "Search vault" })

-- <leader>e was Neotree. Oil is the closest equivalent here, and you already
-- use oil.nvim, so `-` for parent directory is carried over too.
map("n", "<leader>e", "<cmd>Oil<CR>", { desc = "File explorer" })
map("n", "-", "<cmd>Oil<CR>", { desc = "Open parent directory" })

-- ---- Obsidian-native additions -----------------------------------------
-- No equivalent in your Neovim config, but worth having.

-- Structural navigation is built in: ]h / [h headings, ]l lists, ]n links.
-- Harpoon is built in on <leader>1 .. <leader>9.

-- Undo tree sidebar (you have undofile on, so history persists)
map("n", "<leader>u", "<cmd>UndoTreeToggle<CR>", { desc = "Undo tree" })

-- Escape hatch: `:ob` with no arguments opens a searchable list of every
-- Obsidian command ID. Use it to bind anything not covered above, e.g.
-- your Ledger add-transaction command or Book Search.
map("n", "<leader>o", "<cmd>ob<CR>", { desc = "Obsidian commands" })

--------------------------------------------------------------------------
-- Deliberately omitted
--------------------------------------------------------------------------
-- config.autocmds
--   * Format-on-save calls require("conform"), which is not installed here,
--     so it would throw on every write.
--   * The InsertLeave/TextChanged auto-save runs `silent! write` after 1s.
--     Under RPC the mirror is an `acwrite` buffer whose :w triggers Obsidian's
--     own save command, and Obsidian already autosaves. The result is a
--     redundant save loop that feeds Remotely Save churn.
--   * The TextYankPost highlight is the one useful piece, and Vim Motions
--     provides yank highlighting itself.
--
-- LSP / conform / DAP / gitsigns / telescope / toggleterm / markdown-preview
--   Nothing to attach to inside a notes app.
--
-- <Tab> / <S-Tab> buffer cycling
--   Left out because Tab is heavily used by Obsidian for list indentation and
--   autocomplete. Add it back only if you confirm it does not collide.
