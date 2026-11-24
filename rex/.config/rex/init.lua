-- rex config, tmux-ish. prefix is ctrl+a
-- reload: rex config reload    check: rex config check

local HOME  = os.getenv("HOME")
local SHELL = "com.superlogical.terminal.shell"
local P     = "ctrl+a>"

-- same roots as tmux-sessionizer
local ROOTS = {
  HOME .. "/dev", HOME .. "/personal", HOME .. "/thirdparty",
  HOME .. "/personal/nvim_plugins", HOME .. "/work", HOME,
}

local function expand(p) return (p:gsub("^~", HOME):gsub("/+$", "")) end
-- basename, dots to underscores (like tmux-sessionizer)
local function session_name(dir) return (dir:match("[^/]+$"):gsub("%.", "_")) end

-- session.list result shape isn't documented, so read it loosely
local function sessions()
  local r = rex.call("session.list") or {}
  return r.sessions or r
end
local function sid_of(s) return s.session_id or s.id end
local function label_of(s) return s.label or s.name end

-- go to the session named after dir, or make it there
local function open_dir(dir)
  dir = expand(dir)
  local name = session_name(dir)
  for _, s in ipairs(sessions()) do
    if label_of(s) == name then
      rex.client.queue("session.select", { session_id = sid_of(s) })
      return
    end
  end
  local s, err = rex.call("session.create", { label = name })
  if err then error(err, 0) end
  local sid = sid_of(s) or (s.session and sid_of(s.session))
  local _, werr = rex.session.new_window{
    session_id = sid,
    layout = rex.layout.block{ flavor = SHELL, options = { cwd = dir } },
  }
  if werr then error(werr, 0) end
  rex.client.queue("session.select", { session_id = sid })
end

rex.action{
  name = "sessionizer", title = "Sessionizer…", keywords = "project dir tmux",
  run = function()
    local argv = { "find" }
    for _, r in ipairs(ROOTS) do argv[#argv + 1] = r end
    for _, a in ipairs{ "-mindepth", "1", "-maxdepth", "1", "-type", "d" } do
      argv[#argv + 1] = a
    end
    -- find exits non-zero for missing roots; stdout is still good
    local r, err = rex.exec(argv, { timeout = 5 })
    if not r then error(err, 0) end
    local items, seen = {}, {}
    for dir in r.stdout:gmatch("[^\n]+") do
      if #items >= 2000 then break end
      if not seen[dir] then
        seen[dir] = true
        items[#items + 1] = {
          id = dir, title = dir:match("[^/]+$"),
          subtitle = (dir:gsub("^" .. HOME, "~")), icon = "folder",
        }
      end
    end
    local dir = rex.ui.pick{ title = "Open project", placeholder = "Filter dirs", items = items }
    if dir then open_dir(dir) end
  end,
}

rex.action{
  name = "goto_dir", title = "Go to Dir Session",
  args = { dir = "string" },
  run = function(_, a) open_dir(a.dir) end,
}

---- prefix basics
rex.bind(P .. "ctrl+a", "client.tab.back")                    -- C-a C-a: last window
rex.bind(P .. "a", "pane.send_key", { key = "ctrl+a" })       -- send-prefix
rex.bind(P .. "shift+6", "client.tab.back")                   -- ^
rex.bind(P .. "tab", "client.tab.back")                       -- no last-session action; closest
rex.bind(P .. "space", "client.tab.back")

---- tabs / sessions
rex.bind(P .. "c", "client.tab.new")
rex.bind(P .. "n", "client.tab.next")
rex.bind(P .. "p", "client.tab.previous")
rex.bind(P .. "s", "session.switch")
rex.bind(P .. "f", "sessionizer")

---- panes
rex.bind(P .. "h", "pane.focus.left")
rex.bind(P .. "j", "pane.focus.down")
rex.bind(P .. "k", "pane.focus.up")
rex.bind(P .. "l", "pane.focus.right")
rex.bind(P .. "shift+'", "pane.split.down")                   -- "
rex.bind(P .. "shift+5", "pane.split.right")                  -- %
rex.bind(P .. "t", "pane.split.down")
rex.bind(P .. "shift+t", "pane.split.right")
rex.bind(P .. "z", "pane.zoom")
rex.bind(P .. "x", "pane.close")

---- resize mode: C-a R, then hjkl (hold to repeat), Esc/Enter to leave
rex.mode("resize", { exclusive = true })
rex.bind(P .. "shift+r", "client.mode.enter", { name = "resize" })
rex.bind("resize/h", "pane.resize.left")
rex.bind("resize/j", "pane.resize.down")
rex.bind("resize/k", "pane.resize.up")
rex.bind("resize/l", "pane.resize.right")
rex.bind("resize/=", "pane.balance")
rex.bind("resize/enter", "client.mode.exit")

---- dir sessions, same keys as tmux
rex.bind(P .. "shift+o", "goto_dir", { dir = "~/dotfiles" })
rex.bind(P .. "shift+n", "goto_dir", { dir = "~/personal/notes" })
rex.bind(P .. "shift+j", "goto_dir", { dir = "~/personal/job_search" })
rex.bind(P .. "shift+s", "goto_dir", { dir = "~/thirdparty/javaimpatient" })
rex.bind(P .. "shift+c", "goto_dir", { dir = "~/personal/cv_resume_2026" })
rex.bind(P .. "shift+a", "goto_dir", { dir = "~/personal/ai" })
