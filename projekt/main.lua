kolorki = {
  nr = 4,
  {241 / 255, 114 / 255, 23 / 255},
  {128 / 255, 218 / 255, 54 / 255},
  {35 / 255, 116 / 255, 254 / 255},
  {217 / 255, 43 / 255, 187 / 255}
}
kolorki.red = {221 / 255, 0 / 255, 17 / 255}
kolorki.orange = {241 / 255, 114 / 255, 23 / 255}
kolorki.yellow = {240 / 255, 210 / 255, 20 / 255}
kolorki.green = {128 / 255, 218 / 255, 54 / 255}
kolorki.blue = {35 / 255, 116 / 255, 254 / 255}
kolorki.purple = {217 / 255, 43 / 255, 187 / 255}

Shot = require "shot"
Player = require "player"
Enemy = require "enemy"
--Dot = require "dot"
Box = require 'box'

function love.load()
  newGame(false)



end

function love.draw()
  if gameStarted then
    love.graphics.setBackgroundColor(1, 1, 1)
  --  love.graphics.polygon("fill", objects.block2.body:getWorldPoints(objects.block2.shape:getPoints()))
    box:draw()
    objects.player:draw(kolorki.red)

    for i = 1, #enemys do
      enemys[i]:draw()
    end

    for i = 1, #shots do
      shots[i]:draw()
    end
    love.graphics.setColor(kolorki[shotColor])
    
    shotsString = ""..(shotNo - #shots)
    shotsText = love.graphics.newText( font40, shotsString )
    shotsText:setf( shotsString, width, "right" )
    love.graphics.draw(shotsText)
    
    love.graphics.draw(love.graphics.newText( font40, ""..score ), 0)

    --love.graphics.draw(text)

  elseif startTextDeley > 0.5 then
    love.graphics.setColor(255, 255, 255)
    startGameText1 = love.graphics.newText( font40, "Welcome to \"Lata i strzela\"!" )
    love.graphics.draw(startGameText1, 
                       math.floor(width / 2 -startGameText1:getWidth()/2), 
                       math.floor(height / 2 - startGameText1:getHeight()/2))
    startGameText2 = love.graphics.newText( font20, "Press anykey to start" )
    love.graphics.draw(startGameText2, 
                       math.floor(width / 2 -startGameText2:getWidth()/2), 
                       math.floor(height / 2 - startGameText2:getHeight()/2 + startGameText1:getHeight()))
                     
                     
    legendDraw()

  else
    love.graphics.setColor(255, 255, 255)
    startGameText1 = love.graphics.newText( font40, "Welcome to \"Lata i strzela\"!" )
    love.graphics.draw(startGameText1, 
                       math.floor(width / 2 -startGameText1:getWidth()/2), 
                       math.floor(height / 2 - startGameText1:getHeight()/2))
    startGameText2 = love.graphics.newText( font20, "Press anykey to start" )
    legendDraw()
    
  end
                     
  if gameOver then
    love.graphics.setColor(255, 0, 0)
    scoreText = love.graphics.newText( font60, ""..score )
    love.graphics.draw(scoreText, 
                       math.floor(width / 2 -scoreText:getWidth()/2), 
                       math.floor(height / 2 - scoreText:getHeight()/2))

    gameOverText = love.graphics.newText( font60, "GAME OVER!" )
    love.graphics.draw(gameOverText, 
                       math.floor(width / 2 -gameOverText:getWidth()/2), 
                       math.floor(height / 2 - gameOverText:getHeight()/2 - scoreText:getHeight()))

  end
  if gameOver and startTextDeley > 0.5 then


    gameOverText2 = love.graphics.newText( font20, "Press anykey to restart" )
    love.graphics.draw(gameOverText2, 
                       math.floor(width / 2 -gameOverText2:getWidth()/2), 
                       math.floor(height / 2 - gameOverText2:getHeight()/2 + gameOverText:getHeight()))
  end
  
                     
  --]]
end

