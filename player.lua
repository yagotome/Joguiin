local exports = {}

exports.newPlayer = function (x, y, nome_imagem)
    local player = {}    
    player.x = x
    player.y = y
    player.speed = 300
    player.img = love.graphics.newImage(nome_imagem)
    player.ground = player.y
    player.y_velocity = 0
    player.jump_height = -300
    player.gravity = -500

    return player
end

return exports