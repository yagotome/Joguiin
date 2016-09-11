constantes = require('constantes')
fisica = require('fisica')
Player = require('player')

function love.load()
  love.window.setMode(constantes.largura, constantes.altura)
  
  background = love.graphics.newImage('mapa.png')
  background_setado = false
  
  player1 = Player.newPlayer(1*love.graphics.getWidth()/12, constantes.ground.y, 'player_esquerda.png')
  player2 = Player.newPlayer(10*love.graphics.getWidth()/12, constantes.ground.y, 'player_direita.png')
  
  player = player1
  player.travado = false
end

function love.update(dt)
  if love.keyboard.isDown('1') then
    player = player1
    player.travado = false
  end
  if love.keyboard.isDown('2') then
    player = player2
    player.travado = false
  end
  
  if player.travado == false then
    if love.keyboard.isDown('d') then
      local x_old = player.x
      if player.x < (love.graphics.getWidth() - player.w) and fisica.colide(player1, player2) == false then
        player.x = player.x + (player.speed * dt)
      end
      if fisica.colide(player1, player2) == true then
        player.x = x_old  
      end
    elseif love.keyboard.isDown('a') and fisica.colide(player1, player2) == false  then    
      local x_old = player.x
      if player.x > 0 then 
        player.x = player.x - (player.speed * dt)
      end
      if fisica.colide(player1, player2) == true then
        player.x = x_old  
      end
    end

    -- if love.keyboard.isDown('space') then
    --   if player.y_velocity == 0 then
    --     player.y_velocity = player.jump_height
    --   end
    -- end
  
    -- if player.y_velocity ~= 0 then
    --   player.y = player.y + player.y_velocity * dt
    --   player.y_velocity = player.y_velocity - player.gravity * dt
    -- end
  
    -- if player.y > player.ground then
    --   player.y_velocity = 0
    --     player.y = player.ground
    -- end
  end
end

function love.draw()
  love.graphics.draw(background)
  love.graphics.draw(player1.img, player1.x, player1.y, 0, 0.34, 0.34)
  love.graphics.draw(player2.img, player2.x, player2.y, 0, 0.34, 0.34)
end