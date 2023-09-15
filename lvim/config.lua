
-- Spellcheck
vim.opt.spelllang = "en_gb"
vim.opt.spell = true
-- Tab size
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
-- Allow unsaved hidden buffers
vim.opt.hidden = true

-- ColourScheme
lvim.plugins = {
    {
        "sainnhe/everforest",
        config = function ()
            lvim.colorscheme = "everforest"
        end
    },
    {
        "brenoprata10/nvim-highlight-colors",
        config = true
    }
}

lvim.builtin.which_key.setup.plugins.marks = true
lvim.builtin.which_key.setup.plugins.registers = true

vim.opt.timeoutlen = 250

lvim.keys.normal_mode[""] = ":WhichKey<cr>"
