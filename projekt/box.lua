Object = require "classic"


local Box = Object:extend()


function Box:new()
    --let's create the ground
  dens =0
  width, height = love.graphics.getDimensions()
  self.ground = {}
  self.ground.body = love.physics.newBody(world, width/2, height, "kinematic")
  self.ground.shape = love.physics.newRectangleShape(width, dens)
  self.ground.fixture = love.physics.newFixture(self.ground.body, self.ground.shape)
  self.ground.fixture:setUserData({typeF="ground"})

  self.ceiling = {}
  self.ceiling.body = love.physics.newBody(world, width/2, 0, "kinematic")
  self.ceiling.shape = love.physics.newRectangleShape(width, dens)
  self.ceiling.fixture = love.physics.newFixture(self.ceiling.body, self.ceiling.shape)
  self.ceiling.fixture:setUserData({typeF="ceiling"})
  self.wall1 = {}
  self.wall1.body = love.physics.newBody(world, 0, height/2, "kinematic")
  self.wall1.shape = love.physics.newRectangleShape(dens, height)
  self.wall1.fixture = love.physics.newFixture(self.wall1.body, self.wall1.shape)
  self.wall1.fixture:setUserData({typeF="wall1"})

  self.wall2 = {}
  self.wall2.body = love.physics.newBody(world, width, height/2, "kinematic")
  self.wall2.shape = love.physics.newRectangleShape(dens, height)
  self.wall2.fixture = love.physics.newFixture(self.wall2.body, self.wall2.shape)
  self.wall2.fixture:setUserData({typeF="wall2"})

end

function Box:resize(width, height)
  
  ---[[
  self.ground.fixture:destroy()
  self.wall1.fixture:destroy()
  self.wall2.fixture:destroy()
  self.ceiling.fixture:destroy()
  --]]
  ---[[
  self.ground.body = love.physics.newBody(world, width/2, height, "kinematic")
  self.ground.shape = love.physics.newRectangleShape(width, dens)
  self.ground.fixture:release()
  self.ground.fixture = love.physics.newFixture(self.ground.body, self.ground.shape)
  self.ground.fixture:setUserData({typeF="ground"})

  self.ceiling.body = love.physics.newBody(world, width/2, 0, "kinematic")
  self.ceiling.shape = love.physics.newRectangleShape(width, dens)
  self.ceiling.fixture:release()
  self.ceiling.fixture = love.physics.newFixture(self.ceiling.body, self.ceiling.shape)
  self.ceiling.fixture:setUserData({typeF="ceiling"})
  
  self.wall1.body = love.physics.newBody(world, 0, height/2, "kinematic")
  self.wall1.shape = love.physics.newRectangleShape(dens, height)
  self.wall1.fixture:release()
  self.wall1.fixture = love.physics.newFixture(self.wall1.body, self.wall1.shape)
  self.wall1.fixture:setUserData({typeF="wall1"})

  self.wall2.body = love.physics.newBody(world, width, height/2, "kinematic")
  self.wall2.shape = love.physics.newRectangleShape(dens, height)
  self.wall2.fixture:release()
  self.wall2.fixture = love.physics.newFixture(self.wall2.body, self.wall2.shape)
  self.wall2.fixture:setUserData({typeF="wall2"})
  --]]
end


function Box:draw()
  love.graphics.setColor(0, 255, 0)
  if not self.ground.fixture:isDestroyed( ) then
    love.graphics.polygon("fill", 
                          self.ground.fixture
                            :getBody()
                            :getWorldPoints(self.ground.fixture:getShape():getPoints()))
    love.graphics.polygon("fill", 
                          self.wall2.fixture
                            :getBody()
                            :getWorldPoints(self.wall2.fixture:getShape():getPoints()))
    love.graphics.polygon("fill", 
                          self.wall1.fixture
                            :getBody()
                            :getWorldPoints(self.wall1.fixture:getShape():getPoints()))
    love.graphics.polygon("fill", 
                          self.ceiling.fixture
                            :getBody()
                            :getWorldPoints(self.ceiling.fixture:getShape():getPoints()))
  end
end


return Box