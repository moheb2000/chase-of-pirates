Game = {}

local background = Background()
local player = Player()

function Game:mousereleased(x, y, button)
  player:mousereleased(button)
end

function Game:update(dt)
  background:update(dt)
  player:update(dt)

  for _, bullet in ipairs(BulletList) do
    bullet:update(dt)
  end
end

function Game:draw()
  background:draw()
  player:draw()

  for _, bullet in ipairs(BulletList) do
    bullet:draw()
  end
end
