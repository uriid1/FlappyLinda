-- Levels
levels = {};
level = 0;
dt = 1 / 60;

-- Load error screen
require "engine/errorscr"

love.mouse.setVisible(false)

global = {}
if love.system.getOS() == "Android" or love.system.getOS() == "Ios" then
	love.window.setFullscreen(true)
	global.device = "phone"
end

--
if love.system.getOS() == "OS X" or love.system.getOS() == "Windows" or love.system.getOS() == "Linux" then
	imageData = love.image.newImageData( "icon.png" ) 
	success = love.window.setIcon(imageData)
	--
	love.window.setMode(480, 720, {resizable=false, fullscreen=false})
	global.device = "pc"
end
ratio = math.ceil(love.graphics.getWidth() / love.graphics.getHeight())

-- load engine
require "engine/engine"
require "engine/collision"
require "engine/sheet"
require "engine/class"
require "engine/easing"

-- load libs
lume  = require "libs/lume"
audio = require "libs/wave"

-- Load lvl
require "assets/lvl/lvl0"
require "assets/lvl/lvl1"

-- exec lvl
levels[level]()