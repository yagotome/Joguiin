constantes = require('constantes')
fisica = require('fisica')
Player = require('player')
-- Mira = require('mira')
Bomba = require('bomba')

function love.load()
  love.window.setMode(constantes.largura, constantes.altura)
  
  background = love.graphics.newImage('mapa.png')
  background_setado = false
  
  player1 = Player.newPlayer(1*love.graphics.getWidth()/12, constantes.ground.y, 'player_esquerda.png')
  player2 = Player.newPlayer(10*love.graphics.getWidth()/12, constantes.ground.y, 'player_direita.png')

  player = player1
  player.travado = false

  bomba = Bomba.newBomba(player)
  t = 0
  acabou = false
end

function love.keypressed(key)
  if key == 'space' then
    player.travado = true
    bomba.em_movimento = true
  end
end

function love.update(dt)
  if love.keyboard.isDown('1') then
    player = player1
    bomba.atualizaPosicao(player)
    player.travado = false
  end
  if love.keyboard.isDown('2') then
    player = player2
    bomba.atualizaPosicao(player)
    player.travado = false
  end
  
  if player.travado == false then
    if love.keyboard.isDown('d') then
      local x_old = player.x
      if player.x < (love.graphics.getWidth() - player.w) and fisica.colide(player1, player2) == false then
        player.x = player.x + (player.speed * dt)
        bomba.atualizaPosicao(player)
      end
      if fisica.colide(player1, player2) == true then
        player.x = x_old  
      end
    elseif love.keyboard.isDown('a') and fisica.colide(player1, player2) == false  then    
      local x_old = player.x
      if player.x > 0 then 
        player.x = player.x - (player.speed * dt)
        bomba.atualizaPosicao(player)
      end
      if fisica.colide(player1, player2) == true then
        player.x = x_old  
      end
    -- elseif love.keyboard.isDown('w') then
    --   mira.angulo = mira.angulo - 0.05
    -- elseif love.keyboard.isDown('s') then
    --   mira.angulo = mira.angulo + 0.05
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

  -- if fisica.colide(bomba, player) == false and bomba.y > player.y + player.h then
  --   bomba.em_movimento = false
  --   t = 0
  --   if player == player1 then
  --     player = player2
  --   else
  --     player = player1
  --   end 
  --   player.travado = false    
  --   bomba.atualizaPosicao(player)
  -- end

  if player == player1 and fisica.colide(bomba, player2) == false and bomba.y > player.y + player.h then
    bomba.em_movimento = false
    t = 0
    player = player2
    player.travado = false
    bomba.atualizaPosicao(player)
  elseif player == player2 and fisica.colide(bomba, player1) == false and bomba.y > player.y + player.h then
    bomba.em_movimento = false
    t = 0
    player = player1
    player.travado = false
    bomba.atualizaPosicao(player)
  end  

  if bomba.em_movimento == true then
    if player == player1 and fisica.colide(bomba, player2) or player == player2 and fisica.colide(bomba, player1) then
      acabou = true
    end
    if (player == player1) then
      bomba.x = fisica.mu_s(bomba.x, 100, dt)
    else
      bomba.x = fisica.mu_s(bomba.x, -100, dt)
    end
    bomba.y = fisica.muv_s(bomba.y, -10, t, 10)
  end
  t = t + dt
end

function love.draw()
  if acabou then
    love.graphics.print('Game over', love.graphics.getWidth()/2, love.graphics.getHeight()/2)
  else
    love.graphics.draw(background)
    love.graphics.draw(player1.img, player1.x, player1.y, 0, 0.34, 0.34)
    love.graphics.draw(player2.img, player2.x, player2.y, 0, 0.34, 0.34)
    -- love.graphics.draw(player1.mira.img, player1.mira.x, player1.mira.y, player1.mira.angulo, 0.34, 0.34)
    -- love.graphics.draw(player2.mira.img, player2.mira.x, player2.mira.y, player2.mira.angulo, 0.34, 0.34)
    love.graphics.draw(bomba.img, bomba.x, bomba.y, bomba.angulo, 0.12, 0.12)
  end
end