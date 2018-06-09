Object = require "classic"

local Dot = Object:extend()

function Dot:new(x, y, r, mass)
  local x = x or 0
  local y = y or 0
  local r = r or 10
  local mass = mass or 1
  self.body = love.physics.newBody(world, x, y, "dynamic")
  self.shape = love.physics.newCircleShape(r) --the ball's shape has a radius of 10
  self.fixture = love.physics.newFixture(self.body, self.shape, mass) -- Attach fixture
  self.fixture:setUserData({typeF = "dot"})
end

function Dot:draw(color)
  if not self.fixture:isDestroyed() then
    color = self.color or color
    self.color = color or {0, 0, 0}
    love.graphics.setColor(self.color)
    local x,y = self.fixture:getBody():getX(),self.fixture:getBody():getY()
    love.graphics.circle("fill", x, y, self.fixture:getShape():getRadius())
    if self.image then
      local scale = self.scale or 0.1
      local secColor = self.secColor or {1,1,1}
      love.graphics.setColor(secColor) 
      -- love.graphics.circle(self.picture, self.fixture:getBody():getX(), y, self.fixture:getShape():getRadius())
      -- love.graphics.draw(self.image, self.fixture:getBody():getX(), y, self.fixture:getBody():getAngle(),  1, 1, self.image:getWidth()/2, self.image:getHeight()/2)
      love.graphics.draw(self.image, x, y, nil,  scale, scale, self.image:getWidth()/2, self.image:getHeight()/2)
      
    end
      
  end
end



function Dot:isOut()
  width, height = love.graphics.getDimensions()
  if self.fixture:getBody():getY() > height then
    return true
  end
  if self.fixture:getBody():getY() < 0 then
    return true
  end
  if self.fixture:getBody():getX() > width then
    return true
  end
  if self.fixture:getBody():getX() < 0 then
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
