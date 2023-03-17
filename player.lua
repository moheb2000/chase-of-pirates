Player = Object:extend()

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

  self.angle = 0

  self.speed = 10
end

function Player:update(dt)
  local mouseX, mouseY = love.mouse.getPosition()
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
end

function Player:draw()
  love.graphics.print("Angle: " .. self.angle)

  love.graphics.draw(self.ship, self.shipX, self.shipY, 0, 5, 5)

  -- We set x and y origin to the middle of cannon to rotate it properly
  love.graphics.draw(self.cannon, self.cannonX, self.cannonY, self.angle, 5, 5, self.cannon:getWidth() / 2,
  self.cannon:getHeight() / 2)
end
