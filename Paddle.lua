Paddle = Class({})
function Paddle:init(x, y, width, height)
	self.x = x
	self.y = y
	self.width = width
	self.height = height
	self.dy = 0
	self.score = 0
	self.ai = false
end

function Paddle:update(dt)
	self.y = math.min(math.max(self.y + self.dy * dt, 0), VIRTUAL_HEIGHT - self.height)
end
function Paddle:addScore()
	self.score = self.score + 1
end
function Paddle:render()
	if self.ai then
		love.graphics.setColor(0, 1, 0, 1)
		love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
		love.graphics.setColor(1, 1, 1, 1)
	else
		love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
	end
end
