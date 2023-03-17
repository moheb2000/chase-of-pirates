Game = {}

local sky = love.graphics.newImage("images/sky.png")
local cloud = love.graphics.newImage("images/clouds.png")
cloud:setWrap("repeat", "repeat")
local cloudQuad = love.graphics.newQuad(0, 0, 2880, 540, cloud:getWidth(), cloud:getHeight())
local x = 0

function Game:update(dt)
  x = x - 10 * dt
  if x <= -1920 then
    x = 0
  end
end

function Game:draw()
  love.graphics.draw(sky)
  love.graphics.draw(cloud, cloudQuad, x, 0)
end
