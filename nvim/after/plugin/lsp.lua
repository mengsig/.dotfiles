
local lsp = require('lsp-zero')
lsp.preset('recommended')
lsp.setup()


require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = { "lua_ls", "zls", "pyright"},
}
)

require("lspconfig").lua_ls.setup {}
require("lspconfig").zls.setup{}
require("lspconfig").pyright.setup{}


--
--
--
--
--local cmp = require('cmp')
--local cmp_select = {behaviour = cmp.SelectBehavior.Select}
--local cmp_mappings = lsp.defaults.cmp_mappings({
--	['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
--	['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
--	['<C-y>'] = cmp.mapping.confirm({ select = true }),
--	['<C-Space>'] = cmp.mapping.complete(),
--})
--
--lsp.set_preferences({
--	sign_icons = { }
--})
--
----lsp.setup_nvim_cmp({
----    mapping = cmap_mappins
----})
--

--local lsp_zero = require('lsp-zero')
--lsp_zero.setup()
--vim.diagnostic.config({
--    virtual_text = true,
--})
--
--lsp_zero.on_attach(function(client, bufnr)
--  lsp_zero.default_keymaps({buffer = bufnr})
--end)
--
