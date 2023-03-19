Help = {}

local logo = love.graphics.newImage("images/icon.png")
-- setFilter will prevent from pixel art antialiasing
logo:setFilter("nearest", "nearest")

local font = love.graphics.newFont("fonts/yoster.ttf", 64)
local fontP = love.graphics.newFont("fonts/yoster.ttf", 28)

local alpha = 0

local fadeIn = true
local fadeTimer = false

local helpTimer = Timer.new()

function Help:update(dt)
  helpTimer:update(dt)

  if fadeIn then
    alpha = alpha + 1 * dt
  else
    alpha = alpha - 1 * dt
  end

  if alpha > 1 then
    alpha = 1
    -- Timer must set once so we check fadeTimer to see if we set Timer before or not
    if fadeTimer == false then
      fadeTimer = true
      -- Boot screen will be in alpha 1 state in 2 seconds and after that fadeIn will be false
      helpTimer:after(8, function() fadeIn = false end)
    end
  elseif alpha < 0 then
    alpha = 0
    -- setColor must back to normal before switching to the next scene
    love.graphics.setColor(1, 1, 1, 1)
    Gamestate.switch(Menu)
  end
end

function Help:draw()
  love.graphics.setColor(1, 1, 1, alpha)

  love.graphics.draw(logo, love.graphics:getWidth() / 2, love.graphics.getHeight() * 0.1, 0, 5, 5, logo:getWidth() / 2,
    logo:getHeight() / 2)

  love.graphics.printf("Help", font, 0, love.graphics.getHeight() * 0.2, 960, "center")
  love.graphics.printf("You are the greatest captain of all britain army. Pirates want to destroy your ship to attack your cities!\n\nHold left key = Fire cannon\n\nRight click = Back to main menu\n\nClouds will show you the wind speed", fontP, 0, love.graphics.getHeight() * 0.4, 960, "center")
end
