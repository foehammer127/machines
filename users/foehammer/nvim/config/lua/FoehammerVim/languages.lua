local lspconfig = require 'lspconfig'
local treesitter = require 'nvim-treesitter.configs'
local treesitter_context = require 'treesitter-context'

local function autocmd(args)
	local event = args[1]
	local group = args[2]
	local callback = args[3]

	vim.api.nvim_create_autocmd(event, {
		group = group,
		buffer = args[4],
		callback = function()
			callback()
		end,
		once = args.once,
	})
end

local function on_attach(client, buffer)
	local augroup_highlight = vim.api.nvim_create_augroup("custom-lsp-references", { clear = true })
	local autocmd_clear = vim.api.nvim_clear_autocmds

	local opts = { buffer = buffer, remap = false }

	vim.bo[buffer].omnifunc = 'v:lua.vim.lsp.omnifunc'


	-- Enable completion triggered by <c-x><c-o>
	vim.bo[buffer].omnifunc = 'v:lua.vim.lsp.omnifunc'

	vim.keymap.set('n', '<leader>gD', vim.lsp.buf.declaration, opts)
	vim.keymap.set('n', '<leader>gd', vim.lsp.buf.definition, opts)
	vim.keymap.set('n', '<leader>K', vim.lsp.buf.hover, opts)
	vim.keymap.set('n', '<leader>gi', vim.lsp.buf.implementation, opts)
	vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
	vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
	vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
	vim.keymap.set('n', '<leader>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, opts)
	vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
	vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
	vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
	vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
	vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format { async = true } end, opts)

	if client.server_capabilities.documentHighlightProvider then
		autocmd_clear { group = augroup_highlight, buffer = buffer }
		autocmd { "CursorHold", augroup_highlight, vim.lsp.buf.document_highlight, buffer }
		autocmd { "CursorMoved", augroup_highlight, vim.lsp.buf.clear_references, buffer }
	end
end

local function init()
	local language_servers = {
		gopls = {
			settings = {
				gopls = {
					gofumpt = true,
				},
			},
		},
		lua_ls = {
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim" },
					},
					runtime = {
						version = 'LuaJIT',
					},
					telemetry = {
						enable = false,
					},
					workspace = {
						library = vim.api.nvim_get_runtime_file("", true),
					},
				}


			}

		},
		nil_ls = {
			settings = {
				['nil'] = {
					formatting = { command = { 'alejandra' } },
				}

			}
		},
	}


	-- Initialize servers
	for server, server_config in pairs(language_servers) do
		local config = { on_attach = on_attach }

		if server_config then
			for k, v in pairs(server_config) do
				config[k] = v
			end
		end

		lspconfig[server].setup(config)
	end

	vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
	vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
	vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
	vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)


	treesitter.setup {
		auto_install = false,
		ensure_installed = {},
		highlight = { enable = true },
		indent = { enable = true },
		modules = {},
		rainbow = { enable = true },
		sync_install = false,
	}

	treesitter_context.setup()

	vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.format({ async = false })]]
end


return {
	init = init,
}
