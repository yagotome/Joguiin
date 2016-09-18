constantes = require('constantes')
fisica = require('fisica')
Player = require('player')
-- Mira = require('mira')
Bomba = require('bomba')
Arvore = require('arvore')
g_ingame = true
Player1Wins = love.audio.newSource("Player1WINS.mp3")
Player2Wins = love.audio.newSource("Player2WINS.mp3")
Musica_Fundo = love.audio.newSource('game.mp3')
barra = love.graphics.newImage("BARRA.png") 
forca = love.graphics.newImage("FORCA.png")
escala_forca = 0
    

function love.load()

   love.window.setMode(constantes.largura, constantes.altura)
  background = love.graphics.newImage('mapa.png')
  background_setado = false
  arvore = Arvore.newArvore()
  player1 = Player.newPlayer(1*love.graphics.getWidth()/12, constantes.ground.y, 'player_esquerda.png')
  player2 = Player.newPlayer(10*love.graphics.getWidth()/12, constantes.ground.y, 'player_direita.png')

  player = player1
  player.travado = false

  bomba = Bomba.newBomba(player)
  vencedor = nil
  -- arvore = {
  --   x = 5*love.graphics.getWidth()/12 + love.graphics.getWidth()/24,
  --   y = 3*love.graphics.getHeight()/5,
  --   w = love.graphics.getWidth()/12,
  --   h = 2*love.graphics.getHeight()/5
  -- }
  
 
 --  Musica_Fundo:setLooping(false)
   -- love.audio.play(Musica_Fundo)
    love.audio.play(Musica_Fundo)
    
    --love.audio.play(Player1Wins)

end

function love.keypressed(key)
  if key == 'space' and bomba.carregando ~= true and bomba.em_movimento ~= true then
    player.travado = true
    bomba.carregando = true
    --escala_forca = 0
  end
end

function lancar()
   bomba.carregando = false
   bomba.em_movimento = true
   muv_s = fisica.muv_s(bomba.y, bomba.velocidade_inicial, constantes.fisica.gravidade)

   
end

function love.keyreleased(key)
  if key == 'space' and bomba.carregando then
    lancar()
  end
end

function respawn()
    bomba.carregando = false
    bomba.em_movimento = false
    if player == player1 then
      player = player2
    else
      player = player1
    end
    player.travado = false
    bomba.atualizaPosicao(player)
    bomba.resetaVelocidadeInicial()
end

function love.update(dt)  
  if vencedor == nil then
    if player.travado == false then
      if love.keyboard.isDown('d') or love.keyboard.isDown('right') then
        local x_old = player.x
        if player.x < (love.graphics.getWidth() - player.w) and fisica.colide(player1, player2) == false and fisica.colide(player, arvore) == false then
          player.x = player.x + (player.speed * dt)
          bomba.atualizaPosicao(player)
        end
        if fisica.colide(player1, player2) or fisica.colide(bomba, arvore) then
          player.x = x_old  
        end
      elseif love.keyboard.isDown('a') or love.keyboard.isDown('left') then    
        local x_old = player.x
        if player.x > 0 and fisica.colide(player1, player2) == false and fisica.colide(player, arvore) == false then 
          player.x = player.x - (player.speed * dt)
          bomba.atualizaPosicao(player)
        end
        if fisica.colide(player1, player2) == true or fisica.colide(bomba, arvore) == true then
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

    if bomba.carregando and love.keyboard.isDown('space') then
      bomba.velocidade_inicial = bomba.velocidade_inicial - 10
    end

    if player == player1 and fisica.colide(bomba, player2) == false and (fisica.colide(bomba, arvore) or bomba.y > player.y + player.h) then
      respawn()
    elseif player == player2 and fisica.colide(bomba, player1) == false and (fisica.colide(bomba, arvore) or bomba.y > player.y + player.h) then
      respawn()
    end
    -- love.timer.sleep(0.5)
    if bomba.em_movimento == true then
      if player == player1 and fisica.colide(bomba, player2) or player == player2 and fisica.colide(bomba, player1) then
            vencedor = player
      end
      if (player == player1) then
        bomba.x = fisica.mu_s(bomba.x, 400, dt)
      else
        bomba.x = fisica.mu_s(bomba.x, -400, dt)
      end    
      bomba.y = muv_s(dt)
    end
  else
  if g_ingame ~= false then
    love.audio.stop(Musica_Fundo)
     if vencedor == player1 then 
       love.audio.play(Player1Wins)
     else 
       love.audio.play(Player2Wins)
      end
     g_ingame = false 
     end 

  end

end
  

function love.draw()
  if vencedor ~= nil then
    if vencedor == player1 then
      love.graphics.print('Fim de jogo, jogador 1 venceu!', love.graphics.getWidth()/2 - 40, love.graphics.getHeight()/2 - 5)
      
    else
      love.graphics.print('Fim de jogo, jogador 2 venceu!', love.graphics.getWidth()/2 - 40, love.graphics.getHeight()/2 - 5)
    end
  else
    love.graphics.setColor(255, 255, 255)
    love.graphics.draw(background)
    love.graphics.draw(player1.img, player1.x, player1.y, 0, 0.34, 0.34)
    love.graphics.draw(player2.img, player2.x, player2.y, 0, 0.34, 0.34)
    -- love.graphics.draw(player1.mira.img, player1.mira.x, player1.mira.y, player1.mira.angulo, 0.34, 0.34)
    -- love.graphics.draw(player2.mira.img, player2.mira.x, player2.mira.y, player2.mira.angulo, 0.34, 0.34)
    love.graphics.draw(bomba.img, bomba.x, bomba.y, bomba.angulo, 0.12, 0.12)
   --love.graphics.draw()
   love.graphics.print('Velocidade inicial: ' .. ((bomba.velocidade_inicial)/15), 240, 1)
   love.graphics.draw(barra, 170,1)
   --love.timer.sleep(0.03)
   love.graphics.draw(arvore.img,arvore.x , arvore.y)
   if escala_forca < 117 then
    escala_forca = (((-bomba.velocidade_inicial)/15))
  elseif bomba.carregando then
    lancar()
    end
    love.graphics.draw(forca,187,15,0,escala_forca,1)
   
    
  -- love.graphics.line(0,0,400,400)
  end  
end