Dot  = require "dot"


local Enemy= Dot:extend()

function Enemy:new(colorTab)

  width, height = love.graphics.getDimensions( )
  local r = math.random(10,40)
  local y = r 
  local x = math.random(0+r, width-r)
  local number = math.random(1,colorTab.nr)
  self.color = colorTab[number]
  
  self.body = love.physics.newBody(world, x, y, "dynamic")
  self.shape = love.physics.newCircleShape( r) --the ball's shape has a radius of 10
  self.fixture = love.physics.newFixture(self.body, self.shape, r/1500) 
  --print(self.color, colorTab[1], number)
  self.fixture:setUserData({typeF="enemy", color = self.color})



end

function Enemy:draw()
  if not self.fixture:isDestroyed( ) then
    love.graphics.setColor(self.color)
    love.graphics.circle("fill", self.body:getX(), self.body:getY(), self.fixture:getShape():getRadius())
  end

end

function Enemy:update(dt, level)
  width, height = love.graphics.getDimensions( )
  self.body:setY(self.body:getY() + 2*level*dt)
  if self.body:getY()>height+self.shape:getRadius() then
    self.body:setY(height+self.shape:getRadius())
  end
  
end


return Enemy