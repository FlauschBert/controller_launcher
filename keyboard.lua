local keyboard = {}

local A = false
local B = false
local X = false
local Y = false

function keyboard.down_A()
  return A
end
function keyboard.down_B()
  return B
end
function keyboard.down_X()
  return X
end
function keyboard.down_Y()
  return Y
end

function love.keypressed(key, scancode, isrepeat)
  if key == "a" then
    A = true
  end
  if key == "b" then
    B = true
  end
  if key == "x" then
    X = true
  end
  if key == "y" then
    Y = true
  end
end
function love.keyreleased(key, scancode)
  if key == "a" then
    A = false
  end
  if key == "b" then
    B = false
  end
  if key == "x" then
    X = false
  end
  if key == "y" then
    Y = false
  end
end

return keyboard
