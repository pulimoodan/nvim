---
-- LSP configuration
---
local lsp_attach = function(_, bufnr)
  local nmap = function(keys, func, desc)
    if desc then
      desc = "LSP: " .. desc
    end
    vim.keymap.set("n", keys, func, { buffer = 0, desc = desc })
  end

  -- Defintion and refernces
  nmap("K", vim.lsp.buf.hover, "Hover Documentation")
  nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
  nmap("gi", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
  nmap("gt", vim.lsp.buf.type_definition, "[G]oto [T]ype definition")
  nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
  nmap("gs", require("telescope.builtin").lsp_document_symbols, "[G]oto document [S]ymbols")

  --- Diagnostics
  nmap("<leader>dn", vim.diagnostic.goto_next, "[N]ext [D]iagnostic")
  nmap("<leader>dp", vim.diagnostic.goto_prev, "[P]rev [D]iagnostic")
  nmap("<leader>dl", "<cmd>Telescope diagnostics<cr>", "[L]ist [D]iagnostic")

  -- Code Actions
  nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
  nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
    vim.lsp.buf.format()
  end, { desc = "Format current buffer with LSP" })
end

-- Mason for installing LSP
require('mason').setup({})
require('mason-lspconfig').setup({
  -- Add more languages servers here
  ensure_installed = { 'lua_ls', 'ts_ls', 'rust_analyzer' },
  handlers = {
    function(server_name)
      require('lspconfig')[server_name].setup({
        sign_text = true,
        on_attach = lsp_attach,
        capabilities = require('cmp_nvim_lsp').default_capabilities(),
      })
    end,
  },
})


---
-- Autocompletion setup
---

vim.opt.completeopt = { "menu", "menuone", "noselect" }
require("nvim-autopairs").setup({
  disable_in_replace_mode = false,
})
local cmp = require('cmp')
local luasnip = require('luasnip')
local cmp_autopairs = require("nvim-autopairs.completion.cmp")

cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-u>"] = cmp.mapping.scroll_docs(-4),
    ["<C-d>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<CR>"] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    }),
    ["<C-n>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<C-p>"] = cmp.mapping(function(fallback)
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
    { name = "path" },
    { name = "nvim_lsp" },
    { name = "luasnip" },
  }, {
    { name = "buffer" },
  }),
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
})
