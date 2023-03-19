local img = love.graphics.newImage("images/drop.png")

DropX = 0
DropY = 0

DropParticle = love.graphics.newParticleSystem(img, 6)

DropParticle:setParticleLifetime(0.1, 0.5)

DropParticle:setLinearAcceleration(0, 50, 0, 200)

DropParticle:setDirection(-math.pi / 4)

DropParticle:setBufferSize(4)

DropParticle:setEmissionArea("borderrectangle", 10, 10)
