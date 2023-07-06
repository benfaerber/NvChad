require "core"

local custom_init_path = vim.api.nvim_get_runtime_file("lua/custom/init.lua", false)[1]

if custom_init_path then
  dofile(custom_init_path)
end

require("core.utils").load_mappings()

local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

-- bootstrap lazy.nvim!
if not vim.loop.fs_stat(lazypath) then
  require("core.bootstrap").gen_chadrc_template()
  require("core.bootstrap").lazy(lazypath)
end

dofile(vim.g.base46_cache .. "defaults")
vim.opt.rtp:prepend(lazypath)
require "plugins"

-- OCaml LSP Server
local lspconfig = require('lspconfig')
lspconfig.ocamllsp.setup {
   cmd = { 'ocamllsp' },
   filetypes = { 'ocaml', 'reason' },
   root_dir = lspconfig.util.root_pattern('.opam*', 'package.json', 'esy.json'),
}

local merlin_path = vim.fn.expand('~/.opam/default/bin/ocamlmerlin')
vim.cmd(string.format('let g:ocaml_merlin_bin = "%s"', merlin_path))
