Game = {}

local background = Background()
local player = Player()

function Game:enter()
  enemy = Enemy("images/player-ship.png", 5, 16, 100, 5, 10)
end

function Game:mousereleased(x, y, button)
  player:mousereleased(button)
end

function Game:update(dt)
  background:update(dt)
  player:update(dt)
  enemy:update(dt)

  for _, bullet in ipairs(BulletList) do
    bullet:update(dt)
  end
end

function Game:draw()
  background:draw()
  player:draw()
  enemy:draw()

  for _, bullet in ipairs(BulletList) do
    bullet:draw()
  end
end
