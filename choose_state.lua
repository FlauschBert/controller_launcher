local gamepad = require("gamepad")
local keyboard = require("keyboard")

local choose_state = {}

local options = {}
local active = nil

local function add_mass_effect_andromeda_launcher (option)
  option.desc_text = "Mass Effect Andromeda Mod Launcher"
  option.directory = "C:\\Users\\steam\\Downloads\\FrostyModManager_v1.0.4.2"
  option.command = "FrostyModManager.exe"
  option.parameters = "-launch Default"
end
local function add_steam_launcher (option)
  option.desc_text = "Steam Big Picture Mode"
  option.directory = "C:\\Program Files (x86)\\Steam"
  option.command = "Steam.exe"
  option.parameters = ""
end
local function add_minecraft_server (option)
  option.desc_text = "Minecraft Server 1.13.2"
  option.directory = "D:\\Minecraft_1_13_2"
  option.command = "java"
  option.parameters = "-Xmx1024M -Xms1024M -jar server.jar nogui"
end
local function add_minecraft_backup (option)
  local date = os.date ("%Y%m%dT%H%M%S")
  local minecraft_dir = "D:/Minecraft_1_13_2"
  option.desc_text = "Minecraft Backup"
  option.directory = "C:\\Program Files\\7-Zip"
  option.command = "7z.exe"
  -- a create archive
  -- dst archive name
  -- src directory
  -- exclusions with wildcard
  option.parameters = "a "..minecraft_dir.."/backup/"..date..".zip "..minecraft_dir.."/* -xr!client -xr!logs -xr!backup -x!*.jar"
end
local function add_reboot (option)
  option.desc_text = "Reboot system"
  option.directory = ""
  option.command = "shutdown"
  option.parameters = "/r /t 0"
end
local function add_shutdown (option)
  option.desc_text = "Shutdown system"
  option.directory = ""
  option.command = "shutdown"
  option.parameters = "/s /t 0"
end

local function add_input_A (option)
  option.desc_key = "A"
  option.input = {}
  table.insert (option.input, gamepad.down_A)
  table.insert (option.input, keyboard.down_A)
end
local function add_input_B (option)
  option.desc_key = "B"
  option.input = {}
  table.insert (option.input, gamepad.down_B)
  table.insert (option.input, keyboard.down_B)
end
local function add_input_X (option)
  option.desc_key = "X"
  option.input = {}
  table.insert (option.input, gamepad.down_X)
  table.insert (option.input, keyboard.down_X)
end
local function add_input_Y (option)
  option.desc_key = "Y"
  option.input = {}
  table.insert (option.input, gamepad.down_Y)
  table.insert (option.input, keyboard.down_Y)
end

local function add_option (option)
  option.started = false
  table.insert (options, option)
end

local function start (option)
  -- directory handling
  local directory = ''
  if string.len (option.directory) > 0 then
    directory = '/D"'..option.directory..'" '
  end
  -- start command
  local command = 'start '..directory..option.command..' '..option.parameters
  os.execute(command)
end

function choose_state:init()
  -- Steam Big Picture Mode
  local steam = {}
  add_steam_launcher (steam)
  add_input_A (steam)
  add_option (steam)

  -- Minecraft (steam big picture mode)
  local minecraft = {}
  -- backup files first
  add_minecraft_backup (minecraft)
  -- start server
  minecraft.follow_up = {}
  add_minecraft_server (minecraft.follow_up)
  -- run steam in big picture mode
  minecraft.follow_up.follow_up = {}
  add_steam_launcher (minecraft.follow_up.follow_up)
  -- Adapt description
  minecraft.desc_text = "Minecraft (backup, server and steam big picture mode)"
  add_input_X (minecraft)
  add_option (minecraft)

  -- Reboot
  local reboot = {}
  add_reboot (reboot)
  add_input_B (reboot)
  add_option (reboot)

  -- Shutdown
  local shutdown = {}
  add_shutdown (shutdown)
  add_input_Y (shutdown)
  add_option (shutdown)
end

function choose_state:enter()
end

function choose_state:draw()
  local height = 60

  -- show triggered item
  if active and active.started then
    love.graphics.printf (active.desc_key, 30, height, love.graphics.getWidth())
    love.graphics.printf (active.desc_text .. ' started...', 60, height, love.graphics.getWidth())
    return
  end

  -- show all items
  for _,option in ipairs(options) do
    love.graphics.printf(option.desc_key, 30, height, love.graphics.getWidth())
    love.graphics.printf(option.desc_text, 80, height, love.graphics.getWidth())
    height = height + 50
  end
end

function choose_state:update(dt)
  if not active then
    for _,option in ipairs (options) do
      for _,input in ipairs (option.input) do
        if input () then
          active = option
          return
        end
      end
    end
  elseif not active.started then
    active.started = true
    local option = active
    while option do
      start (option)
      love.timer.sleep (1)
      option = option.follow_up
    end
  end
end

return choose_state
