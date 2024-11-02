-- LSP configuration
-- 
-- In Archlinux, run 'pacman -S pyright ccsl rust-analyzer' to install the LSP
-- server packages from the repositories.

local lspconfig = require('lspconfig')

lspconfig.pyright.setup{}
lspconfig.ccls.setup{}
lspconfig.rust_analyzer.setup{}
