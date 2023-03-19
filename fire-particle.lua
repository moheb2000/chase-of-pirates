local img = love.graphics.newImage("images/fire.png")

FireParticle = love.graphics.newParticleSystem(img, 64)

FireParticle:setColors({ 252 / 255, 240 / 255, 17 / 255 }, { 252 / 255, 138 / 255, 17 / 255 },
{ 252 / 255, 60 / 255, 17 / 255 })

FireParticle:setParticleLifetime(0.5, 1)

FireParticle:setLinearAcceleration(0, -50, 0, -200)

FireParticle:setDirection(-math.pi / 4)

FireParticle:setEmissionArea("normal", 5, 5)
