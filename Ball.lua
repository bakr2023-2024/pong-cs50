Ball = Class({})

function Ball:init(x, y, width, height)
	self.x = x
	self.y = y
	self.width = width
	self.height = height
	self.dx = math.random(2) and 100 or -100
	self.dy = math.random(-50, 50)
end

function Ball:update(dt)
	self.x = self.x + self.dx * dt
	self.y = self.y + self.dy * dt
	if self.y >= VIRTUAL_HEIGHT - self.height or self.y <= 0 then
		self.dy = -self.dy
	end
end
function Ball:collides(paddle)
	return not (
		ball.x >= paddle.x + paddle.width
		or paddle.x >= ball.x + ball.width
		or ball.y >= paddle.y + paddle.height
		or paddle.y >= ball.y + ball.height
	)
end
function Ball:render()
	love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end

function Ball:reset()
	self.x = HVW - self.width / 2
	self.y = HVH - self.height / 2
	self.dx = math.random(2) == 1 and 100 or -100
	self.dy = math.random(-50, 50)
end
