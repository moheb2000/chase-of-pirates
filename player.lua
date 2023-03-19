Player = Object:extend()

local bulletForce = 0
local cooldownForce = 0
local maxBulletForce = 1000
local mouseX, mouseY = 0, 0

function Player:new()
  -- ship positions
  self.shipX = love.graphics:getWidth() - 200
  self.shipY = love.graphics:getHeight() - 200

  -- cannon positions based on ship
  self.cannonX = self.shipX + 5 * 5
  self.cannonY = self.shipY + 16 * 5

  self.ship = love.graphics.newImage("images/player-ship.png")
  self.ship:setFilter("nearest", "nearest")

  self.cannon = love.graphics.newImage("images/cannon.png")
  self.cannon:setFilter("nearest", "nearest")

  self.isCannonReady = true

  self.angle = 0

  self.speed = 10

  self.health = 100

  -- collision positions
  self.collisionLeft = self.shipX
  self.collisionRight = self.shipX + self.ship:getWidth() * 5
  self.collisionTop = self.shipY + 19
  self.collisionDown = self.shipY + self.ship:getHeight() * 5

  -- fire particle instance
  self.fireParticle = FireParticle:clone()
end

function Player:getHit()
  self.health = self.health - 10
  if self.health <= 0 then
    self.health = 0
    Gamestate.switch(Result, false)
  end
end

function Player:mousereleased(button)
  if button == 1 and self.isCannonReady then
    local bullet = Bullet(self.cannonX, self.cannonY, bulletForce, self.angle + math.pi)
    table.insert(PlayerBulletList, bullet)
    cooldownForce = bulletForce
    bulletForce = 0
    self.isCannonReady = false
  end
end

function Player:update(dt)
  mouseX, mouseY = love.mouse.getPosition()
  self.angle = math.atan2(mouseY - self.cannonY, mouseX - self.cannonX) + math.pi

  -- ship will go up and down
  self.shipY = self.shipY + self.speed * dt
  if self.shipY > love.graphics:getHeight() - 190 then
    self.shipY = love.graphics:getHeight() - 190
    self.speed = -self.speed
  elseif self.shipY < love.graphics:getHeight() - 200 then
    self.shipY = love.graphics:getHeight() - 200
    self.speed = -self.speed
  end
  -- We need to set cannonY here again because cannon must go up and down with ship too
  self.cannonY = self.shipY + 16 * 5

  -- Get Force with mouse down for bullet
  if love.mouse.isDown(1) and self.isCannonReady then
    bulletForce = bulletForce + 500 * dt
    if bulletForce > maxBulletForce then
      bulletForce = maxBulletForce
    end
  end

  -- cooldown logic
  if self.isCannonReady == false then
    cooldownForce = cooldownForce - 150 * dt
    if cooldownForce <= 0 then
      cooldownForce = 0
      self.isCannonReady = true
    end
  end

  -- fire particle update
  self.fireParticle:update(dt)
  if self.health < 30 then
    self.fireParticle:emit(64)
    self.fireParticle:setEmissionArea("normal", 15, 15)
  elseif self.health < 50 then
    self.fireParticle:emit(48)
    self.fireParticle:setEmissionArea("normal", 10, 10)
  elseif self.health < 90 then
    self.fireParticle:emit(32)
  end
end

function Player:draw()
  -- Add force circle around mouse press
  if bulletForce < maxBulletForce / 3 then
    love.graphics.setColor(love.math.colorFromBytes(96, 186, 57))
  elseif bulletForce < 2 * maxBulletForce / 3 then
    love.graphics.setColor(love.math.colorFromBytes(186, 156, 57))
  else
    love.graphics.setColor(love.math.colorFromBytes(186, 57, 57))
  end
  love.graphics.circle("fill", mouseX, mouseY, bulletForce * 0.04)
  love.graphics.setColor(1, 1, 1)

  -- add cooldown circle
  if self.isCannonReady == false then
    if cooldownForce < maxBulletForce / 3 then
      love.graphics.setColor(love.math.colorFromBytes(96, 186, 57))
    elseif cooldownForce < 2 * maxBulletForce / 3 then
      love.graphics.setColor(love.math.colorFromBytes(186, 156, 57))
    else
      love.graphics.setColor(love.math.colorFromBytes(186, 57, 57))
    end
    love.graphics.circle("fill", mouseX, mouseY, cooldownForce * 0.04)
    love.graphics.setColor(1, 1, 1)
  end

  love.graphics.draw(self.ship, self.shipX, self.shipY, 0, 5, 5)

  -- We set x and y origin to the middle of cannon to rotate it properly
  love.graphics.draw(self.cannon, self.cannonX, self.cannonY, self.angle, 5, 5, self.cannon:getWidth() / 2,
    self.cannon:getHeight() / 2)

  -- fire particle draw
  love.graphics.draw(self.fireParticle, self.shipX + self.ship:getWidth() * 5 / 2,
    self.shipY + self.ship:getHeight() * 5 / 2 + 25)

  -- draw health bar
  if self.health < 100 then
    love.graphics.setColor(love.math.colorFromBytes(252, 66, 63))
    love.graphics.rectangle("line", self.shipX, self.shipY - 50, self.ship:getWidth() * 5, 20)
    love.graphics.rectangle("fill", self.shipX, self.shipY - 50, self.ship:getWidth() * 5 * self.health / 100, 20)
    love.graphics.setColor(1, 1, 1)
  end
end
