return {
    'ahmedkhalf/project.nvim',
    config = function()
        require("project_nvim").setup {
            detection_methods = { "lsp", "pattern" },
            patterns = { ".git", "go.mod", "package.json", "pyproject.toml", "uv.lock" },
        }
    end
}
