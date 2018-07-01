Dot = require "dot"

local Bonus = Dot:extend()

types = {"tripple shot", "infinity ammo", "red shot", "reversed grav", "less enemys"}
times = {10, 8, 4, 12, 8}
images = {
    love.graphics.newImage("bonus-images/tripple.png"),
    love.graphics.newImage("bonus-images/infini.png"),
    love.graphics.newImage("bonus-images/red.png"),
    love.graphics.newImage("bonus-images/upside.png"),
    love.graphics.newImage("bonus-images/less.png")
}
function Bonus:new(show)
    width, height = love.graphics.getDimensions()
    local startX = math.random(10, width - 10)
    Bonus.super.new(self, startX, 10)
    typeNo = math.random(1, #types)
    self.typeNo = typeNo
    self.fixture:setUserData({typeF = "bonus", bonusType = types[typeNo]})
    self.bonusType = types[typeNo]
    self.image = images[typeNo]
    self.scale = 0.30
    self.onScreen = true
    self.size = 40
    self.timeLeft = 1
    if not show then
        self:destroy()
    end
end
function Bonus:destroy()
    self.onScreen = false
    if not self.fixture:isDestroyed() then
        self.fixture:destroy()
    end
end

function Bonus:draw()
    if self.onScreen then
        Bonus.super.draw(self)
        startTime = love.timer.getTime()
    end
    if not self.onScreen and activeBonus then
        if self.timeLeft > 0 then
            love.graphics.setColor({0, 0, 0})

            bonusText = love.graphics.newText(font20, types[self.typeNo])
            love.graphics.rectangle("fill", width - bonusText:getWidth() / 2, 45, self.size * self.timeLeft, 2)

            bonusText:setf(types[self.typeNo], width, "right")
            love.graphics.draw(bonusText, 0, 50)
        else
            activeBonus = nil
        end
    end
end
function Bonus:update(dt)
    if not self.onScreen and activeBonus then
        self.timeLeft =
            (self.timeLeft - 0.0165 / times[self.typeNo] > 0 and self.timeLeft - 0.0165 / times[self.typeNo]) or 0
        endTime = love.timer.getTime()
    end
end

return Bonus
