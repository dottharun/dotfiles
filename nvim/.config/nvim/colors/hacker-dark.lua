local colorbuddy = require("colorbuddy")

-- Set up your custom colorscheme if you want
colorbuddy.colorscheme("hacker-dark")

-- And then modify as you like
local C = colorbuddy.Color
local c = colorbuddy.colors
local G = colorbuddy.Group
local g = colorbuddy.groups
local s = colorbuddy.styles

-- Use C.new(<name>, <#rrggbb>) to create new c
-- They can be accessed through c.<name>
-- C.new("bg_blue", "#1d2532")
C.new("white", "#dcdcdc")
C.new("red", "#ff636f")
C.new("green", "#9ddf6e")
C.new("blue", "#63b7fc")
C.new("grey", "#8c96a6")

C.new("pink", "#fef601")
C.new("yellow", "#f8fe7a")
C.new("aqua", "#b5cea8")
C.new("cyan", "#b7c9cc")
C.new("purple", "#8e6fbd")
C.new("violet", "#b294bb")
C.new("orange", "#de935f")
C.new("brown", "#a3685a")

C.new("bg_blue", "#1d2432")

-- C.new("white", "#ffffff")

-- Define highlights in terms of `c` and `g`
G.new("Normal", c.blue, c.bg_blue, s.none)
G.new("Function", g.Normal, nil, nil)
G.new("SignColumn", g.Normal, g.Normal, nil)

-- G.new("TermCursor", c.white, nil, nil)

G.new("Visual", nil, c.bg_blue:light(), nil)
G.new("TreesitterContext", g.Visual, g.Visual, nil)

G.new("LineNr", c.cyan, c.bg_blue, nil)

G.new("@type", g.Normal, nil, s.none)
G.new("@module", g.Normal, nil, nil)
G.new("@constant", g.Normal, nil, nil)

G.new("Operator", c.white, nil, s.none)
G.new("@function.bracket", g.Operator, nil, s.none)

G.new("Comment", c.grey, nil, s.italic)

G.new("Character", c.green, nil, s.none)

G.new("SpecialChar", c.aqua, nil, s.none)
G.new("@number", g.SpecialChar, nil, s.none)

G.new("@keyword", c.red, nil, s.bold)
G.new("@boolean", c.red, nil, s.bold)
G.new("@type.builtin", c.red, nil, s.bold)
G.new("@variable.builtin", c.red, nil, s.bold)
