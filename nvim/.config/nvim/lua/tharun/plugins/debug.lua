return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "rcarriga/nvim-dap-ui",
            "nvim-neotest/nvim-nio",
        },
        config = function()
            local dap = require("dap")
            local dapui = require("dapui")

            dap.configurations.java = {
                {
                    type = "java",
                    request = "launch",
                    name = "Launch Java Program",
                },
            }

            vim.fn.sign_define("DapBreakpoint", {
                text = "🔴",
                texthl = "DapBreakpointSymbol",
                linehl = "DapBreakpoint",
                numhl = "DapBreakpoint",
            })
            vim.fn.sign_define("DapStopped", {
                texthl = "DapStoppedSymbol",
                linehl = "CursorLine",
                numhl = "DapBreakpoint",
            })

            vim.keymap.set("n", "<F1>", dap.step_into)
            vim.keymap.set("n", "<F2>", dap.step_over)
            vim.keymap.set("n", "<F3>", dap.step_out)
            vim.keymap.set("n", "<F4>", dap.step_back) -- is it even available
            vim.keymap.set("n", "<F5>", dap.continue)
            vim.keymap.set("n", "<F12>", dap.restart)

            vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint)

            dapui.setup()

            dap.listeners.before.attach.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.launch.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated.dapui_config = function()
                dapui.close()
            end
            dap.listeners.before.event_exited.dapui_config = function()
                dapui.close()
            end

            vim.keymap.set("n", "<leader>du", dapui.toggle)

            -- Eval var under cursor
            vim.keymap.set("n", "<leader>?", function()
                dapui.eval(nil, { enter = true })
            end)
        end,
    },
}
