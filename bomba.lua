local exports = {}
-- Nome: caracteres reservado '{}'
-- Propriedade: semantica
-- Binding time: desenho
-- Explicação: Por decisão de design esses caracteres são construtores de tabela(objeto).

exports.newBomba = function (player)
    local bomba = {}
    bomba.img = love.graphics.newImage('bomba.png')
    bomba.w = bomba.img:getWidth()*0.12
    bomba.h =  bomba.img:getHeight()*0.12
    bomba.atualizaPosicao = function(player)
        if player == players[1] then
          bomba.x = player.x + player.w - 20
        elseif player == players[2] then        
          bomba.x = player.x - bomba.w + 20
        end
        bomba.y = player.y - player.h/2 + 20
    end
    bomba.velocidade_inicial = 0
    bomba.resetaVelocidadeInicial = function()
      bomba.velocidade_inicial = 0
    end
    bomba.atualizaPosicao(player)

    return bomba
-- Nome: Parametro player
-- Propriedade: Tipo
-- Binding time: Execução
-- Explicação: player é um parametro que é recebido em tempo de execução, então seu tipo só pode determinado em tempo de execução 
end

return exports