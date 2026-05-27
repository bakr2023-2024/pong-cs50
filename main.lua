WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243
push = require("push")
function love.load()
	love.graphics.setDefaultFilter("nearest", "nearest")
	font = love.graphics.newFont("font.ttf", 32)
	love.graphics.setFont(font)
	love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, { resizable = false, vsync = false, fullscreen = false })
	push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT)
end
function love.keypressed(key)
	if key == "escape" then
		love.event.quit()
	end
end
function love.draw()
	push:start()
	love.graphics.clear(45 / 255, 50 / 255, 20 / 255, 1)
	love.graphics.printf("Hello Pong!", 0, VIRTUAL_HEIGHT / 2 - 16, VIRTUAL_WIDTH, "center")
	push:finish()
end
