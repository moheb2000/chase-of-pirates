function love.load()
  Gamestate = require "libraries.hump.gamestate"
  Timer = require "libraries.hump.timer"
  Object = require "libraries.classic"

  CannonSound = love.audio.newSource("sounds/cannon.wav", "static")
  HitSound = love.audio.newSource("sounds/hit.wav", "static")
  ButtonSound = love.audio.newSource("sounds/button.wav", "static")
  BulletSea = love.audio.newSource("sounds/cannon_miss.ogg", "static")

  BootMusic = love.audio.newSource("sounds/boot.ogg", "stream")

  Music = love.audio.newSource("sounds/music.wav", "stream")
  Music:setLooping(true)

  require "background"
  require "bullet"
  require "player"
  require "enemy"
  require "drop-particle"
  require "fire-particle"

  require "boot"
  require "help"
  require "menu"
  require "game"
  require "result"

  Gamestate.registerEvents()
  Gamestate.switch(Boot)
end
