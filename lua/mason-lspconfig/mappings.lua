-- Compatibility shim for older mason-lspconfig versions that don't ship the
-- aggregated `mason-lspconfig.mappings` module expected by newer LazyVim.
-- Reuse the legacy server mapping table instead of blowing up at runtime.
return require("mason-lspconfig.mappings.server")

