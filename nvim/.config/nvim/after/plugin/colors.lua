
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
    vim.g.gruvbox_contrast_dark = "hard"
    vim.cmd.colorscheme("gruvbox")

    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

function Poiman()
    vim.cmd.colorscheme("poimandres")

    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

function Wally()
    vim.cmd.colorscheme("wal")
    vim.opt.background = "dark"
    vim.opt.termguicolors = false

    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

--ColorMyPencils()
Gruvy()
--Poiman()
--Wally()
