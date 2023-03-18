Menu = {}

local logo = love.graphics.newImage("images/icon.png")
-- setFilter will prevent from pixel art antialiasing
logo:setFilter("nearest", "nearest")

local font = love.graphics.newFont("fonts/yoster.ttf", 64)

local alpha = 0

local startText = "Start"
local quitText = "Quit"

function Menu:init()
  Music:play()
end

function Menu:mousereleased(_, y, button)
  if button == 1 then
    local mouseY = y
    if mouseY > love.graphics.getHeight() * 0.5 and mouseY < love.graphics.getHeight() * 0.6 then
      love.mouse.setCursor()
      ButtonSound:play()
      Gamestate.push(Game)
    elseif mouseY > love.graphics.getHeight() * 0.7 and mouseY < love.graphics.getHeight() * 0.8 then
      ButtonSound:play()
      love.event.quit()
    end
  end
end

function Menu:update(dt)
  alpha = alpha + 1 * dt

  if alpha > 1 then
    alpha = 1
  end

  local mouseY = love.mouse.getY()
  startText = "Start"
  quitText = "Quit"
  love.mouse.setCursor()
  if mouseY > love.graphics.getHeight() * 0.5 and mouseY < love.graphics.getHeight() * 0.6 then
    startText = "< Start >"
    love.mouse.setCursor(love.mouse.getSystemCursor("hand"))
  elseif mouseY > love.graphics.getHeight() * 0.7 and mouseY < love.graphics.getHeight() * 0.8 then
    quitText = "< Quit >"
    love.mouse.setCursor(love.mouse.getSystemCursor("hand"))
  end
end

function Menu:draw()
  love.graphics.setColor(1, 1, 1, alpha)

  love.graphics.draw(logo, love.graphics:getWidth() / 2, love.graphics.getHeight() * 0.1, 0, 5, 5, logo:getWidth() / 2,
    logo:getHeight() / 2)

  love.graphics.printf("Main Menu", font, 0, love.graphics.getHeight() * 0.2, 960, "center")
  love.graphics.printf(startText, font, 0, love.graphics.getHeight() * 0.5, 960, "center")
  love.graphics.printf(quitText, font, 0, love.graphics.getHeight() * 0.7, 960, "center")
end
