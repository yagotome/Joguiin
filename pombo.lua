local exports = {}

exports.newPombo = function (x, y)
    local pombo = {}
    pombo.x = x
    pombo.y = y
    pombo.img = love.graphics.newImage('pombo.png')
    pombo.w = pombo.img:getWidth()*0.1
    pombo.h =  pombo.img:getHeight()*0.1
    pombo.velocidade_inicial = 0
    pombo.resetaVelocidadeInicial = function()
        pombo.velocidade_inicial = 0
    end
    pombo.velocidade = -100

    return pombo 
end

return exports