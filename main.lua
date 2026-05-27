WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243
HVW = VIRTUAL_WIDTH / 2
HVH = VIRTUAL_HEIGHT / 2
PADDLE_SPEED = 200
push = require("push")
function love.load()
	love.graphics.setDefaultFilter("nearest", "nearest")
	font = love.graphics.newFont("font.ttf", 32)
	love.graphics.setFont(font)
	love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, { resizable = false, vsync = false, fullscreen = false })
	push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT)

	p1Score = 0
	p1y = 10
	p2Score = 0
	p2y = VIRTUAL_HEIGHT - 30
end
function love.keypressed(key)
	if key == "escape" then
		love.event.quit()
	end
end
function love.update(dt)
	if love.keyboard.isDown("w") then
		p1y = math.max(p1y - PADDLE_SPEED * dt, 0)
	elseif love.keyboard.isDown("s") then
		p1y = math.min(p1y + PADDLE_SPEED * dt, VIRTUAL_HEIGHT - 20)
	end
	if love.keyboard.isDown("up") then
		p2y = math.max(p2y - PADDLE_SPEED * dt, 0)
	elseif love.keyboard.isDown("down") then
		p2y = math.min(p2y + PADDLE_SPEED * dt, VIRTUAL_HEIGHT - 20)
	end
end
function love.draw()
	push:start()
	love.graphics.clear(40 / 255, 45 / 255, 52 / 255, 1)
	-- paddle 1
	love.graphics.rectangle("fill", 10, p1y, 5, 20)
	-- paddle 2
	love.graphics.rectangle("fill", VIRTUAL_WIDTH - 15, p2y, 5, 20)
	-- ball
	love.graphics.rectangle("fill", HVW - 2, HVH - 2, 4, 4)
	-- p1 score
	love.graphics.print(tostring(p1Score), HVW - 50, HVH - 80)
	-- p2 score
	love.graphics.print(tostring(p2Score), HVW + 30, HVH - 80)
	push:finish()
end
