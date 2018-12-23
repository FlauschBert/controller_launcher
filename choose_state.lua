local gamepad = require("gamepad")

local choose_state = {}

local options = {}
local active = nil

function choose_state:init()
  -- Steam Big Picture Mode
  local steam = {}
  steam.desc_key = "A"
  steam.desc_text = "Steam Big Picture Mode"
  steam.directory = "C:\\Program Files (x86)\\Steam"
  steam.command = "Steam.exe"
  steam.parameters = ""
  steam.input = gamepad.down_A
  steam.started = false
  table.insert(options, steam)
  -- Mass Effect Andromeda Mode Launcher
  local mass_effect = {}
  mass_effect.desc_key = "X"
  mass_effect.desc_text = "Mass Effect Andromeda Mod Launcher"
  mass_effect.directory = "C:\\Users\\steam\\Downloads\\FrostyModManager_v1.0.4.2"
  mass_effect.command = "FrostyModManager.exe"
  mass_effect.parameters = "-launch Default"
  mass_effect.input = gamepad.down_X
  mass_effect.started = false
  table.insert(options, mass_effect)
  -- Reboot
  local reboot = {}
  reboot.desc_key = "B"
  reboot.desc_text = "Reboot system"
  reboot.directory = ""
  reboot.command = "shutdown"
  reboot.parameters = "/r /t 0"
  reboot.input = gamepad.down_B
  reboot.started = false
  table.insert(options, reboot)
  -- Shutdown
  local shutdown = {}
  shutdown.desc_key = "Y"
  shutdown.desc_text = "Shutdown system"
  shutdown.directory = ""
  shutdown.command = "shutdown"
  shutdown.parameters = "/s /t 0"
  shutdown.input = gamepad.down_Y
  shutdown.started = false
  table.insert(options, shutdown)
end

function choose_state:enter()
end

function choose_state:draw()
  local height = 60
  for _,option in ipairs(options) do
    love.graphics.printf(option.desc_key, 30, height, love.graphics.getWidth())
    love.graphics.printf(option.desc_text, 80, height, love.graphics.getWidth())
    height = height + 50
  end
end

function choose_state:update(dt)
  if not active then
    for _,option in ipairs(options) do
      if option.input () then
        active = option
        return
      end
    end
  elseif not active.started then
    active.started = true
    -- directory handling
    local directory = ''
    if string.len (active.directory) > 0 then
      directory = '/D"'..active.directory..'" '
    end
    local command = 'start '..directory..active.command..' '..active.parameters
    os.execute(command)
  end
end

return choose_state
