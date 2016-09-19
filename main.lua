constantes = require('constantes')
fisica = require('fisica')
Player = require('player')
Bomba = require('bomba')
Arvore = require('arvore')
g_ingame = true
Player1Wins = love.audio.newSource("Player1WINS.mp3")
Player2Wins = love.audio.newSource("Player2WINS.mp3")
Musica_Fundo = love.audio.newSource('game.mp3')
barra = love.graphics.newImage("BARRA.png") 
forca = love.graphics.newImage("FORCA.png")
escala_forca = 0
-- Nome: variável "escala_forca"
-- Propriedade: endereço
-- Binding time: compilação
-- Explicação: dado que "escala_forca" é uma variável global, seu endereço já é determinado em tempo de compilação    

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
    love.audio.play(Musica_Fundo)

end

function love.keypressed(key)
  if key == 'space' and bomba.carregando ~= true and bomba.em_movimento ~= true then
    player.travado = true
    bomba.carregando = true
  end
end
-- Nome: constante 'space'
-- Propriedade: endereço
-- Binding time: compilação
-- Explicação: dado que 'space' é uma constante, seu endereço é determinado em tempo de compilação
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
-- Nome: variável "bomba.carregando"
-- Propriedade: valor (conteúdo)
-- Binding time: execução
-- Explicação: dado que "bomba.carregando" é uma variável, seu valor só pode ser determinado em tempo de execução    

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
      end
    end
    if bomba.carregando and love.keyboard.isDown('space') then
      bomba.velocidade_inicial = bomba.velocidade_inicial - 10
    end

    if player == player1 and fisica.colide(bomba, player2) == false and (fisica.colide(bomba, arvore) or bomba.y > player.y + player.h) then
      respawn()
    elseif player == player2 and fisica.colide(bomba, player1) == false and (fisica.colide(bomba, arvore) or bomba.y > player.y + player.h) then
      respawn()
    end
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
-- Nome: Palavra reservada "nil"
-- Propriedade: Valor
-- Binding time: desenho
-- Explicação: A palavra 'nil' é utilizada representação do valor nulo
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
    love.graphics.draw(bomba.img, bomba.x, bomba.y, bomba.angulo, 0.12, 0.12)
   love.graphics.print('Força: ' .. (-(bomba.velocidade_inicial)/15)+1, 240, 1)
   love.graphics.draw(barra, 170,1)
   love.graphics.draw(arvore.img,arvore.x , arvore.y)
   if escala_forca < 117 then
    escala_forca = (((-bomba.velocidade_inicial)/15))
  elseif bomba.carregando then
    lancar()
    end
    love.graphics.draw(forca,187,15,0,escala_forca,1)
  end  
end