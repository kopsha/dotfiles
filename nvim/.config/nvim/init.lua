-- Set <space> as the leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.have_nerd_font = false

require("options")
require("keymaps")

-- [[ Basic Autocommands ]]
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- [[ Install `lazy.nvim` plugin manager ]]
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
require("lazy").setup({
	"christoomey/vim-tmux-navigator", -- navigate between tmux and nvim windows

	{
		"junegunn/fzf.vim",
		dependencies = {
			"junegunn/fzf",
			build = function()
				vim.fn["fzf#install"]()
			end,
		},
		config = function()
			vim.g.fzf_layout = { down = "40%" }
			-- general searches
			vim.keymap.set("n", "<leader>sh", ":Helptags<CR>", { desc = "[S]earch [H]elp" })
			vim.keymap.set("n", "<leader>sk", ":Maps<CR>", { desc = "[S]earch [K]eymaps" })
			vim.keymap.set("n", "<leader>sf", ":Files<CR>", { desc = "[S]earch [F]iles" })
			vim.keymap.set("n", "<leader>ss", ":Commands<CR>", { desc = "[S]earch [S]elect Command" })
			vim.keymap.set("n", "<leader>sw", ":Rg <C-R><C-W><CR>", { desc = "[S]earch current [W]ord" })
			vim.keymap.set("n", "<leader>sg", ":Rg<CR>", { desc = "[S]earch by [G]rep" })
			vim.keymap.set("n", "<leader>sd", ":BLines<CR>", { desc = "[S]earch [D]iagnostics (lines in buffer)" })
			vim.keymap.set("n", "<leader>sr", ":History<CR>", { desc = "[S]earch [R]esume (History)" })
			vim.keymap.set("n", "<leader>s.", ":History<CR>", { desc = '[S]earch Recent Files ("." for repeat)' })
			vim.keymap.set("n", "<leader>sb", ":Buffers<CR>", { desc = "[ ] Find existing buffers" })
			vim.keymap.set("n", "<leader>sc", ":Changes<CR>", { desc = "[S]earch [C]hangelist" })
			-- fugitive searches
			vim.keymap.set("n", "<leader>gf", ":GFiles<CR>", { desc = "[G]it [F]iles" })
			vim.keymap.set("n", "<leader>gs", ":GFiles?<CR>", { desc = "[G]it [S]tatus" })
			vim.keymap.set("n", "<leader>gc", ":Commits<CR>", { desc = "[G]it [C]ommits" })
			vim.keymap.set("n", "<leader>gb", ":BCommits<CR>", { desc = "[G]it [B]uffer Commits" })
		end,
	},

	{
		-- Main LSP Configuration
		"neovim/nvim-lspconfig",
		dependencies = {
			-- Automatically install LSPs and related tools to stdpath for Neovim
			{ "williamboman/mason.nvim", config = true }, -- NOTE: Must be loaded before dependants
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",

			-- Useful status updates for LSP.
			-- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
			{ "j-hui/fidget.nvim", opts = {} },

			-- Allows extra capabilities provided by nvim-cmp
			"hrsh7th/cmp-nvim-lsp",
		},
		config = function()
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
				callback = function(event)
					-- In this case, we create a function that lets us more easily define mappings specific
					-- for LSP related items. It sets the mode, buffer and description for us each time.
					local map = function(keys, func, desc, mode)
						mode = mode or "n"
						vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end

					map("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
					map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
					map("gr", vim.lsp.buf.references, "[G]oto [R]eferences")
					map("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
					map("<C-s>", vim.lsp.buf.signature_help, "[S]ignature Help")
					map("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
					map("<leader>ds", vim.lsp.buf.document_symbol, "[D]ocument [S]ymbols")
					map("<leader>ws", vim.lsp.buf.workspace_symbol, "[W]orkspace [S]ymbols")
					map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
					map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction", { "n", "x" })

					-- The following two autocommands are used to highlight references of the
					-- word under your cursor when your cursor rests there for a little while.
					--    See `:help CursorHold` for information about when this is executed
					--
					-- When you move your cursor, the highlights will be cleared (the second autocommand).
					local client = vim.lsp.get_client_by_id(event.data.client_id)
					if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
						local highlight_augroup =
							vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
						vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.document_highlight,
						})

						vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.clear_references,
						})

						vim.api.nvim_create_autocmd("LspDetach", {
							group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
							callback = function(event2)
								vim.lsp.buf.clear_references()
								vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
							end,
						})
					end

					-- The following code creates a keymap to toggle inlay hints in your
					-- code, if the language server you are using supports them
					--
					-- This may be unwanted, since they displace some of your code
					if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
						map("<leader>th", function()
							vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
						end, "[T]oggle Inlay [H]ints")
					end
				end,
			})

			-- LSP servers and clients are able to communicate to each other what features they support.
			--  By default, Neovim doesn't support everything that is in the LSP specification.
			--  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
			--  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

			-- Enable the following language servers
			--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
			--
			--  Add any additional override configuration in the following tables. Available keys are:
			--  - cmd (table): Override the default command used to start the server
			--  - filetypes (table): Override the default list of associated filetypes for the server
			--  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
			--  - settings (table): Override the default settings passed when initializing the server.
			--        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
			local servers = {
				ruff_lsp = {
					cmd = { "ruff-lsp" },
					settings = {
						args = {},
					},
				},
				-- pyright = {
				-- 	settings = {
				-- 		-- pyright = {
				-- 		-- 	disableOrganizeImports = true, -- Using Ruff's import organizer
				-- 		-- },
				-- 		python = {
				-- 			analysis = {
				-- 				ignore = { "*" },
				-- 			},
				-- 		},
				-- 	},
				-- },
				helm_ls = {
					settings = {
						yamlls = {
							path = "yaml-language-server",
						},
					},
				},
				ts_ls = {},
				lua_ls = {
					-- cmd = {...},
					-- filetypes = { ...},
					-- capabilities = {},
					settings = {
						Lua = {
							completion = {
								callSnippet = "Replace",
							},
							-- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
							-- diagnostics = { disable = { 'missing-fields' } },
						},
					},
				},
			}

			-- Ensure the servers and tools above are installed
			--  To check the current status of installed tools and/or manually install
			--  other tools, you can run
			--    :Mason
			--
			--  You can press `g?` for help in this menu.
			require("mason").setup()

			-- You can add other tools here that you want Mason to install
			-- for you, so that they are available from within Neovim.
			local ensure_installed = vim.tbl_keys(servers or {})
			vim.list_extend(ensure_installed, {
				"stylua", -- Used to format Lua code
			})
			require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

			require("mason-lspconfig").setup({
				handlers = {
					function(server_name)
						local server = servers[server_name] or {}
						-- This handles overriding only values explicitly passed
						-- by the server configuration above. Useful when disabling
						-- certain features of an LSP (for example, turning off formatting for ts_ls)
						server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
						require("lspconfig")[server_name].setup(server)
					end,
				},
			})
		end,
	},

	{ -- Highlight, edit, and navigate code
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		opts = {
			ensure_installed = {
				"python",
				"bash",
				"c",
				"html",
				"css",
				"lua",
				"luadoc",
				"vim",
				"vimdoc",
				"javascript",
				"typescript",
				"toml",
				"yaml",
				"markdown",
			},
			auto_install = true, -- Autoinstall languages that are not installed
			highlight = {
				enable = true,
				-- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
				--  If you are experiencing weird indenting issues, add the language to
				--  the list of additional_vim_regex_highlighting and disabled languages for indent.
				additional_vim_regex_highlighting = { "ruby" },
			},
			indent = { enable = true, disable = { "ruby" } },
		},
		config = function(_, opts)
			-- [[ Configure Treesitter ]] See `:help nvim-treesitter`
			---@diagnostic disable-next-line: missing-fields
			require("nvim-treesitter.configs").setup(opts)
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			opts = {
				textobjects = {
					select = {
						enable = true,
						lookahead = true,
						keymaps = {
							["aa"] = "@parameter.outer",
							["ia"] = "@parameter.inner",
							["ab"] = "@block.outer",
							["ib"] = "@block.inner",
							["ac"] = "@conditional.outer",
							["ic"] = "@conditional.inner",
							["af"] = "@function.outer",
							["if"] = "@function.inner",
							["am"] = "@comment.outer",
							["im"] = "@comment.inner",
							["ao"] = "@class.outer",
							["io"] = "@class.inner",
						},
					},
				},
			},
		},
	},

	{ -- Autocompletion
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			-- Snippet Engine & its associated nvim-cmp source
			{
				"L3MON4D3/LuaSnip",
				build = "make install_jsregexp",
				dependencies = {
					{
						"rafamadriz/friendly-snippets",
						config = function()
							require("luasnip.loaders.from_vscode").lazy_load()
						end,
					},
				},
			},
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-path",
		},
		config = function()
			-- See `:help cmp`
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			luasnip.config.setup({})

			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				completion = { completeopt = "menu,menuone,noinsert" },

				-- For an understanding of why these mappings were
				-- chosen, you will need to read `:help ins-completion`
				--
				-- No, but seriously. Please read `:help ins-completion`, it is really good!
				mapping = cmp.mapping.preset.insert({
					["<C-n>"] = cmp.mapping.select_next_item(),
					["<C-p>"] = cmp.mapping.select_prev_item(),

					-- Scroll the documentation window [b]ack / [f]orward
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),

					-- Accept ([y]es) the completion.
					--  This will auto-import if your LSP supports it.
					--  This will expand snippets if the LSP sent a snippet.
					["<C-y>"] = cmp.mapping.confirm({ select = true }),

					-- If you prefer more traditional completion keymaps,
					-- you can uncomment the following lines
					--['<CR>'] = cmp.mapping.confirm { select = true },
					--['<Tab>'] = cmp.mapping.select_next_item(),
					--['<S-Tab>'] = cmp.mapping.select_prev_item(),

					-- Manually trigger a completion from nvim-cmp.
					["<C-Space>"] = cmp.mapping.complete({}),

					["<C-l>"] = cmp.mapping(function()
						if luasnip.expand_or_locally_jumpable() then
							luasnip.expand_or_jump()
						end
					end, { "i", "s" }),
					["<C-h>"] = cmp.mapping(function()
						if luasnip.locally_jumpable(-1) then
							luasnip.jump(-1)
						end
					end, { "i", "s" }),

					-- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
					--    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
				}),
				sources = {
					{
						name = "lazydev",
						-- set group index to 0 to skip loading LuaLS completions as lazydev recommends it
						group_index = 0,
					},
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "path" },
				},
			})
		end,
	},

	{ -- Autoformat
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				"<leader>f",
				function()
					require("conform").format({ async = true, lsp_format = "fallback" })
				end,
				mode = "",
				desc = "[F]ormat buffer",
			},
		},
		opts = {
			notify_on_error = true,
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "ruff_organize_imports", "ruff_format" },
				javascript = { "prettierd", "prettier", stop_after_first = true },
			},
		},
	},

	{
		"SirVer/ultisnips",
		config = function()
			vim.g.UltiSnipsExpandTrigger = "<tab>"
			vim.g.UltiSnipsJumpForwardTrigger = "<c-b>"
			vim.g.UltiSnipsJumpBackwardTrigger = "<c-z>"
			-- If you want :UltiSnipsEdit to split your window.
			vim.g.UltiSnipsEditSplit = "vertical"
		end,
	},
	"honza/vim-snippets",

	"tpope/vim-fugitive",
	"tpope/vim-endwise",
	"tpope/vim-vinegar",
	"tpope/vim-surround",

	{ -- Find someone to blame, every time
		"APZelos/blamer.nvim",
		config = function()
			vim.g.blamer_enabled = 1
		end,
	},

	{ -- Autosave files
		"kopsha/vim-saver",
		version = "1.*",
	},

	{ -- Adds git related signs to the gutter, as well as utilities for managing changes
		"lewis6991/gitsigns.nvim",
		opts = {
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
		},
	},

	{ "echasnovski/mini.splitjoin", version = "*", opts = {} },
	{ "echasnovski/mini.statusline", version = "*", opts = {} },

	{
		"bluz71/vim-nightfly-colors",
		name = "nightfly",
		lazy = false,
		priority = 1000,
		config = function()
			vim.opt.termguicolors = true
			vim.cmd([[colorscheme nightfly]])
			vim.opt.background = "dark"
		end,
	},

	{ -- Prettify TODO notes
		"folke/todo-comments.nvim",
		event = "VimEnter",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = { signs = false },
	},
})
