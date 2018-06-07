Dot  = require "dot"


local Shot = Dot:extend()

function Shot:new(x,y, c, colorTab)
  self.color = colorTab[c] or {0,0,0} 
  Shot.super.new(self,x,y,2)
  
  self.fixture:setUserData({typeF= "shot", color = self.color})

end

function Shot:update(dt)
  self.body:setY(self.body:getY() - 240*dt)
  if self.body:getY()<-5 then
    self.body:setY(-5)
  end
  
end

--function Shot:draw()
--  love.graphics.setColor(self.color)
--  love.graphics.circle("fill", self.body:getX(), self.body:getY(), self.shape:getRadius())
--end

return Shot