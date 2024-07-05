local obj = {}
obj.__index = obj

-- Metadata
obj.name = "Rcmd"
obj.version = "0.1"
obj.author = "gnudad <gnudad@icloud.com>"
obj.homepage = "https://github.com/gnudad/Rcmd.spoon"
obj.license = "MIT - https://opensource.org/licenses/MIT"

local events = { hs.eventtap.event.types.flagsChanged }
local rcmd = hs.eventtap.event.rawFlagMasks.deviceRightCommand

function obj:init()
  self.active = false
  self.modal = hs.hotkey.modal.new()
  self.eventtap = hs.eventtap.new(events, function(event)
    if (event:rawFlags() & rcmd) > 0 and not self.active then
      self.active = true
      self.modal:enter()
    elseif (event:rawFlags() & rcmd) == 0 and self.active then
      self.active = false
      self.modal:exit()
    end
  end)
  return self
end

function obj:bindHotkeys(mapping)
  for key, name in pairs(mapping) do
    local mods = { "cmd" }
    if key ~= string.lower(key) then
      table.insert(mods, "shift")
    end
    self.modal:bind(mods, key, function()
      if type(name) == "function" then
        name()
      elseif type(name) == "string" then
        local app = hs.application.frontmostApplication()
        if name:find(app:title()) then
          app:hide()
        else
          hs.application.launchOrFocus(name)
        end
      else
        hs.alert("[Rcmd] Invalid type: " .. type(name))
      end
    end)
  end
  return self
end

function obj:start()
  self.eventtap:start()
end

function obj:stop()
  self.eventtap:stop()
end

return obj
