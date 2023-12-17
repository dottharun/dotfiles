local plug = vim.fn.stdpath("config") .. "/lua/tharun/plug.vim"

vim.cmd.source(plug)
require("tharun.remap")
require("tharun.set")
print("hello from tharun dir")
