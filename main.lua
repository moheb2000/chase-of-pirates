function love.load()
  Gamestate = require "libraries.hump.gamestate"
  Timer = require "libraries.hump.timer"
  Object = require "libraries.classic"

  require "background"
  require "bullet"
  require "player"

  require "boot"
  require "game"

  Gamestate.registerEvents()
  Gamestate.switch(Boot)
end
