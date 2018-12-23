local gamestate = require "ext/gamestate"

function love.load(arg)
  -- for debugging with zero brane
  if arg[#arg] == "-debug" then
    require("mobdebug").start()
  end
  
  -- setup font (size)
  love.graphics.setNewFont("font/aller_bd.ttf",30)

  -- Start the gamestate manager and move to the title state
  gamestate.registerEvents{"update","draw"}
  gamestate.switch(require "choose_state")

  love.window.setTitle("Controller Launcher")
end
