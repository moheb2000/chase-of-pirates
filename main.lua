function love.load()
  Gamestate = require "libraries.hump.gamestate"
  Timer = require "libraries.hump.timer"
  Object = require "libraries.classic"

  CannonSound = love.audio.newSource("sounds/cannon.wav", "static")
  HitSound = love.audio.newSource("sounds/hit.wav", "static")
  ButtonSound = love.audio.newSource("sounds/button.wav", "static")
  BulletSea = love.audio.newSource("sounds/cannon_miss.ogg", "static")

  require "background"
  require "bullet"
  require "player"
  require "enemy"

  require "boot"
  require "menu"
  require "game"
  require "result"

  Gamestate.registerEvents()
  Gamestate.switch(Boot)
end
