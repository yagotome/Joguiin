constantes = require('constantes')
fisica = require('fisica')
Player = require('player')
Bomba = require('bomba')
Arvore = require('arvore')
Pombo = require('pombo')
g_ingame = true
Player1Wins = love.audio.newSource("Player1WINS.mp3")
Player2Wins = love.audio.newSource("Player2WINS.mp3")
Musica_Fundo = love.audio.newSource('game.mp3')
barra = love.graphics.newImage("BARRA.png") 
forca = love.graphics.newImage("FORCA.png")
escala_forca = 0
-- trabalho-04
-- Nome: variável "escala_forca"
-- Propriedade: endereço
-- Binding time: compilação
-- Explicação: dado que "escala_forca" é uma variável global, seu endereço já é determinado em tempo de compilação    

function love.load()

   love.window.setMode(constantes.largura, constantes.altura)
  background = love.graphics.newImage('mapa.png')
  background_setado = false
  arvore = Arvore.newArvore()
  players = {
    Player.newPlayer(1*love.graphics.getWidth()/12, constantes.ground.y, 'player_esquerda.png'),
    Player.newPlayer((10/12)*love.graphics.getWidth(), constantes.ground.y, 'player_direita.png')
  }
  -- trabalho-04
  -- Nome: Constante multiplicadora '10/12'
  -- Propriedade: valor
  -- Binding time: compilação
  -- Explicação: Operações sobre constantes ocorrem em tempo de compilação.

  -- trabalho-06
  -- table 'players' é usada como tupla

  player = players[1]
  player.travado = false

  bomba = Bomba.newBomba(player)
  vencedor = nil

  pombos = { }
  -- trabalho-06
  -- table 'pombos' é usada como array
  love.audio.play(Musica_Fundo)

  t = 6
end

function onPomboColide(bomba)
  for i = #pombos, 1, -1 do
    local pombo = pombos[i]
    if fisica.colide(bomba, pombo) then
      table.remove(pombos, i)
    end
  end
end

function love.keypressed(key)
  if key == 'space' and bomba.carregando ~= true and bomba.em_movimento ~= true then
  -- trabalho-06
  -- variável 'key' é usada como enumeração
    player.travado = true
    bomba.carregando = true
  end
end
-- trabalho-04
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
-- trabalho-04
-- Nome: variável "bomba.carregando"
-- Propriedade: valor (conteúdo)
-- Binding time: execução
-- Explicação: dado que "bomba.carregando" é uma variável, seu valor só pode ser determinado em tempo de execução    

function respawn()
    bomba.carregando = false
    bomba.em_movimento = false
    if player == players[1] then
      player = players[2]
    else
      player = players[1]
    end
    player.travado = false
    bomba.atualizaPosicao(player)
    bomba.resetaVelocidadeInicial()
    escala_forca = 0
end

