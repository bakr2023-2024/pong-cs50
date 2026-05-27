WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243
HVW = VIRTUAL_WIDTH / 2
HVH = VIRTUAL_HEIGHT / 2
push = require("push")
function love.load()
	love.graphics.setDefaultFilter("nearest", "nearest")
	font = love.graphics.newFont("font.ttf", 32)
	love.graphics.setFont(font)
	love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, { resizable = false, vsync = false, fullscreen = false })
	push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT)

	p1Score = 0
	p2Score = 0
end
function love.keypressed(key)
	if key == "escape" then
		love.event.quit()
	end
end
function love.draw()
	push:start()
	love.graphics.clear(40 / 255, 45 / 255, 52 / 255, 1)
	-- paddle 1
	love.graphics.rectangle("fill", 10, 10, 5, 20)
	-- paddle 2
	love.graphics.rectangle("fill", VIRTUAL_WIDTH - 15, VIRTUAL_HEIGHT - 30, 5, 20)
	-- ball
	love.graphics.rectangle("fill", HVW - 2, HVH - 2, 4, 4)
	-- p1 score
	love.graphics.print(tostring(p1Score), HVW - 50, HVH - 80)
	-- p2 score
	love.graphics.print(tostring(p2Score), HVW + 30, HVH - 80)
	push:finish()
end
