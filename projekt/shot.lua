Dot = require "dot"

local Shot = Dot:extend()

function Shot:new(x, y, c, colorTab, dir)
  self.dir = dir or "up"
  self.color = colorTab[c] or {0, 0, 0}
  Shot.super.new(self, x, y, 2)

  self.fixture:setUserData({typeF = "shot", color = self.color})
end

function Shot:update(dt)
  self.body:setY(self.body:getY() - 240 * dt)
  local newX = self.body:getX()
  if self.dir == "left" then
    newX = newX - 240 * dt
  elseif self.dir == "right" then
    newX = newX + 240 * dt
  end
  if self.body:getY() < -5 then
    self.body:setY(-5)
  end
  if newX < 2 then
    newX = 2
    if self.dir == "left" then
      self.dir = "right"
    end
  elseif newX + 2 > width then
    newX = width - 2
    if self.dir == "right" then
      self.dir = "left"
    end
  end
  self.body:setX(newX)
end

return Shot
