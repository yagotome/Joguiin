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

    -- trabalho-07 - inicio
    pombo.proxDirecao = function()
        while true do
            coroutine.yield('left')
            coroutine.yield('down')
            coroutine.yield('right')
            coroutine.yield('up')
            coroutine.yield('left')
            coroutine.yield('left')
        end
    end

    pombo.distanciaPercorrida = 0

    pombo.move = function(direcao, dt)
        if direcao == 'left' then
            pombo.x = fisica.mu_s(pombo.x, pombo.velocidade, dt)
        elseif direcao == 'right' then
            pombo.x = fisica.mu_s(pombo.x, -pombo.velocidade, dt)
        elseif direcao == 'up' then
            pombo.y = fisica.mu_s(pombo.y, pombo.velocidade, dt)
        elseif direcao == 'down' then
            pombo.y = fisica.mu_s(pombo.y, -pombo.velocidade, dt)
        end
    end
    
    pombo.atualizaEstadoMovimento = coroutine.wrap(pombo.proxDirecao)
    -- trabalho-07 - fim
    
    return pombo 
end

return exports