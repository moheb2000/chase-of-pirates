Bullet = Object:extend()

PlayerBulletList = {}
EnemyBulletList = {}

function Bullet:new(originX, originY, force, angle)
  self.x = originX
  self.y = originY
  self.force = force
  self.angle = angle
  self.gravity = 10
  self.gravityForce = 0
  self.dead = false

  CannonSound:play()
end

function Bullet:checkCollision(b_left, b_right, b_top, b_bottom)
  local r = 10
  local a_left = self.x - r
  local a_right = self.x + r
  local a_top = self.y - r
  local a_bottom = self.y + r

  if a_right > b_left
      and a_left < b_right
      and a_bottom > b_top
      and a_top < b_bottom then
    self.dead = true
    HitSound:play()
    return true
  end

  return false
end

function Bullet:update(dt, windForce)
  self.gravityForce = self.gravityForce + self.gravity
  self.x = self.x + self.force * math.cos(self.angle) * dt - (windForce - 10) * 10 * dt
  self.y = self.y + self.force * math.sin(self.angle) * dt + self.gravityForce * dt

  -- clean up bullets: if bullet go outside of window
  local r = 10
  if self.x + r <= 0 or
      self.x - r >= love.graphics:getWidth() then
    self.dead = true
  end
  if self.y + r >= love.graphics:getHeight() - 32 then
    BulletSea:play()
    DropX = self.x
    DropY = self.y
    DropParticle:emit(6)
    self.dead = true
  end
end

function Bullet:draw()
  love.graphics.setColor(0, 0, 0)
  love.graphics.circle("fill", self.x, self.y, 10)
  love.graphics.setColor(1, 1, 1)
end
