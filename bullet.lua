Bullet = Object:extend()

BulletList = {}

function Bullet:new(originX, originY, force, angle)
  self.x = originX
  self.y = originY
  self.force = force
  self.angle = angle
  self.gravity = 10
  self.gravityForce = 0
end

function Bullet:update(dt)
  self.gravityForce = self.gravityForce + self.gravity
  self.x = self.x + self.force * math.cos(self.angle) * dt
  self.y = self.y + self.force * math.sin(self.angle) * dt + self.gravityForce * dt
end

function Bullet:draw()
  love.graphics.circle("fill", self.x, self.y, 10)
end
