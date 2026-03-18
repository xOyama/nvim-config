require("nvchad.configs.lspconfig").defaults()

local servers = {
  html = {},
  cssls = {},
  basedpyright = {
  settings = {
    basedpyright = {
      analysis = {
        diagnosticSeverityOverrides = {
          reportMissingParameterType = "none",
          reportUnknownParameterType = "none",
          reportUnknownArgumentType = "none",
          reportUnknownVariableType = "none",
          reportUnknownMemberType = "none",
          reportUnknownLambdaType = "none"
        },
      },
    },
  },
},



}


for name, opts in pairs(servers) do
  vim.lsp.config(name, opts)
  vim.lsp.enable(name)
end















-- vim.lsp.enable(servers)
-- read :h vim.lsp.config for changing options of lsp servers 
