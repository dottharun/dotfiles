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
    vim.cmd [[colorscheme tokyonight]]

    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

function Kana()
    vim.cmd("colorscheme kanagawa")
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

function Fox()
    vim.cmd("colorscheme carbonfox")
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

-- ColorMyPencils()
-- Gruvy()
-- Matgru()
-- Tokyo()
Kana()
-- Fox()
