Result = {}

local logo = love.graphics.newImage("images/icon.png")
-- setFilter will prevent from pixel art antialiasing
logo:setFilter("nearest", "nearest")

local font = love.graphics.newFont("fonts/yoster.ttf", 64)

local alpha = 0

local restartText = "Restart"
local menuText = "Main Menu"
local resultText = "You Won!"

function Result:enter(_, victory)
  if victory then
    resultText = "You Won!"
  else
    resultText = "You Lost!"
  end
end

function Result:mousereleased(_, y, button)
  if button == 1 then
    local mouseY = y
    if mouseY > love.graphics.getHeight() * 0.5 and mouseY < love.graphics.getHeight() * 0.6 then
      love.mouse.setCursor()
      Gamestate.push(Game)
    elseif mouseY > love.graphics.getHeight() * 0.7 and mouseY < love.graphics.getHeight() * 0.8 then
      Gamestate.pop()
    end
  end
end

function Result:update(dt)
  alpha = alpha + 1 * dt

  if alpha > 1 then
    alpha = 1
  end

  local mouseY = love.mouse.getY()
  restartText = "Restart"
  menuText = "Main Menu"
  love.mouse.setCursor()
  if mouseY > love.graphics.getHeight() * 0.5 and mouseY < love.graphics.getHeight() * 0.6 then
    restartText = "< Restart >"
    love.mouse.setCursor(love.mouse.getSystemCursor("hand"))
  elseif mouseY > love.graphics.getHeight() * 0.7 and mouseY < love.graphics.getHeight() * 0.8 then
    menuText = "< Main Menu >"
    love.mouse.setCursor(love.mouse.getSystemCursor("hand"))
  end
end

function Result:draw()
  love.graphics.setColor(1, 1, 1, alpha)

  love.graphics.draw(logo, love.graphics:getWidth() / 2, love.graphics.getHeight() * 0.1, 0, 5, 5, logo:getWidth() / 2,
    logo:getHeight() / 2)

  love.graphics.printf(resultText, font, 0, love.graphics.getHeight() * 0.2, 960, "center")
  love.graphics.printf(restartText, font, 0, love.graphics.getHeight() * 0.5, 960, "center")
  love.graphics.printf(menuText, font, 0, love.graphics.getHeight() * 0.7, 960, "center")
end

