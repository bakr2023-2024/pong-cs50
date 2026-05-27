WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243
HVW = VIRTUAL_WIDTH / 2
HVH = VIRTUAL_HEIGHT / 2

MAX_SCORE = 10

Class = require("class")
require("Paddle")
require("Ball")
PADDLE_SPEED = 200
State = {
	START = 1,
	SERVE = 2,
	PLAY = 3,
	DONE = 4,
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

	sounds = {
		["paddle"] = love.audio.newSource("sounds/paddle.wav", "static"),
		["edge"] = love.audio.newSource("sounds/edge.wav", "static"),
		["score"] = love.audio.newSource("sounds/score.wav", "static"),
	}

	math.randomseed(os.time())
	gameState = State.START

	player1 = Paddle(10, 10, 5, 20)
	player2 = Paddle(VIRTUAL_WIDTH - 15, VIRTUAL_HEIGHT - 30, 5, 20)
	ball = Ball(HVW - 2, HVH - 2, 4, 4)
	serving = ball.dx < 0 and 2 or 1
	winner = -1
end
function love.update(dt)
	if gameState == State.SERVE then
		ball.dy = (ball.dy < 0 and -1 or 1) * math.random(10, 150)
		ball.dx = (serving == 1 and 1 or -1) * math.random(140, 200)
	elseif gameState == State.PLAY then
		if ball:collides(player1) then
			ball.dx = -ball.dx * 1.03
			ball.x = player1.x + 5
			love.audio.play(sounds["paddle"])
		elseif ball:collides(player2) then
			ball.dx = -ball.dx * 1.03
			ball.x = player2.x - 5
			love.audio.play(sounds["paddle"])
		end
		if ball.y >= VIRTUAL_HEIGHT - ball.height then
			ball.y = VIRTUAL_HEIGHT - ball.height
			ball.dy = -ball.dy
			love.audio.play(sounds["edge"])
		elseif ball.y <= 0 then
			ball.y = 0
			ball.dy = -ball.dy
			love.audio.play(sounds["edge"])
		end
		if ball.x <= 0 then
			player2:addScore()
			love.audio.play(sounds["score"])
			if player2.score == MAX_SCORE then
				gameState = State.DONE
				winner = 2
			else
				gameState = State.SERVE
			end
			ball:reset()
			serving = 1
		elseif ball.x >= VIRTUAL_WIDTH - ball.width then
			player1:addScore()
			love.audio.play(sounds["score"])
			if player1.score == MAX_SCORE then
				gameState = State.DONE
				winner = 1
			else
				gameState = State.SERVE
			end
			ball:reset()
			serving = 2
		end
	end

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
		if gameState == State.START then
			gameState = State.SERVE
		elseif gameState == State.SERVE then
			gameState = State.PLAY
		elseif gameState == State.DONE then
			gameState = State.SERVE
			player1.score = 0
			player2.score = 0
		end
	end
end

function love.draw()
	push:start()
	love.graphics.clear(0.1569, 0.176, 0.204, 1)
	love.graphics.setFont(smallFont)
    if gameState == State.START then
		love.graphics.printf(
			"Welcome to Pong!\nFirst player to get " .. tostring(MAX_SCORE) .. " points wins\nPress Enter to start",
			0,
			10,
			VIRTUAL_WIDTH,
			"center"
		)
    elseif gameState == State.SERVE then
		love.graphics.printf("Player " .. tostring(serving) .. "'s turn", 0, 10, VIRTUAL_WIDTH, "center")
    elseif gameState == State.DONE then
		love.graphics.printf(
			"Player " .. tostring(winner) .. " wins!\nPress Enter to restart",
			0,
			10,
			VIRTUAL_WIDTH,
			"center"
		)

    end
	love.graphics.setFont(largeFont)
	player1:render()
	player2:render()
	ball:render()
	love.graphics.print(tostring(player1.score), HVW - 50, HVH - 80)
	love.graphics.print(tostring(player2.score), HVW + 30, HVH - 80)
	showFPS()
	push:finish()
end

function showFPS()
	love.graphics.setFont(smallFont)
	love.graphics.setColor(0, 1, 0, 1)
	love.graphics.print(tostring(love.timer.getFPS()), 1, 1)
	love.graphics.setColor(1, 1, 1, 1)
end
