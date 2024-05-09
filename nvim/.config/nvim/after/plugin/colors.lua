function ColorMyPencils(color)
    require("rose-pine").setup({
        disable_background = true,
    })

    color = color or "rose-pine"
    vim.cmd.colorscheme(color)

    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

function Gruvy()
    vim.g.gruvbox_transparent_bg = 1
    vim.g.gruvbox_contrast_dark = "soft"
    vim.cmd.colorscheme("gruvbox")

    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

function Matgru()
    vim.g.gruvbox_matrial_transparent_bg = 1
    vim.g.gruvbox_material_background = "hard"
    vim.cmd.colorscheme("gruvbox-material")

    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

function Tokyo()
    vim.o.termguicolors = true
    require("tokyonight").setup({
        style = "night"
    })
    vim.cmd [[colorscheme tokyonight-night]]
end

function Kana()
    require('kanagawa').setup({
        colors = { theme = { all = { ui = { bg_gutter = "none" } } } },
    })

    vim.cmd("colorscheme kanagawa")
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

function KanaDragon()
    require('kanagawa').setup({
        colors = { theme = { all = { ui = { bg_gutter = "none" } } } },
    })

    vim.cmd("colorscheme kanagawa-dragon")
end

function Cat()
    local catppuccin = require("catppuccin")

    if not catppuccin then return end

    vim.g.catppuccin_flavour = "mocha"

    catppuccin.setup({
        flavour = "mocha", -- latte, frappe, macchiato, mocha
        term_colors = true,
        -- transparent_background = true,
        no_italic = false,
        no_bold = false,
        styles = {
            comments = {},
            conditionals = {},
            loops = {},
            functions = {},
            keywords = {},
            strings = {},
            variables = {},
            numbers = {},
            booleans = {},
            properties = {},
            types = {},
        },
        color_overrides = {
            mocha = {
                base = "#000000",
                mantle = "#000000",
                crust = "#000000",
            },
        },
        highlight_overrides = {
            mocha = function(C)
                return {
                    TabLineSel = { bg = C.pink },
                    CmpBorder = { fg = C.surface2 },
                    Pmenu = { bg = C.none },
                    TelescopeBorder = {  fg = C.surface2 },
                }
            end,
        },
    })

    vim.cmd([[colorscheme catppuccin]])
end

function VSCode()
    require('vscode').load()
end

function Osaka()
    vim.cmd[[colorscheme solarized-osaka]]
end

function Od()
    require('onedark').setup {
        -- style = 'warmer',
        code_style = {
            comments = 'none',
            keywords = 'none',
            functions = 'none',
            strings = 'none',
            variables = 'none'
        },
        colors = {
            bg0 = "#111111",
        }
    }

    require('onedark').load()
end

function Clown() vim.cmd[[colorscheme no-clown-fiesta]] end

function Solar()
    vim.cmd('colorscheme solarized-flat')
end

-- for higlighting colors from text hex
require('colorizer').setup()

-- ColorMyPencils()
-- Gruvy()
-- Matgru()
-- Tokyo()
-- Kana()
-- VSCode()
-- KanaDragon()
-- Cat()
Od()
-- Osaka()
-- Solar()

