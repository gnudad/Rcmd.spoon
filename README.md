# Rcmd.spoon

Switch apps using the right command key.
Inspired by [rcmd](https://lowtechguys.com/rcmd/) app.

## Install
```bash
mkdir -p ~/.hammerspoon/Spoons
git clone https://github.com/gnudad/Rcmd.spoon.git ~/.hammerspoon/Spoons/Rcmd.spoon
```

## Configure
Add to `~/.hammerspoon/init.lua`
```lua
hs.loadSpoon("Rcmd"):bindHotkeys({
  s = "Safari",
  m = "Mail",
  h = function()
    hs.application.frontmostApplication():hide()
  end,
}):start()

```
