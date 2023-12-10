local plug = vim.fn.stdpath("config") .. "/lua/tharun/plug.vim"

vim.cmd.source(plug)
--require("tharun.plug")
require("tharun.remap")
print("hello from tharun dir")
