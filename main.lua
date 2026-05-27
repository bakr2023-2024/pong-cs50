WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243
HVW = VIRTUAL_WIDTH / 2
HVH = VIRTUAL_HEIGHT / 2

Class = require("class")
require("Paddle")
require("Ball")
PADDLE_SPEED = 200
State = {
	PAUSE = 1,
	PLAY = 2,
}
push = require("push")
function love.load()
	love.window.setTitle("Pong")
	love.graphics.setDefaultFilter("nearest", "nearest")
	largeFont = love.graphics.newFont("font.ttf", 32)
	smallFont = love.graphics.newFont("font.ttf", 8)
	love.graphics.setFont(largeFont)
	love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, { resizable = false, vsync = false, fullscreen = false })
	push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT)

	math.randomseed(os.time())
	gameState = State.PAUSE

	player1 = Paddle(10, 10, 5, 20)
	player2 = Paddle(VIRTUAL_WIDTH - 15, VIRTUAL_HEIGHT - 30, 5, 20)
	ball = Ball(HVW - 2, HVH - 2, 4, 4)
end
function love.update(dt)
	if love.keyboard.isDown("w") then
		player1.dy = -PADDLE_SPEED
	elseif love.keyboard.isDown("s") then
		player1.dy = PADDLE_SPEED
	else
		player1.dy = 0
	end
	if love.keyboard.isDown("up") then
		player2.dy = -PADDLE_SPEED
	elseif love.keyboard.isDown("down") then
		player2.dy = PADDLE_SPEED
	else
		player2.dy = 0
	end
	if gameState == State.PLAY then
		ball:update(dt)
	end
	player1:update(dt)
	player2:update(dt)
end
function love.keypressed(key)
	if key == "escape" then
		love.event.quit()
	elseif key == "enter" or key == "return" then
		if gameState == State.PAUSE then
			gameState = State.PLAY
		else
			gameState = State.PAUSE
			ball:reset()
		end
	end
end

function love.draw()
	push:start()
	love.graphics.clear(0.1569, 0.176, 0.204, 1)
	love.graphics.setFont(largeFont)
	player1:render()
	player2:render()
	ball:render()
	love.graphics.print(tostring(player1.score), HVW - 50, HVH - 80)
	love.graphics.print(tostring(player2.score), HVW + 30, HVH - 80)

	push:finish()
end


