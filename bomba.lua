local exports = {}

exports.newBomba = function (player)
    local bomba = {}
    bomba.img = love.graphics.newImage('bomba.png')
    bomba.w = bomba.img:getWidth()*0.12
    bomba.h =  bomba.img:getHeight()*0.12
    bomba.atualizaPosicao = function(player)
        if player == player1 then
          bomba.x = player.x + player.w - 20
        elseif player == player2 then        
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
end

return exports