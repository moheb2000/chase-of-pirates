Enemy = Object:extend()

function Enemy:new(img, cannonPosX, cannonPosY, health, cooldown, attackSpeed)
  -- enemy ship positions
  self.shipX = 40
  self.shipY = love.graphics:getHeight() - 200

  -- cannon positions based on ship
  self.cannonPosX = cannonPosX
  self.cannonPosY = cannonPosY
  self.cannonX = self.shipX + cannonPosX * 5
  self.cannonY = self.shipY + cannonPosY * 5

  self.ship = love.graphics.newImage(img)
  self.ship:setFilter("nearest", "nearest")

  self.cannon = love.graphics.newImage("images/cannon.png")
  self.cannon:setFilter("nearest", "nearest")

  self.angle = 0

  self.speed = 10

  self.health = health

  self.cooldown = cooldown

  self.attackSpeed = attackSpeed

  -- set a timer for firing a boolet
  self.cooldownTimer = Timer.new()

  -- firing random bullets
  local count = 0
  self.cooldownTimer:every(self.cooldown, function()
    count = count + 1
    local minForce = 500 - (30 / self.cooldown) * count
    local maxForce = 700 - (30 / self.cooldown) * count
    local bulletForce = love.math.random(minForce, maxForce)
    self.angle = -(love.math.random() * math.pi / 6 + math.pi / 6)
    local bullet = Bullet(self.cannonX, self.cannonY, bulletForce, self.angle)
    table.insert(EnemyBulletList, bullet)
  end)

  -- collision positions
  self.collisionLeft = self.shipX
  self.collisionRight = self.shipX + self.ship:getWidth() * 5
  self.collisionTop = self.shipY + 19
  self.collisionDown = self.shipY + self.ship:getHeight() * 5
end

function Enemy:getHit()
  self.health = self.health - 10
  if self.health < 0 then
    self.health = 0
  end
end

function Enemy:update(dt)
  self.cooldownTimer:update(dt)
  -- ship will go up and down
  self.shipY = self.shipY + self.speed * dt
  if self.shipY > love.graphics:getHeight() - 185 then
    self.shipY = love.graphics:getHeight() - 185
    self.speed = -self.speed
  elseif self.shipY < love.graphics:getHeight() - 200 then
    self.shipY = love.graphics:getHeight() - 200
    self.speed = -self.speed
  end
  -- We need to set cannonY here again because cannon must go up and down with ship too
  self.cannonX = self.shipX + self.cannonPosX * 5
  self.cannonY = self.shipY + self.cannonPosY * 5

  -- Ship has x direction speed
  self.shipX = self.shipX + self.attackSpeed * dt

  -- collision positions must update every frame
  -- collision positions
  self.collisionLeft = self.shipX
  self.collisionRight = self.shipX + self.ship:getWidth() * 5
  self.collisionTop = self.shipY + 19
  self.collisionDown = self.shipY + self.ship:getHeight() * 5
end

function Enemy:draw()
  love.graphics.draw(self.ship, self.shipX, self.shipY, 0, 5, 5)

  -- We set x and y origin to the middle of cannon to rotate it properly
  love.graphics.draw(self.cannon, self.cannonX, self.cannonY, self.angle + math.pi, 5, 5, self.cannon:getWidth() / 2,
    self.cannon:getHeight() / 2)

  -- draw health bar
  if self.health < 100 then
    love.graphics.setColor(love.math.colorFromBytes(252, 66, 63))
    love.graphics.rectangle("line", self.shipX, self.shipY - 50, self.ship:getWidth() * 5, 20)
    love.graphics.rectangle("fill", self.shipX, self.shipY - 50, self.ship:getWidth() * 5 * self.health / 100, 20)
    love.graphics.setColor(1, 1, 1)
  end
end
