function love.load()
  Gamestate = require "libraries.hump.gamestate"
  Timer = require "libraries.hump.timer"

  require "boot"
  require "game"

  Gamestate.registerEvents()
  Gamestate.switch(Boot)
end
