Background = Object:extend()

local sky = love.graphics.newImage("images/sky.png")

local cloud = love.graphics.newImage("images/clouds.png")
cloud:setWrap("repeat", "repeat")
local cloudQuad = love.graphics.newQuad(0, 0, 2880, 540, cloud:getWidth(), cloud:getHeight())

local x = 0

local ocean = love.graphics.newImage("images/ocean.png")

function Background:update(dt)
  x = x - 10 * dt
  if x <= -1920 then
    x = 0
  end
end

function Background:draw()
  love.graphics.draw(sky)
  love.graphics.draw(cloud, cloudQuad, x, 0)
  love.graphics.draw(ocean, 0, love.graphics.getHeight() - 64)
end
