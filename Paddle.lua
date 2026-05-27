Paddle = Class({})
function Paddle:init(x, y, width, height)
	self.x = x
	self.y = y
	self.width = width
	self.height = height
	self.dy = 0
	self.score = 0
end

function Paddle:update(dt)
	self.y = math.min(math.max(self.y + self.dy * dt, 0), VIRTUAL_HEIGHT - self.height)
end
function Paddle:addScore()
	self.score = self.score + 1
end
function Paddle:render()
	love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end
