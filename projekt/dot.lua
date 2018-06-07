Object = require "classic"


local Dot = Object:extend()


function Dot:new(x,y,r, mass)
  local x = x or 0
  local y = y or 0
  local r =r or 10
  local mass = mass or 1
  self.body = love.physics.newBody(world, x, y, "dynamic")
  self.shape = love.physics.newCircleShape( r) --the ball's shape has a radius of 10
  self.fixture = love.physics.newFixture(self.body, self.shape, mass) -- Attach fixture 
  self.fixture:setUserData({typeF="dot"})

end

function Dot:draw(color)
  if not self.fixture:isDestroyed( ) then
    color = self.color or color
    self.color = color or {0,0,0}
    love.graphics.setColor(self.color)
    love.graphics.circle("fill", self.body:getX(), self.body:getY(), self.fixture:getShape():getRadius())
  end
end

function Dot:isOut()
 
  width, height = love.graphics.getDimensions( )
  if self.body:getY() > height then
    return true
  end
  if self.body:getY() < 0 then
    return true
  end
  if self.body:getX() > width then
    return true
  end
  if self.body:getX() < 0 then
    return true
  end
  
  return false
end

--function Dot:isTouched(anotherDot)
--  local distance = (self.body:getX() -anotherDot.x)^2 + (self.body:getY() +anotherDot.y)^2
--  if distance <= (self.r+anotherDot.r)^2 then
--    return true
--  end
  
--  return false
--end


return Dot