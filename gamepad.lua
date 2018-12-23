local gamepad = {}

local A = false
local B = false
local X = false
local Y = false

function gamepad.down_A()
  return A
end
function gamepad.down_B()
  return B
end
function gamepad.down_X()
  return X
end
function gamepad.down_Y()
  return Y
end

function love.gamepadpressed(joystick, button)
  if button == "a" then
    A = true
  end
  if button == "b" then
    B = true
  end
  if button == "x" then
    X = true
  end
  if button == "y" then
    Y = true
  end
end
function love.gamepadreleased(joystick, button)
  if button == "a" then
    A = false
  end
  if button == "b" then
    B = false
  end
  if button == "x" then
    X = false
  end
  if button == "y" then
    Y = false
  end
end

return gamepad
