Boot = {}

local logo = love.graphics.newImage("images/icon.png")
-- setFilter will prevent from pixel art antialiasing
logo:setFilter("nearest", "nearest")

local font = love.graphics.newFont("fonts/yoster.ttf", 64)

local alpha = 0

local fadeIn = true
local fadeTimer = false

local bootTimer = Timer.new()

function Boot:update(dt)
  bootTimer:update(dt)

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
      bootTimer:after(2, function() fadeIn = false end)
    end
  elseif alpha < 0 then
    alpha = 0
    -- setColor must back to normal before switching to the next scene
    love.graphics.setColor(1, 1, 1, 1)
    Gamestate.switch(Game)
  end
end

function Boot:draw()
  love.graphics.setColor(1, 1, 1, alpha)

  love.graphics.draw(logo, love.graphics:getWidth() / 2, love.graphics.getHeight() * 0.3, 0, 10, 10, logo:getWidth() / 2,
    logo:getHeight() / 2)

  love.graphics.printf("Chase of Pirates", font, 0, love.graphics.getHeight() * 0.5, 960, "center")
end