function love.update(dt)
  t = t + dt
  if t > 6 then
    pombos[#pombos+1] = Pombo.newPombo(constantes.largura - 100, 200)
    t = 0
  end
  for i = #pombos, 1, -1 do
    local pombo = pombos[i]
    -- trabalho-07 - inicio
    if pombo.estadoMovimento == nil then
      pombo.estadoMovimento = pombo.atualizaEstadoMovimento()          
      pombo.distanciaPercorrida = 0
    end
    if (pombo.estadoMovimento == 'left' or pombo.estadoMovimento == 'right') then
      if pombo.distanciaPercorrida >= 300 then
        pombo.estadoMovimento = pombo.atualizaEstadoMovimento()
        pombo.distanciaPercorrida = 0
      else
        local s0 = math.abs(pombo.x) 
        pombo.move(pombo.estadoMovimento, dt)
        pombo.distanciaPercorrida = pombo.distanciaPercorrida + math.abs(pombo.x - s0)
      end
    elseif (pombo.estadoMovimento == 'up' or pombo.estadoMovimento == 'down') then
      if pombo.distanciaPercorrida >= 140 then
        pombo.estadoMovimento = pombo.atualizaEstadoMovimento()
        pombo.distanciaPercorrida = 0
      else
        local s0 = math.abs(pombo.y) 
        pombo.move(pombo.estadoMovimento, dt)
        pombo.distanciaPercorrida = pombo.distanciaPercorrida + math.abs(pombo.y - s0)
      end
    end
    -- trabalho-07 - fim
    if pombo.x <= 0 then 
      table.remove(pombos, i)
    end
  end
-- trabalho-05 
-- Coleção: tabela pombos
-- Escopo: Global
-- Tempo de vida: Os elementos do array pombos passam pelo cenário do jogo sendo iterados, seu tempo de vida é variável,
-- o primeiro elemento é criado na inicialização do jogo e os de mais são criados num intervalo de tempo constante e eles são removidos 
-- da tabela quando chegam no final do cenário ou quando são acertados pela bomba.
-- Alocação: Os pombos são alocados na função update em um período de tempo de aproximadamente 4 segundos.
-- Desalocação: Os pombos são desalocados quando colidem com a bomba ou atingem o final da cenário.
  if vencedor == nil then
    if player.travado == false then
      if love.keyboard.isDown('d') or love.keyboard.isDown('right') then
        local x_old = player.x
        if player.x < (love.graphics.getWidth() - player.w) and fisica.colide(players[1], players[2]) == false and fisica.colide(player, arvore) == false then
          player.x = player.x + (player.speed * dt)
          bomba.atualizaPosicao(player)
        end
        if fisica.colide(players[1], players[2]) or fisica.colide(bomba, arvore) then
          player.x = x_old  
        end
      elseif love.keyboard.isDown('a') or love.keyboard.isDown('left') then    
        local x_old = player.x
        if player.x > 0 and fisica.colide(players[1], players[2]) == false and fisica.colide(player, arvore) == false then 
          player.x = player.x - (player.speed * dt)
  -- trabalho-04
  -- Nome: operador "*"
  -- Propriedade: semantica
  -- Binding time: compilação
  -- Explicação: O operador reage de maneiras diferentes ás operações dependendo do tipo e da arquitetura.
          bomba.atualizaPosicao(player)
        end
        if fisica.colide(players[1], players[2]) == true or fisica.colide(bomba, arvore) == true then
          player.x = x_old  
        end
      end
    end
    if bomba.carregando and love.keyboard.isDown('space') then
      bomba.velocidade_inicial = bomba.velocidade_inicial - 10
    end

    if player == players[1] and fisica.colide(bomba, players[2]) == false and (fisica.colide(bomba, arvore) or bomba.y > player.y + player.h) then
      respawn()
    elseif player == players[2] and fisica.colide(bomba, players[1]) == false and (fisica.colide(bomba, arvore) or bomba.y > player.y + player.h) then
      respawn()
    end
    if bomba.em_movimento == true then
      onPomboColide(bomba)
      if player == players[1] and fisica.colide(bomba, players[2]) or player == players[2] and fisica.colide(bomba, players[1]) then
            vencedor = player
      end
      if (player == players[1]) then
        bomba.x = fisica.mu_s(bomba.x, 400, dt)
      else
        bomba.x = fisica.mu_s(bomba.x, -400, dt)
      end    
      bomba.y = muv_s.move(dt)
    end
  else
  if g_ingame ~= false then
    love.audio.stop(Musica_Fundo)
     if vencedor == players[1] then 
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
-- trabalho-04
-- Nome: Palavra reservada "nil"
-- Propriedade: Valor
-- Binding time: desenho
-- Explicação: A palavra 'nil' é utilizada representação do valor nulo
    if vencedor == players[1] then
      love.graphics.print('Fim de jogo, jogador 1 venceu!', love.graphics.getWidth()/2 - 40, love.graphics.getHeight()/2 - 5)      
    else
      love.graphics.print('Fim de jogo, jogador 2 venceu!', love.graphics.getWidth()/2 - 40, love.graphics.getHeight()/2 - 5)
    end
  else
    love.graphics.setColor(255, 255, 255)
    love.graphics.draw(background)
    love.graphics.draw(players[1].img, players[1].x, players[1].y, 0, 0.34, 0.34)
    love.graphics.draw(players[2].img, players[2].x, players[2].y, 0, 0.34, 0.34)
    love.graphics.draw(bomba.img, bomba.x, bomba.y, bomba.angulo, 0.12, 0.12)
    love.graphics.print('Força: ' .. (-(bomba.velocidade_inicial)/15)+1, 240, 1)
    love.graphics.draw(barra, 170,1)
    love.graphics.draw(arvore.img, arvore.x, arvore.y, 0, 0.5, 0.5)

    --love.graphics.print('Tam: ' .. #pombos, love.graphics.getWidth()/2 - 40, love.graphics.getHeight() - 20)
    for i, pombo in ipairs(pombos) do
      love.graphics.draw(pombo.img, pombo.x, pombo.y, 0, 0.1, 0.1)
    end
    if bomba.carregando then
      if escala_forca < 117 then
        escala_forca = (((-bomba.velocidade_inicial)/15))
      else        
        lancar()
      end
    end
    love.graphics.draw(forca,187,15,0,escala_forca,1)
  end
end