function love.update(dt)
  startTextDeley = (startTextDeley + dt > 1 and 0) or startTextDeley + dt
  if not gameOver and gameStarted then
    world:update(dt) --this puts the world into motion

    shotDelay = shotDelay+ dt/10
    if love.keyboard.isDown("space") and #shots < shotNo and shotDelay> maxShotDeley  then
      shots[#shots + 1] = Shot(objects.player.body:getX(), objects.player.body:getY()-5, shotColor,kolorki)
      shotDelay=0
    end
    
    objects.player:update()

    enemyCounter = enemyCounter + dt
    if enemyCounter >= 1 then
      enemys[#enemys + 1] = Enemy(kolorki)
      enemys[#enemys + 1] = Enemy(kolorki)
      enemyCounter = 0
    end

    local temp2 = {}
    for i = 1, #enemys do
      enemys[i]:update(dt, level)

      --      if not enemys[i]:isOut() then
      --        temp2[#temp2+1]=enemys[i]
      --      end
    end
    --    enemys = temp2

    local temp = {}
    for i = 1, #shots do
      print(#shots)
      shots[i]:update(dt)
        if not shots[i]:isOut() or not shots[i].fixture:isDestroyed() then
          temp[#temp+1]=shots[i]
        elseif not shots[i].fixture:isDestroyed() then
          shots[i].fixture:destroy()
        end
    end
    shots = temp

  else
    --love.graphics.clear()
    love.graphics.setColor(255, 0, 0)
    love.graphics.print("GAME OVER!", width / 2 - 50, height / 2 - 50, 0, 5, 5)
  end
end

function love.keypressed(key)
  if key == "escape" then
    love.event.quit()
--  elseif key == "space" then
--    shots[#shots + 1] = Shot(objects.player.body:getX(), objects.player.body:getY()-5, shotColor,kolorki)
--    rSize = shots[#shots].shape:getRadius()
--    shots[#shots + 1] = Shot(objects.player.body:getX(), objects.player.body:getY() -5- 2 * rSize, shotColor,kolorki)
--    shots[#shots + 1] = Shot(objects.player.body:getX(), objects.player.body:getY() - 5-4 * rSize, shotColor,kolorki)
  elseif key == "z" then
    shotColor =1
  elseif key == "x" then
    shotColor =2
  elseif key == "c" then
    shotColor =3
  elseif key == "v" then
    shotColor =4
  elseif key and not gameStarted then
    gameStarted = true
  elseif key and gameOver then
      newGame(true)
    
  
  end
  
end




function beginContact(f1, f2, contact)
  local shot = nil
  local enemy = nil
  local ceiling = nil
  local ground = nil
  if f1:getUserData() and f2:getUserData() then
    shot = ( f1:getUserData().typeF == "shot" and f1) or (f2:getUserData().typeF == "shot" and f2)
    enemy = ( f1:getUserData().typeF == "enemy" and f1) or (f2:getUserData().typeF == "enemy" and f2)
    ceiling = ( f1:getUserData().typeF == "ceiling" and f1) or (f2:getUserData().typeF == "ceiling" and f2)
    ground = ( f1:getUserData().typeF == "ground" and f1) or (f2:getUserData().typeF == "ground" and f2)
    
    if shot and enemy then
      
      if contact:isTouching() and shot:getUserData().color == enemy:getUserData().color  then
        
        enemy:getShape():setRadius(enemy:getShape():getRadius()-10)
        score = score + 1
        if enemy:getShape():getRadius() < 10 then
          enemy:destroy( )
          score = score + 5
        end
        shot:destroy( )
      end
    elseif shot and ceiling and contact:isTouching() then
        shot:destroy()
    elseif enemy and ground and contact:isTouching() then
        gameOver = true
      
    end
  end
  
end
function love.resize(w, h)
  box:resize(w,h)
end

function newGame(ifStarted)
  -----------------const---------
  level = 5
  shotNo = 60
  maxShotDeley = 0.003

  font60 = love.graphics.newFont( "neuropol_x_rg.ttf", 60 )
  font40 = love.graphics.newFont( "neuropol_x_rg.ttf", 40 )
  font20 = love.graphics.newFont( "neuropol_x_rg.ttf", 20 )
  math.randomseed(os.time())
  love.window.setMode(800, 600, {resizable = true, vsync = true, minwidth = 400, minheight = 300})
  love.physics.setMeter(64) --the height of a meter our worlds will be 64px
  world = love.physics.newWorld(0, 5, true) 
  world:setCallbacks( beginContact, nil,nil,nil )
  box = Box()

  ---------------counters---------
  enemyCounter = 0
  shotDelay = 0
  score = 0
  gameStarted = ifStarted
  gameOver = false
  startTextDeley = 0
  shotColor = 1


  objects = {} 
  shots = {}
  enemys = {}
  width, height = love.graphics.getDimensions()
  x, y = math.floor(width/2), height - 10
  objects.player = Player(x, y, 0.15)



end


function legendDraw()
  textHeigh = height / 2+ startGameText1:getHeight() + startGameText2:getHeight() + 100
    love.graphics.setColor(kolorki.orange)                      
    legendText1 = love.graphics.newText( font20, "z" )
    textHeigh = textHeigh - legendText1:getHeight()/2
    love.graphics.draw(legendText1, 
                       math.floor(width / 2 -legendText1:getWidth()*2.5), 
                       math.floor( textHeigh ))
    love.graphics.setColor(kolorki.green)                      
    legendText2 = love.graphics.newText( font20, "x" )
    love.graphics.draw(legendText2, 
                       math.floor(width / 2 -legendText2:getWidth()), 
                       math.floor( textHeigh ))
    love.graphics.setColor(kolorki.blue)                      
    legendText3 = love.graphics.newText( font20, "c" )
    love.graphics.draw(legendText3, 
                       math.floor(width / 2 +legendText3:getWidth()), 
                       math.floor( textHeigh ))
    love.graphics.setColor(kolorki.purple)                      
    legendText4 = love.graphics.newText( font20, "v" )
    love.graphics.draw(legendText4, 
                       math.floor(width / 2 +legendText4:getWidth()*2.5), 
                       math.floor( textHeigh ))
         
    love.graphics.setColor(255,255,255)                      
    legendText5 = love.graphics.newText( font20, "space to shot" )
    textHeigh = textHeigh + legendText1:getHeight()*1.5 - legendText5:getHeight()/2

    love.graphics.draw(legendText5, 
                       math.floor(width / 2 -legendText5:getWidth()/2), 
                       math.floor( textHeigh ))                       

end