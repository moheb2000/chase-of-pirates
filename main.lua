function love.load()
  Gamestate = require "libraries.hump.gamestate"
  Timer = require "libraries.hump.timer"
  Object = require "libraries.classic"

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
