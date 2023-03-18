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

  for i, bullet in ipairs(PlayerBulletList) do
    bullet:update(dt)
    if bullet.dead then
      table.remove(PlayerBulletList, i)
    end
    -- check collision for enemy
    if bullet:checkCollision(enemy.collisionLeft, enemy.collisionRight, enemy.collisionTop, enemy.collisionDown) then
      enemy:getHit()
    end
  end

  for i, bullet in ipairs(EnemyBulletList) do
    bullet:update(dt)
    if bullet.dead then
      table.remove(EnemyBulletList, i)
    end
    -- check collision for player
    if bullet:checkCollision(player.collisionLeft, player.collisionRight, player.collisionTop, player.collisionDown) then
      player:getHit()
    end
  end
end

function Game:draw()
  background:draw()
  player:draw()
  enemy:draw()

  for _, bullet in ipairs(PlayerBulletList) do
    bullet:draw()
  end

  for _, bullet in ipairs(EnemyBulletList) do
    bullet:draw()
  end
end
