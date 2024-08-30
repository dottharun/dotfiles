-- CPP
vim.api.nvim_create_user_command("CppSnippet", function()
    local snippet = {
        "#include <bits/stdc++.h>",
        "using namespace std;",
        "#define fastio ios_base::sync_with_stdio(false), cin.tie(nullptr), cout.tie(nullptr)",
        "",
    }
    vim.api.nvim_put(snippet, "l", false, true)
end, {})

vim.keymap.set("n", "<leader>#", "<cmd>CppSnippet<CR>")
